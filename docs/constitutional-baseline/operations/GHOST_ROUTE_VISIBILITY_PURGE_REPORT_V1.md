# Ghost Route Visibility Purge Report V1

Operation ID: OP-PACKAGE-C-GHOST-ROUTE-VISIBILITY-PURGE-V1
Date: 2026-06-18
Execution Mode: ROUTE VISIBILITY REMOVAL / PLACEHOLDER HIDING
Runtime Effect: archived ghost placeholder routes removed from normal routing/navigation visibility
Firebase Effect: none
Git Effect: none

## Source Authority

- `docs/constitutional-baseline/guides/GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md`
- `OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1`

## Routes Hidden / Removed

- `/s/capital/incidents`
- `/s/capital/maintenance`
- `/s/capital/broadcasts`
- `/s/capital/emergency-brief`
- `/request/service`
- `/request/package`

## Navigation Links Removed

- Capital operations navigation links:
  - Incidents
  - Maintenance
  - Broadcasts
  - Emergency Brief
- Portal navigation links:
  - Services
  - Packages
- Portal home action:
  - Request Service

## Route Constants / Router Cases Removed

- Removed constants from `lib/app/router/routes.dart`.
- Removed router cases from `lib/app/router/app_router.dart`.
- Removed public portal service/package intake pages from `portal_skeleton_pages.dart`.
- Removed Capital ghost focus entries, placeholder panels, and overview counters from `s_capital_operations_office_page.dart`.

## Construction-Only Routes Retained

None of the six immediate ghost route candidates were retained as construction-only routes.

## Owner-Decision Routes Left Untouched

- `/s/city/tools`
- `/s/city/programs`
- `/s/city/marketplace`
- `/s/capital/departments`
- `/s/capital/trust-safety`
- `/s/capital/reports`
- `/contact`

## Active Routes Left Untouched

- Provider identity/routes.
- Center identity/routes.
- Owner identity/routes.
- Monitoring identity and `/s/capital/signal-monitoring-room`.
- Active accessibility routes.
- Client Session Room.

## Runtime Files Modified

- `lib/app/router/routes.dart`
- `lib/app/router/app_router.dart`
- `lib/features/web_portal/presentation/pages/portal_skeleton_pages.dart`
- `lib/features/s_capital/presentation/pages/s_capital_operations_office_page.dart`

## Registries Updated

- Route Registry
- Domain Boundary Registry
- Monitoring Authority Registry
- Archive Registry
- Finding Registry
- Memory Registry
- Operations Registry
- Operations Index

## Verification Performed

Text search confirmed no active `lib` references remain for:

- `/s/capital/incidents`
- `/s/capital/maintenance`
- `/s/capital/broadcasts`
- `/s/capital/emergency-brief`
- `/request/service`
- `/request/package`
- `Routes.sCapitalIncidents`
- `Routes.sCapitalMaintenance`
- `Routes.sCapitalBroadcasts`
- `Routes.sCapitalEmergencyBrief`
- `Routes.portalServiceRequest`
- `Routes.portalPackageRequest`

## Blockers

No blocker found for the six requested ghost route visibility candidates.

## Manual Commands Required

Owner should run:

```text
dart format lib/app/router/routes.dart lib/app/router/app_router.dart lib/features/web_portal/presentation/pages/portal_skeleton_pages.dart lib/features/s_capital/presentation/pages/s_capital_operations_office_page.dart
flutter analyze
flutter build apk --debug
flutter build web
```

## Final Verdict

GHOST_ROUTE_VISIBILITY_PURGED_PENDING_OWNER_VERIFICATION
