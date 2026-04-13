from __future__ import annotations

import json
import os
import socket
from dataclasses import dataclass, field
from datetime import UTC, datetime
from pathlib import Path
from typing import Any

import firebase_admin
from dotenv import load_dotenv
from firebase_admin import credentials, firestore

try:
    from rich.console import Console
    from rich.table import Table
except Exception:  # pragma: no cover
    Console = None
    Table = None


BASE_DIR = Path(__file__).resolve().parent
REPORTS_DIR = BASE_DIR / "reports"
ENV_PATH = BASE_DIR / ".env"

ALLOWED_CENTER_CATEGORIES = {
    "recovery",
    "detox",
    "special_needs",
    "hospital",
}

ALLOWED_CENTER_REQUEST_STATUSES = {
    "pending_admin",
    "center_follow_up",
    "client_update_required",
    "awaiting_payment",
    "rejected_admin",
}


@dataclass
class Issue:
    severity: str
    collection: str
    document_id: str
    field: str
    message: str


@dataclass
class AuditResult:
    project_id: str | None
    generated_at: str
    summary: dict[str, Any] = field(default_factory=dict)
    issues: list[Issue] = field(default_factory=list)
    warnings: list[str] = field(default_factory=list)

    def add_issue(
        self,
        *,
        severity: str,
        collection: str,
        document_id: str,
        field: str,
        message: str,
    ) -> None:
        self.issues.append(
            Issue(
                severity=severity,
                collection=collection,
                document_id=document_id,
                field=field,
                message=message,
            )
        )

    def as_dict(self) -> dict[str, Any]:
        return {
            "project_id": self.project_id,
            "generated_at": self.generated_at,
            "summary": self.summary,
            "warnings": self.warnings,
            "issues": [issue.__dict__ for issue in self.issues],
        }


def get_console() -> Any:
    if Console is not None:
        return Console()
    return None


def print_line(text: str) -> None:
    rich_console = get_console()
    if rich_console is not None:
        rich_console.print(text)
    else:
        print(text)


def load_environment() -> tuple[Path | None, str | None]:
    if ENV_PATH.exists():
        load_dotenv(ENV_PATH)
    else:
        load_dotenv()

    raw_cred = os.getenv("QA_FIREBASE_SERVICE_ACCOUNT") or os.getenv(
        "GOOGLE_APPLICATION_CREDENTIALS"
    )
    project_id = os.getenv("QA_FIREBASE_PROJECT_ID") or os.getenv(
        "GOOGLE_CLOUD_PROJECT"
    )
    cred_path = Path(raw_cred).expanduser() if raw_cred else None
    return cred_path, project_id


def init_firestore(cred_path: Path | None, project_id: str | None):
    if cred_path is None:
        raise FileNotFoundError(
            "Missing service account path. Set QA_FIREBASE_SERVICE_ACCOUNT "
            "or GOOGLE_APPLICATION_CREDENTIALS."
        )
    if not cred_path.exists():
        raise FileNotFoundError(f"Service account file not found: {cred_path}")

    if firebase_admin._apps:
        app = firebase_admin.get_app()
    else:
        options = {"projectId": project_id} if project_id else None
        app = firebase_admin.initialize_app(
            credentials.Certificate(str(cred_path)),
            options=options,
        )

    return firestore.client(app=app)


def precheck_firestore_network() -> None:
    try:
        with socket.create_connection(("firestore.googleapis.com", 443), timeout=10):
            return
    except OSError as exc:
        raise ConnectionError(
            "NETWORK BLOCKED: Unable to open a connection to "
            "firestore.googleapis.com:443. "
            f"Local socket error: {exc}"
        ) from exc


def is_non_empty_string(value: Any) -> bool:
    return isinstance(value, str) and value.strip() != ""


def is_number(value: Any) -> bool:
    return isinstance(value, (int, float)) and not isinstance(value, bool)


def audit_centers(db, result: AuditResult) -> None:
    docs = list(db.collection("centers").stream())
    result.summary["centers_count"] = len(docs)

    for doc in docs:
        data = doc.to_dict() or {}
        if not isinstance(data.get("isActive"), bool):
            result.add_issue(
                severity="blocker",
                collection="centers",
                document_id=doc.id,
                field="isActive",
                message="isActive is missing or not a bool.",
            )
        if not is_non_empty_string(data.get("approvalStatus")):
            result.add_issue(
                severity="blocker",
                collection="centers",
                document_id=doc.id,
                field="approvalStatus",
                message="approvalStatus is missing or empty.",
            )
        category = data.get("category")
        if not is_non_empty_string(category):
            result.add_issue(
                severity="blocker",
                collection="centers",
                document_id=doc.id,
                field="category",
                message="category is missing or empty.",
            )
        elif category not in ALLOWED_CENTER_CATEGORIES:
            result.add_issue(
                severity="blocker",
                collection="centers",
                document_id=doc.id,
                field="category",
                message=f"category '{category}' is outside the allowed UI categories.",
            )
        if not is_number(data.get("sortOrder")):
            result.add_issue(
                severity="blocker",
                collection="centers",
                document_id=doc.id,
                field="sortOrder",
                message="sortOrder is missing or not numeric.",
            )
        if not (
            is_non_empty_string(data.get("centerName"))
            or is_non_empty_string(data.get("name"))
        ):
            result.add_issue(
                severity="blocker",
                collection="centers",
                document_id=doc.id,
                field="centerName/name",
                message="Neither centerName nor name is populated.",
            )
        if not is_non_empty_string(data.get("email")):
            result.add_issue(
                severity="blocker",
                collection="centers",
                document_id=doc.id,
                field="email",
                message="email is missing or empty.",
            )


