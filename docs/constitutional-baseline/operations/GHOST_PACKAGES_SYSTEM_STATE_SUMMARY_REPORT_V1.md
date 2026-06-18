# Ghost Packages System State Summary Report V1

Operation ID: OP-GHOST-PACKAGES-SYSTEM-STATE-SUMMARY-REPORT-V1
Date: 2026-06-18
Execution Mode: AUDIT SUMMARY / DOCUMENTATION ONLY
Runtime Effect: none
Firebase Effect: none
Git Effect: none

## 1. Executive Summary

This report summarizes the recent governance and ghost infrastructure operations from OP-060 through OP-066.

The system moved from a post-client-extraction state with ghost routes, ghost signals, unbundled client-era assets, and Owner-decision placeholders into a cleaner state where:

- Ghost signals were removed from active runtime.
- Archived ghost asset folders were removed from disk.
- Ghost route visibility was removed from normal navigation/router access.
- A permanent card coverage rule was created.
- Owner-decision items remain documented, not silently removed.

Final summary status:

- Operations registered: 66
- Registry files present: 28
- File-backed cards present: 18
- Embedded ghost archival cards present: 26
- Card Coverage Gap Registry status: active
- Current explicit missing-card gaps: none found beyond the baseline registry entry
- Owner-decision items still open: yes
- Firebase deploy performed: no
- Git commit/push/tag performed: no

## 2. Operations Covered

| Operation | Status | Effect |
| --- | --- | --- |
| OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1 | GHOST_INFRASTRUCTURE_FOUND | Found ghost routes, signals, assets, collections, localization, and workflow risks. |
| OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1 | GHOST_ARCHIVAL_GUIDE_READY_FOR_REMOVAL | Created one unified archival guide with compact cards before removal. |
| OP-PERMANENT-SYSTEM-CARD-COVERAGE-RULE-V1 | PERMANENT_SYSTEM_CARD_COVERAGE_RULE_ACTIVE | Made card/registry coverage mandatory for every active system item. |
| OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1 | GHOST_SIGNALS_REMOVED_PENDING_OWNER_VERIFICATION | Removed five ghost signals from active runtime references. |
| OP-PACKAGE-B-GHOST-ASSET-YAML-PURGE-V1 | GHOST_ASSETS_REMOVED_PENDING_OWNER_VERIFICATION | Removed three archived ghost asset folder groups from disk. |
| OP-PACKAGE-C-GHOST-ROUTE-VISIBILITY-PURGE-V1 | GHOST_ROUTE_VISIBILITY_PURGED_PENDING_OWNER_VERIFICATION | Removed six ghost placeholder routes from normal router/navigation visibility. |
| OP-GHOST-PACKAGES-SYSTEM-STATE-SUMMARY-REPORT-V1 | IN_PROGRESS at report creation | Creates this consolidated state report. |

## 3. System Before Recent Package Operations

Before Packages A, B, and C, the system had:

- Five ghost signal types still connected in runtime registries/factories/validators:
  - `communication_preference_selected`
  - `goal_selected`
  - `interest_selected`
  - `accessibility_interest`
  - `accessibility_mode_selected`
- Three archived client-era asset groups still present on disk:
  - `assets/branding/client_dashboard/**`
  - `assets/branding/web_registration/clients/**`
  - `assets/images/client_dashboard/actions/**`
- Six ghost placeholder routes still visible through route constants/router cases/navigation:
  - `/s/capital/incidents`
  - `/s/capital/maintenance`
  - `/s/capital/broadcasts`
  - `/s/capital/emergency-brief`
  - `/request/service`
  - `/request/package`
- Owner-decision surfaces still present and intentionally not removed.
- Firebase Hosting workflow/target questions still open.
- Localization client/admin residue still present.

## 4. System After Recent Package Operations

After Packages A, B, and C:

