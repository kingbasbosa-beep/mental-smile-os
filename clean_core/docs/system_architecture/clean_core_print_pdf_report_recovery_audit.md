# Clean Core Print/PDF/Report Recovery Audit

EX-19 documents the current print, PDF, invoice, receipt, report export, and admin printable action surfaces before any UI recovery work. This audit did not move files, rewrite imports, activate runtime systems, add packages, or run Flutter/pub commands.

## Scope Reviewed

- Host app report and archive pages under `lib/features/admin_surface/`.
- Chat escalation report surfaces under `lib/features/chat/`.
- Archive assistant reporting logic under `lib/features/assistant/domain/`.
- Booking/payment receipt references under booking, payment, and archive pages.
- Debug reporting helper under `lib/dev/`.
- Package dependency declarations in `pubspec.yaml`.

## Executive Findings

The host app already contains several report viewing and print-preview surfaces, but no true PDF generation, OS print integration, file download, share sheet, or open-file workflow was found in the reviewed surfaces.

Current reporting behavior is mostly:

- in-app report views
- in-app print preview dialogs using `SelectableText`
- copied text/CSV output through the clipboard
- Firestore-backed report reads/writes for chat escalation reports
- payment receipt filename/reference display
- debug-only inventory printing through `debugPrint`

No `pdf`, `printing`, `share_plus`, `path_provider`, or `open_file` dependency is declared in the root `pubspec.yaml`.

## Existing Report Surfaces

| Area | File | Classification | Finding |
| --- | --- | --- | --- |
| Admin Reports Archive | `lib/features/admin_surface/pages/admin_archive_reports_page.dart` | Existing UI action | Report archive includes assistant summaries, accounting CSV copy, full report print preview, and accounting print preview. |
| Admin Payments Archive | `lib/features/admin_surface/pages/admin_archive_payments_page.dart` | Existing UI action | Financial archive items expose a `Print` action that opens a text preview dialog. |
| Admin Session Report | `lib/features/admin_surface/pages/admin_session_report_page.dart` | Existing UI report | Unified request/session report page exists, but no print/PDF/share/download action is present inside the page. |
| Admin Payments | `lib/features/admin_surface/pages/admin_payments_page.dart` | Existing UI action | Payment cards include a `View report` action that routes to `Routes.adminSessionReport`. |
| Reports Archive Route | `lib/app/router/routes.dart`, `lib/app/router/app_router.dart` | Existing route | `Routes.adminArchiveReports` and `Routes.adminSessionReport` are registered host-app routes. |
| Chat Escalation Report | `lib/features/chat/presentation/pages/chat_escalation_report_page.dart` | Existing UI report | Safety escalation report page loads latest report data for an escalation id. |
| Chat Escalations | `lib/features/admin_surface/pages/chat_escalations_page.dart` | Hidden by role/permission | `View report` action is visible only when `isAdminUser` is true. |
| Chat Firestore Service | `lib/features/chat/data/services/chat_firestore_service.dart` | Existing service | Creates and fetches safety escalation report records under escalation report subcollections. |
| Archive Assistant Engine | `lib/features/assistant/domain/archive_assistant_engine.dart` | Existing report/export helper | Produces report lines, accounting rows, and accounting CSV strings from archive data. |
| Debug Inventory | `lib/dev/booking_ownership_inventory.dart` | Existing debug service | Formats a booking ownership inventory report and prints it with `debugPrint`. |

## Missing Runtime Capabilities

- No true PDF generator was found.
- No OS/browser print runtime was found.
- No share-sheet runtime was found.
- No file download runtime was found.
- No local file open runtime was found.
- No invoice generation service was found.
- No receipt document generation service was found.
- No export file writer was found.

## Extraction Boundary Finding

All discovered print/PDF/report actions are host-owned runtime/UI concerns. They should not be moved into `mental_smile_clean_core` as executable features. Future clean_core participation should be limited to inert report/export intent contracts, audit references, privacy rules, and adapter contract shapes.

## Recovery Verdict

The print/PDF/report system is recoverable, but the recovery should happen after extraction as host-app work. Current actions should be treated as disconnected or preview-only rather than production print/PDF/export features.
