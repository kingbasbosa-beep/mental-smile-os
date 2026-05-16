# Clean Core Print/PDF Host-Owned Recovery Plan

This plan defines how print, PDF, receipt, invoice, report export, share, and download features should be recovered without contaminating extracted clean_core contracts.

## Recovery Ownership

Print/PDF/report export is host-owned because it requires Flutter UI, platform/browser capabilities, Firebase data access, optional file writing, optional sharing, and privacy-aware rendering. It must not become runtime behavior inside `mental_smile_clean_core`.

## Host-Owned Recovery Areas

| Recovery Area | Host-Owned Reason | Notes |
| --- | --- | --- |
| Native/browser print | Requires Flutter/platform/browser runtime. | Keep outside clean_core. |
| PDF generation | Requires rendering/package dependency and possible fonts/assets. | Future `pdf`/`printing` dependencies should remain host app dependencies. |
| File download/save | Requires platform/web file handling. | Keep host-owned; clean_core may define export intent shape later. |
| Share sheet | Requires platform plugin. | Keep host-owned. |
| Receipt/invoice rendering | Requires payment data, privacy rules, and UI/template rendering. | Backend/host governed. |
| Admin reports | Requires Firestore reads, role visibility, and sensitive report controls. | Host app/admin owned. |
| Safety escalation reports | Requires sensitive Firestore data and admin access. | Backend/host governed with strict visibility. |

## Recommended Recovery Order

1. Inventory current preview-only print buttons and report routes.
2. Confirm target behavior for each action: preview, print, PDF, CSV download, copy, or share.
3. Introduce a host-owned report rendering boundary, not a clean_core runtime.
4. Add host-owned PDF/print implementation only after dependency approval.
5. Keep receipt/invoice templates separate from clean_core contracts.
6. Add privacy review for reports containing client, payment, review, escalation, or safety data.
7. Add admin-only visibility checks around any printable sensitive data.
8. Reconnect UI buttons one by one; avoid broad UI refactors.

## Candidate Host Services

These are future host app concepts only:

- `AdminReportPreviewService`
- `AdminReportPdfRenderer`
- `PaymentReceiptRenderer`
- `InvoiceExportService`
- `ArchiveCsvExportService`
- `SafetyEscalationReportExporter`
- `ReportShareService`

No service was created in this phase.

## Privacy and Governance Rules

- Sensitive reports should use sanitized previews by default.
- Raw crisis or escalation content should not be casually printable.
- Payment receipts should avoid exposing unnecessary identifiers.
- Report export should require admin/review authority where sensitive.
- Export actions should produce audit signals later if operationally required.
- Missing authority must fail closed.
- No client-side privileged approval or report-verdict authority should be introduced.

## clean_core Boundary

clean_core may later define:

- report export intent contracts
- report visibility scopes
- export block reasons
- print/PDF adapter contract shapes
- audit reference contracts
- privacy rule contracts

clean_core must not define:

- PDF rendering implementation
- Flutter widgets
- Firebase reads/writes
- platform printing
- file downloads
- share runtime
- report route navigation

## Immediate Recovery Candidates

| Current Surface | Recovery Path |
| --- | --- |
| Reports Archive full/accounting print previews | Convert preview-only action to host-owned print/PDF/export action after dependency approval. |
| Payments Archive print preview | Add host-owned payment summary print/PDF renderer after privacy review. |
| Admin Session Report | Add host-owned print/export action if report page remains the canonical printable view. |
| Chat Escalation Report | Add export only after safety/privacy review; default should remain restricted and sanitized. |
| Archive Assistant CSV | Convert copy-only CSV into host-owned download/export after file handling strategy is approved. |

## Non-Goals

- No UI fixes in this phase.
- No package additions in this phase.
- No Firebase changes in this phase.
- No clean_core runtime implementation.
- No provider execution.