- The five ghost signals are removed from active `lib` references.
- The three archived asset folder groups are deleted from disk.
- The six ghost routes are removed from normal route/navigation visibility.
- C5/C6 assets were inspected only and left untouched.
- Active provider, center, owner, monitoring, accessibility, and client session room routes were preserved.
- Owner-decision routes were left untouched.
- Reports and registries now mark the purged items as removed from runtime, disk, or router/navigation.

## 5. Card Inventory

### File-Backed Cards

Total file-backed cards under `docs/constitutional-baseline/cards`: 18

| Card Section | Count | Path |
| --- | ---: | --- |
| Archive cards | 10 | `docs/constitutional-baseline/cards/archive/` |
| Decision cards | 8 | `docs/constitutional-baseline/cards/decision/` |

File-backed archive cards:

- `ARCHIVE_CARD_ADMIN_ZERO_TRANSITION_V1.md`
- `ARCHIVE_CARD_BOOKING_EXTRACTION_V1.md`
- `ARCHIVE_CARD_C5_BOOKING_ERA_V1.md`
- `ARCHIVE_CARD_C6_LIBRARY_ERA_V1.md`
- `ARCHIVE_CARD_CLIENT_LOGIN_REGISTER_DASHBOARD_EXTRACTION_V1.md`
- `ARCHIVE_CARD_CLIENT_LOGIN_REGISTRATION_PROFILE_LEGACY_V1.md`
- `ARCHIVE_CARD_CLIENT_PROFILE_COMPLEXITY_V1.md`
- `ARCHIVE_CARD_OLD_REPOSITORY_LINEAGE_V1.md`
- `ARCHIVE_CARD_PROVIDER_VS_CLINICIAN_V1.md`
- `ARCHIVE_CARD_PURE_CLIENT_IDENTITY_HARD_REMOVAL_V1.md`

File-backed decision cards:

- `ACCESSIBILITY_TV_EXECUTION_DECISION_V1.md`
- `ACCESSIBLE_COMMUNICATION_EXECUTION_DECISION_V1.md`
- `CLIENT_ACCESS_EXECUTION_DECISION_V1.md`
- `CLIENT_IDENTITY_EXTRACTION_DECISION_V1.md`
- `CONSTITUTIONAL_OPERATION_LOGGING_DIRECTIVE_V1.md`
- `PARTNERSHIP_FOUNDATION_DECISION_V1.md`
- `PERMANENT_SYSTEM_CARD_COVERAGE_RULE_V1.md`
- `PHASE_OPERATION_GOVERNANCE_REINFORCEMENT_DECISION_V1.md`

### Embedded Operational Archive Cards

Total embedded compact cards inside `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md`: 26

Groups:

- Ghost Route Cards
- Ghost Page Cards
- Ghost Rule / Collection Cards
- Ghost Signal Cards
- Ghost Asset / YAML Cards
- Ghost Localization Cards
- Ghost Workflow / Hosting Cards

Current status of embedded ghost package card groups:

| Group | Status |
| --- | --- |
| Ghost Route Cards | REMOVED_FROM_ROUTER_AND_NAVIGATION |
| Ghost Signal Cards | REMOVED_FROM_RUNTIME |
| Ghost Asset Cards | REMOVED_FROM_DISK |
| Owner Decision Cards | OWNER_DECISION_REQUIRED |

## 6. What Currently Has No Card

Current evidence-based answer:

- No explicit active uncovered system item was found in this summary pass.
- `CARD_COVERAGE_GAP_REGISTRY_V1.md` contains only its baseline entry.
- No row currently marks a real runtime item as `ACTIVE_WITH_MISSING_CARD`, `GHOST_WITH_MISSING_CARD`, or `LEGACY_WITH_MISSING_CARD`.

Important distinction:

- Several active or present items still require Owner decisions.
- These are not "missing card" items because they are covered by `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` and registry entries.

Owner-decision covered items:

