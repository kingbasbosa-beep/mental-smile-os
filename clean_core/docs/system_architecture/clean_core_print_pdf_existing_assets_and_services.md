# Clean Core Print/PDF Existing Assets and Services

This inventory lists discovered report, print-preview, receipt, export, and admin reporting assets. It is documentation only; no implementation was changed.

## Dependency Inventory

The root `pubspec.yaml` does not currently declare:

- `pdf`
- `printing`
- `share_plus`
- `path_provider`
- `open_file`

Declared dependencies include Flutter, Firebase, shared preferences, URL launcher, UUID, geolocation, and analytics. Therefore current print/export behavior cannot rely on PDF generation, native print, native share, path writing, or open-file behavior unless implemented elsewhere without package declarations, which was not found in the reviewed scan.

## Existing Services and Helpers

| Service/Helper | File | Runtime Owner | Current Capability |
| --- | --- | --- | --- |
| Archive assistant engine | `lib/features/assistant/domain/archive_assistant_engine.dart` | Host app | Produces summary, stats, analysis, monthly report, clinician performance, center operations, accounting lines, accounting rows, and CSV strings. |
| Chat Firestore service | `lib/features/chat/data/services/chat_firestore_service.dart` | Host app/backend | Creates and fetches safety escalation report documents in Firestore. |
| Booking ownership inventory | `lib/dev/booking_ownership_inventory.dart` | Dev/debug host app | Formats inventory text and sends it to `debugPrint`. |

## Existing UI Report Pages

| UI Surface | File | Current Behavior |
| --- | --- | --- |
| Reports Archive | `lib/features/admin_surface/pages/admin_archive_reports_page.dart` | Firestore-backed archive dashboard with filtering, assistant report output, copy output, copy CSV, full report preview, and accounting preview. |
| Payments Archive | `lib/features/admin_surface/pages/admin_archive_payments_page.dart` | Payment archive list with financial print preview dialog. |
| Session Report | `lib/features/admin_surface/pages/admin_session_report_page.dart` | Unified admin request report view with payment, session/residency, review, and rating details. |
| Chat Escalation Report | `lib/features/chat/presentation/pages/chat_escalation_report_page.dart` | Safety escalation report viewer loaded by escalation id. |
| Registration Maintenance | `lib/features/admin_surface/pages/admin_registration_maintenance_page.dart` | Registration health report page for clinician, center, and client account readiness. |

## Existing Route Assets

| Route | File | Notes |
| --- | --- | --- |
| `Routes.adminArchiveReports` | `lib/app/router/routes.dart`, `lib/app/router/app_router.dart` | Reports archive route is registered and admin-gated. |
| `Routes.adminSessionReport` | `lib/app/router/routes.dart`, `lib/app/router/app_router.dart` | Session/request report route is registered and admin-gated. |
| `Routes.chatEscalationReport` | `lib/app/router/routes.dart`, `lib/app/router/app_router.dart` | Chat escalation report route is registered and admin-gated. |

## Existing Receipt and Billing Signals

| Area | File | Finding |
| --- | --- | --- |
| Client payment proof | `lib/features/client/presentation/pages/client_payment_proof_page.dart` | Captures `paymentReceiptFileName`, `paymentReceiptUrl`, and payment note fields. |
| My bookings | `lib/features/booking/presentation/pages/my_bookings_page.dart` | Displays payment proof reference when available. |
| Admin payments | `lib/features/admin_surface/pages/admin_payments_page.dart` | Reads receipt filename and routes to session report. |
| Admin archive accounting | `lib/features/admin/presentation/pages/admin_archive_accounting_page.dart` | Displays payment receipt references in archived accounting contexts. |
| Admin archive payments | `lib/features/admin_surface/pages/admin_archive_payments_page.dart` | Displays receipt filename and includes financial print preview. |

## Asset-Like Findings

No dedicated printable template assets, invoice templates, PDF templates, downloaded files, or generated report assets were found in the reviewed scan. Existing "export link" fields in admin workspace pages are operational/planning links, not app-generated export assets.

## Ownership Classification

- Existing report views: host-app owned.
- Existing Firestore report records: host/backend owned.
- Existing copy-to-clipboard CSV/text: host-app UI utility.
- Existing print previews: host-app UI utility.
- Future PDF/print/share/download: host-app runtime feature.
- Future clean_core role: adapter contract and governance intent only.