def audit_admins(db, result: AuditResult) -> None:
    docs = list(db.collection("admins").stream())
    result.summary["admins_count"] = len(docs)

    if not docs:
        result.add_issue(
            severity="blocker",
            collection="admins",
            document_id="-",
            field="active",
            message="No admin documents found.",
        )
        return

    for doc in docs:
        data = doc.to_dict() or {}
        if not isinstance(data.get("active"), bool):
            result.add_issue(
                severity="blocker",
                collection="admins",
                document_id=doc.id,
                field="active",
                message="active is missing or not a bool.",
            )


def audit_booking_requests(db, result: AuditResult) -> None:
    docs = list(db.collection("booking_requests").stream())
    result.summary["booking_requests_count"] = len(docs)

    for doc in docs:
        data = doc.to_dict() or {}
        required_string_fields = [
            "requestKind",
            "clientId",
            "centerId",
            "status",
        ]
        for field_name in required_string_fields:
            if not is_non_empty_string(data.get(field_name)):
                result.add_issue(
                    severity="blocker",
                    collection="booking_requests",
                    document_id=doc.id,
                    field=field_name,
                    message=f"{field_name} is missing or empty.",
                )
        for field_name in ["createdAt", "updatedAt"]:
            if data.get(field_name) is None:
                result.add_issue(
                    severity="blocker",
                    collection="booking_requests",
                    document_id=doc.id,
                    field=field_name,
                    message=f"{field_name} is missing.",
                )

        if "assignedCenterId" in data and is_non_empty_string(data.get("assignedCenterId")):
            result.add_issue(
                severity="warning",
                collection="booking_requests",
                document_id=doc.id,
                field="assignedCenterId",
                message="Legacy assignedCenterId is populated; current contract uses centerId.",
            )

        request_kind = str(data.get("requestKind", "")).strip()
        if request_kind == "center":
            if not is_non_empty_string(data.get("centerName")):
                result.add_issue(
                    severity="blocker",
                    collection="booking_requests",
                    document_id=doc.id,
                    field="centerName",
                    message="centerName is missing or empty for a center request.",
                )
            status = str(data.get("status", "")).strip()
            if status not in ALLOWED_CENTER_REQUEST_STATUSES:
                result.add_issue(
                    severity="blocker",
                    collection="booking_requests",
                    document_id=doc.id,
                    field="status",
                    message=f"status '{status}' is outside the center-flow contract.",
                )


def audit_legacy_collection(db, result: AuditResult) -> None:
    docs = list(db.collection("bookingRequests").limit(20).stream())
    result.summary["legacy_bookingRequests_sample_count"] = len(docs)
    if docs:
        result.warnings.append(
            f"Legacy collection bookingRequests still has at least {len(docs)} document(s) in the sample."
        )


def save_report(result: AuditResult) -> Path:
    REPORTS_DIR.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now(UTC).strftime("%Y%m%dT%H%M%SZ")
    report_path = REPORTS_DIR / f"qa_audit_{stamp}.json"
    report_path.write_text(
        json.dumps(result.as_dict(), ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    return report_path


def save_latest_report_summary(result: AuditResult) -> Path:
    REPORTS_DIR.mkdir(parents=True, exist_ok=True)
    latest_report_path = REPORTS_DIR / "latest_report.json"
    latest_report_path.write_text(
        json.dumps(
            {
                "status": "ok",
                "issues_count": len(result.issues),
                "checked_collections": ["centers"],
                "timestamp": datetime.now(UTC).isoformat(),
            },
            ensure_ascii=False,
            indent=2,
        ),
        encoding="utf-8",
    )
    return latest_report_path


def print_summary(result: AuditResult, report_path: Path) -> None:
    rich_console = get_console()
    if rich_console is not None and Table is not None:
        table = Table(title="Mental Smile QA Audit")
        table.add_column("Metric")
        table.add_column("Value")
        for key, value in result.summary.items():
            table.add_row(key, str(value))
        table.add_row("issues", str(len(result.issues)))
        table.add_row("warnings", str(len(result.warnings)))
        table.add_row("report", str(report_path))
        rich_console.print(table)
    else:
        print_line("Mental Smile QA Audit")
        for key, value in result.summary.items():
            print_line(f"- {key}: {value}")
        print_line(f"- issues: {len(result.issues)}")
        print_line(f"- warnings: {len(result.warnings)}")
        print_line(f"- report: {report_path}")

    for issue in result.issues:
        print_line(
            f"[{issue.severity}] {issue.collection}/{issue.document_id} "
            f"{issue.field}: {issue.message}"
        )
    for warning in result.warnings:
        print_line(f"WARNING: {warning}")


def main() -> int:
    cred_path, project_id = load_environment()
    result = AuditResult(
        project_id=project_id,
        generated_at=datetime.now(UTC).isoformat(),
    )

    try:
        db = init_firestore(cred_path, project_id)
    except Exception as exc:
        print_line(f"QA_AUDIT BLOCKED: {exc}")
        print_line(
            "Expected env: QA_FIREBASE_SERVICE_ACCOUNT=tools/qa_bot/service-account.json"
        )
        print_line("Optional env: QA_FIREBASE_PROJECT_ID=mental-smile-app-clean")
        return 2

    try:
        precheck_firestore_network()
    except Exception as exc:
        print_line(str(exc))
        print_line(
            r"Windows test: powershell -Command ""Test-NetConnection firestore.googleapis.com -Port 443"""
        )
        return 3

    audit_centers(db, result)
    audit_admins(db, result)
    audit_booking_requests(db, result)
    audit_legacy_collection(db, result)
    report_path = save_report(result)
    save_latest_report_summary(result)
    print_summary(result, report_path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
