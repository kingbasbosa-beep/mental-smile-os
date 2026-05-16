# Clean Core Print/PDF Hidden or Disconnected Actions

This document records actions that look like print, export, share, report, or receipt workflows but are incomplete, hidden, preview-only, or disconnected from a true runtime implementation.

## Preview-Only Print Actions

| File | Action | Classification | Finding |
| --- | --- | --- | --- |
| `lib/features/admin_surface/pages/admin_archive_reports_page.dart` | `Full print` | Disconnected UI action | Opens `_showPrintPreview` with a text dialog. It does not call a print API or generate PDF. |
| `lib/features/admin_surface/pages/admin_archive_reports_page.dart` | `Accounting print` | Disconnected UI action | Opens `_showPrintPreview` with accounting text. It does not create a file or invoke printing. |
| `lib/features/admin_surface/pages/admin_archive_payments_page.dart` | `Print` | Disconnected UI action | Opens a print preview dialog with text lines. No `Printing`, `Pdf`, file, or share runtime is present. |

## Copy-Only Export Actions

| File | Action | Classification | Finding |
| --- | --- | --- | --- |
| `lib/features/admin_surface/pages/admin_archive_reports_page.dart` | `Copy output` | Existing UI action | Copies assistant text output to clipboard, but does not download/export a file. |
| `lib/features/admin_surface/pages/admin_archive_reports_page.dart` | `Copy summary` | Existing UI action | Copies accounting summary text only. |
| `lib/features/admin_surface/pages/admin_archive_reports_page.dart` | `Copy CSV` | Existing UI action | Copies CSV text to clipboard. No file save/download runtime exists. |
| `lib/features/assistant/domain/archive_assistant_engine.dart` | `accountingCsv` | Existing helper | Produces CSV string data, but no persistence/download/share path exists. |

## Report View Without Print/Export

| File | Action | Classification | Finding |
| --- | --- | --- | --- |
| `lib/features/admin_surface/pages/admin_session_report_page.dart` | Unified Admin Report | Existing UI report | Displays full request/session report but has no print, PDF, download, or share action. |
| `lib/features/chat/presentation/pages/chat_escalation_report_page.dart` | Safety escalation report | Existing UI report | Displays Firestore report data but has no print, PDF, download, or share action. |
| `lib/features/admin_surface/pages/admin_registration_maintenance_page.dart` | Registration health report | Existing UI report | Displays health metrics but has no export/print runtime. |

## Role-Gated or Admin-Gated Actions

| File | Action | Classification | Finding |
| --- | --- | --- | --- |
| `lib/features/admin_surface/pages/chat_escalations_page.dart` | `View report` | Hidden by role/permission | Report button appears only for `isAdminUser`. |
| `lib/app/router/app_router.dart` | Admin report routes | Hidden by role/permission | Report/archive routes are included in admin-only route sets. |
| `lib/features/admin_surface/pages/admin_payments_page.dart` | `View report` | Admin UI action | Routes to session report from payment review cards. |

## Operational Link Actions

| File | Action | Classification | Finding |
| --- | --- | --- | --- |
| `lib/features/admin_surface/pages/admin_workspace_command_center_page.dart` | `Save and share`, `Export link` | Host-owned operational/planning action | Uses external/planning links and copy/open helpers. It is not report PDF generation or app-owned file export. |
| `lib/features/admin_surface/pages/admin_device_storage_gateway_page.dart` | `import_export_sync_zone` | Adapter candidate later | Represents a gateway planning zone, not an implemented import/export runtime. |

## Attachment Metadata That Is Not PDF Generation

| File | Signal | Classification | Finding |
| --- | --- | --- | --- |
| `lib/features/centers/presentation/pages/center_form_page.dart` | `PDF | pdf | https://...` example | Existing UI metadata | Indicates center document metadata can describe PDF links. It does not generate PDFs. |
| `lib/features/client/presentation/pages/client_payment_proof_page.dart` | `paymentReceiptFileName`, `paymentReceiptUrl` | Existing receipt metadata | Captures receipt proof references, but no receipt file rendering/export was found. |

## Dead or Missing Callback Findings

No obvious `onPressed: null` print/PDF/report export button was identified in the reviewed report surfaces. The more important issue is semantic disconnection: actions labeled as print/export are currently preview/copy actions, not true print/PDF/download runtime actions.

## Recovery Priority

1. Rename or clarify preview-only labels if needed.
2. Decide whether print recovery means browser/native print, generated PDF, file download, share sheet, or all of these.
3. Keep all runtime implementation in the host app.
4. Add clean_core contracts only after host-owned runtime boundaries are agreed.