| Item | Current coverage | Status |
| --- | --- | --- |
| `saved_destinations` | Collection Registry, Signal registries, Ghost Archival Guide | OWNER_DECISION_REQUIRED |
| `destination_saved` | Signal Governance Registry, Signal Ownership Registry, Ghost Archival Guide | OWNER_DECISION_REQUIRED |
| `.github/workflows/firebase-hosting-*.yml` | Asset Registry, Ghost Archival Guide | OWNER_DECISION_REQUIRED |
| Firebase hosting target `public-landing` | Asset Registry, Ghost Archival Guide | OWNER_DECISION_REQUIRED |
| `/s/city/tools`, `/s/city/programs`, `/s/city/marketplace` | Route Registry, Domain Boundary Registry, Ghost Archival Guide | OWNER_DECISION_REQUIRED |
| `/s/capital/departments`, `/s/capital/trust-safety`, `/s/capital/reports` | Route Registry, Domain Boundary Registry, Ghost Archival Guide | OWNER_DECISION_REQUIRED |
| `/contact` | Domain Boundary Registry / Ghost Archival Guide owner-decision note | OWNER_DECISION_REQUIRED |
| Localization client/admin residue | Ghost Archival Guide | OWNER_DECISION_REQUIRED |
| `signal_aggregates` lifecycle | Collection Registry / Ghost Archival Guide | OWNER_DECISION_REQUIRED |
| `ai_policies` collection/rule path | Collection Registry / Ghost Archival Guide | OWNER_DECISION_REQUIRED |

## 7. Operations Registry Status

Operations Index count: 66 operations.

Current last operation:

- `066 | OP-GHOST-PACKAGES-SYSTEM-STATE-SUMMARY-REPORT-V1`

Recent operation statuses:

- OP-060: `GHOST_INFRASTRUCTURE_FOUND`
- OP-061: `GHOST_ARCHIVAL_GUIDE_READY_FOR_REMOVAL`
- OP-062: `PERMANENT_SYSTEM_CARD_COVERAGE_RULE_ACTIVE`
- OP-063: `GHOST_SIGNALS_REMOVED_PENDING_OWNER_VERIFICATION`
- OP-064: `GHOST_ASSETS_REMOVED_PENDING_OWNER_VERIFICATION`
- OP-065: `GHOST_ROUTE_VISIBILITY_PURGED_PENDING_OWNER_VERIFICATION`
- OP-066: closes with this report

Registry health:

- Operations Index updated: yes
- Operations Registry updated: yes
- Memory Registry updated for each recent package: yes
- Finding Registry updated for each package where a finding was created: yes
- Archive Registry updated for route/signal/asset purge state: yes

## 8. Firebase Rules Status

### Firestore Rules

Status: active, not deployed by these operations.

Current important observations:

- No active `clients` collection rule block remains.
- Provider/clinician and center identity rules remain active.
- `saved_destinations` remains active and session-scoped, but is still `OWNER_DECISION_REQUIRED`.
- `signal_events` remains active for session/visitor and signed-in actor signal creation.
- `signal_aggregates` remains read-only for owner/monitoring and write-disabled; lifecycle remains `OWNER_DECISION_REQUIRED`.
- No Firebase deploy was performed.

### Storage Rules

Status: active, not deployed by these operations.

Current important observations:

- Provider/clinician/center document and branding storage surfaces remain.
- Owner-authority upload areas remain.
- No client-specific storage rule block was identified in this summary pass.
- No Firebase deploy was performed.

### Firestore Indexes

Status: active config, not deployed by these operations.

Current indexes cover:

- `center_profile_change_requests`
- `clinician_profile_change_requests`
- `support_requests`
- `chat_threads`
- `messages`
- `signal_events`

No index change was made by Packages A/B/C.

## 9. YAML / Config Status

### `pubspec.yaml`

Status:

- Ghost asset paths removed earlier from bundle entries.
- Package B confirmed the deleted ghost asset folders had no active bundle entries.
- No `pubspec.yaml` change was required during Package B.

Current asset bundle still includes active broad folders such as:

- branding logos
- web library backgrounds
- provider/center registration assets
- shared navigation assets
- menu/splash/login assets
- C7 branding
- active images folders
- center dashboard and clinician dashboard assets

