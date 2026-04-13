from __future__ import annotations

import json
import os
from datetime import UTC, datetime
from pathlib import Path

import firebase_admin
from dotenv import load_dotenv
from firebase_admin import credentials, firestore


BASE_DIR = Path(__file__).resolve().parent
REPORTS_DIR = BASE_DIR / "reports"
ENV_PATH = BASE_DIR / ".env"


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


def count_by_status(db, status: str) -> int:
    docs = db.collection("booking_requests").where("status", "==", status).stream()
    return sum(1 for _ in docs)


def build_snapshot(
    *,
    center_follow_up_count: int,
    client_update_required_count: int,
    payout_pending_count: int,
) -> dict[str, object]:
    alerts_count = (
        center_follow_up_count
        + client_update_required_count
        + payout_pending_count
    )
    status = "ok" if alerts_count == 0 else "warning"
    severity = "low" if alerts_count == 0 else "medium"
    summary = (
        "No critical center-cycle alerts"
        if alerts_count == 0
        else f"{alerts_count} center-cycle alerts need attention"
    )

    return {
        "status": status,
        "severity": severity,
        "source": "audit_center_followup.py",
        "timestamp": datetime.now(UTC).isoformat(),
        "summary": summary,
        "alertsCount": alerts_count,
        "centerFollowUpCount": center_follow_up_count,
        "clientUpdateRequiredCount": client_update_required_count,
        "payoutPendingCount": payout_pending_count,
    }


def save_local_report(snapshot: dict[str, object]) -> Path:
    REPORTS_DIR.mkdir(parents=True, exist_ok=True)
    report_path = REPORTS_DIR / "latest_center_followup_alerts.json"
    report_path.write_text(
        json.dumps(snapshot, ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
    return report_path


def write_firestore_snapshot(db, snapshot: dict[str, object]) -> None:
    db.collection("system_alerts").document("latest").set(snapshot)


def main() -> int:
    cred_path, project_id = load_environment()
    db = init_firestore(cred_path, project_id)

    center_follow_up_count = count_by_status(db, "center_follow_up")
    client_update_required_count = count_by_status(db, "client_update_required")
    payout_pending_count = count_by_status(db, "payout_pending")

    snapshot = build_snapshot(
        center_follow_up_count=center_follow_up_count,
        client_update_required_count=client_update_required_count,
        payout_pending_count=payout_pending_count,
    )

    save_local_report(snapshot)
    write_firestore_snapshot(db, snapshot)
    print("Center follow-up alerts snapshot updated.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