### `firebase.json`

Status:

- Firebase project config points to `mental-smile-platform`.
- Hosting public target remains `public-landing`.
- This remains `OWNER_DECISION_REQUIRED` before any Firebase deploy because Flutter web output vs static landing target is not yet decided.

### `.firebaserc`

Status:

- Default project is `mental-smile-platform`.
- No change made by the recent packages.

### `analysis_options.yaml`

Status:

- Flutter lint config active.
- Exclusions exist for build, archives, logs, temporary profiles, and platform ephemeral folders.
- No ghost package changes required.

### `l10n.yaml`

Status:

- ARB source remains `lib/l10n`.
- Template remains `app_ar.arb`.
- Output remains `app_localizations.dart`.
- No ghost package changes required.

### `.github/workflows/*.yml`

Status:

- Firebase Hosting workflow files exist.
- Merge workflow triggers on push to `ai-lab`.
- PR workflow triggers on pull request.
- These remain `OWNER_DECISION_REQUIRED` before commit/push/deploy behavior is accepted.

## 10. Localization Status

Localization client/admin residue remains present:

- `centerRequestViaAdmin`
- `clientSupport`
- `clientSupportRequests`
- `clientLinksAndCodes`
- `clientRatingsCount`
- `clientAverageStars`
- `clientOverallAverage`

Status:

- Covered by `ARCHIVE_CARD_OWNER_DECISION_LOCALIZATION_CLIENT_ADMIN_RESIDUE_V1` inside the Ghost Infrastructure Archival Guide.
- Not removed in Packages A/B/C.
- Requires a dedicated Owner-approved localization cleanup package.

## 11. Current System Shape

Active preserved runtime areas:

- Provider identity and routes.
- Center identity and routes.
- Owner protected routes.
- Monitoring and support observer routes.
- Accessibility hub, organizations directory, resource gateway, and active accessibility signals.
- Client Session Room.
- Chat/support/escalation flows.
- Library route/content surface.
- Provider/center contact and accessible contact flows.
- `signal_events` raw signal storage.

Removed or hidden by recent packages:

- Ghost client-era signal types.
- Ghost client dashboard/register asset folders.
- Ghost Capital incident/maintenance/broadcast/emergency routes.
- Ghost public service/package request routes.

Still open:

- Owner-decision routes and workflows.
- `saved_destinations` and `destination_saved` purpose.
- `signal_aggregates` lifecycle.
- Firebase hosting target and GitHub hosting workflows.
- Localization client/admin residue.
- C5/C6 legacy evidence cleanup, if Owner later approves.

## 12. Manual Verification Still Required

Because Packages A/C touched Dart runtime files and Package B removed assets, Owner should run:

```text
dart format lib/app/router/routes.dart lib/app/router/app_router.dart lib/features/web_portal/presentation/pages/portal_skeleton_pages.dart lib/features/s_capital/presentation/pages/s_capital_operations_office_page.dart lib/features/signals/domain/registries/signal_type_registry.dart lib/features/signals/domain/factories/signal_package_factory.dart lib/features/signals/domain/validators/signal_aggregation_validator.dart lib/features/signals/domain/registries/signal_aggregation_category_registry.dart lib/features/signals/domain/aggregation/signal_aggregation_engine.dart lib/features/monitoring/domain/validators/monitoring_aggregate_validator.dart lib/features/monitoring/domain/adapters/monitoring_aggregation_adapter.dart lib/features/monitoring/residential/domain/residential_monitoring_registry.dart lib/features/accessibility/domain/models/accessibility_signal_type.dart lib/features/accessibility/domain/factories/accessibility_signal_factory.dart lib/features/accessibility/domain/registries/accessibility_signal_registry.dart
flutter analyze
flutter build apk --debug
flutter build web
```

No Firebase deploy should be run until Owner approves Firebase target/workflow state.

## 13. Final Verdict

GHOST_PACKAGES_SYSTEM_STATE_SUMMARY_COMPLETE
