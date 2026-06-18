# Ghost Infrastructure Archival Guide V1

Operation ID: OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1
Date: 2026-06-18
Source: `docs/audits/PURPOSE_NULL_AUDIT_GHOST_INFRASTRUCTURE_V1.md`
Execution Mode: DOCUMENTATION / ARCHIVAL PREPARATION ONLY
Runtime Effect: none
Firebase Effect: none
Git Effect: none

## Purpose

This guide converts ghost, legacy, and Owner-decision runtime elements into compact governed archive cards before any removal.

No item listed here is removed by this guide. Removal still requires Owner approval, a removal operation record, registry updates, and verification.

Related findings:

- `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- `FINDING-CONNECTED-DOES-NOT-MEAN-NEEDED-V1`
- `FINDING-FUNCTIONLESS-LEGACY-RISK-V1`

Related operations:

- `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- `OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1`

## Card Rules

Each card below is an archival preparation card. It records:

- Card ID
- Item name
- Type
- Old purpose
- Previous user journey
- Current status
- Why it became ghost
- Risk if left alive
- Removal recommendation
- Archive classification
- Related finding
- Related operation
- Registry updates required

## 1. Ghost Route Cards

### ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_INCIDENTS_V1

- Card ID: `ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_INCIDENTS_V1`
- Item name: `/s/capital/incidents`
- Type: Route / Page
- Old purpose: Capital operations incident timeline placeholder.
- Previous user journey: Monitoring or Capital navigation could open an incidents surface.
- Current status: `REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Why it became ghost: The source audit found placeholder text and no incident collection or service.
- Risk if left alive: Monitoring can appear operational without incident data.
- Removal recommendation: Completed in `OP-PACKAGE-C-GHOST-ROUTE-VISIBILITY-PURGE-V1`; keep archived as removed route evidence.
- Archive classification: `GHOST_ROUTE_REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Related finding: `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Route Registry, Archive Registry, Operations Registry, Operations Index.

### ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_MAINTENANCE_V1

- Card ID: `ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_MAINTENANCE_V1`
- Item name: `/s/capital/maintenance`
- Type: Route / Page
- Old purpose: Capital maintenance placeholder.
- Previous user journey: Capital navigation could open planned/history maintenance groups.
- Current status: `REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Why it became ghost: No maintenance collection or service was found.
- Risk if left alive: False operational readiness.
- Removal recommendation: Completed in `OP-PACKAGE-C-GHOST-ROUTE-VISIBILITY-PURGE-V1`; keep archived as removed route evidence.
- Archive classification: `GHOST_ROUTE_REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Related finding: `FINDING-FUNCTIONLESS-LEGACY-RISK-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Route Registry, Archive Registry, Operations Registry, Operations Index.

### ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_BROADCASTS_V1

- Card ID: `ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_BROADCASTS_V1`
- Item name: `/s/capital/broadcasts`
- Type: Route / Page / Workflow
- Old purpose: Capital broadcast placeholder.
- Previous user journey: Capital users could open a broadcasts surface.
- Current status: `REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Why it became ghost: The audit found no broadcast runtime.
- Risk if left alive: Silent dead surface and untrue communication readiness.
- Removal recommendation: Completed in `OP-PACKAGE-C-GHOST-ROUTE-VISIBILITY-PURGE-V1`; keep archived as removed route evidence.
- Archive classification: `GHOST_ROUTE_REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Related finding: `FINDING-CONNECTED-DOES-NOT-MEAN-NEEDED-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Route Registry, Archive Registry, Operations Registry, Operations Index.

### ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_EMERGENCY_BRIEF_V1

- Card ID: `ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_EMERGENCY_BRIEF_V1`
- Item name: `/s/capital/emergency-brief`
- Type: Route / Page / Workflow
- Old purpose: Emergency brief placeholder for high-trust operational state.
- Previous user journey: Capital navigation could open emergency contacts, recovery, and version groups.
- Current status: `REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Why it became ghost: No emergency brief data source was found.
- Risk if left alive: High-trust placeholder can be mistaken for live emergency governance.
- Removal recommendation: Completed in `OP-PACKAGE-C-GHOST-ROUTE-VISIBILITY-PURGE-V1`; keep archived as removed high-trust route evidence.
- Archive classification: `HIGH_TRUST_GHOST_ROUTE_REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Related finding: `FINDING-FUNCTIONLESS-LEGACY-RISK-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Route Registry, Archive Registry, Operations Registry, Operations Index.

### ARCHIVE_CARD_GHOST_ROUTE_REQUEST_SERVICE_V1

- Card ID: `ARCHIVE_CARD_GHOST_ROUTE_REQUEST_SERVICE_V1`
- Item name: `/request/service`
- Type: Route / Page / Workflow
- Old purpose: Public service request skeleton.
- Previous user journey: Public portal request entry.
- Current status: `REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Why it became ghost: No service request persistence or runtime flow was found.
- Risk if left alive: Public promise without backend handling.
- Removal recommendation: Completed in `OP-PACKAGE-C-GHOST-ROUTE-VISIBILITY-PURGE-V1`; keep archived as removed public intake route evidence.
- Archive classification: `PUBLIC_INTAKE_GHOST_ROUTE_REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Related finding: `FINDING-CONNECTED-DOES-NOT-MEAN-NEEDED-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Route Registry, Archive Registry, Operations Registry, Operations Index.

### ARCHIVE_CARD_GHOST_ROUTE_REQUEST_PACKAGE_V1

- Card ID: `ARCHIVE_CARD_GHOST_ROUTE_REQUEST_PACKAGE_V1`
- Item name: `/request/package`
- Type: Route / Page / Workflow
- Old purpose: Public package request skeleton.
- Previous user journey: Public portal package request entry.
- Current status: `REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Why it became ghost: No package request persistence or runtime flow was found.
- Risk if left alive: Public promise without backend handling.
- Removal recommendation: Completed in `OP-PACKAGE-C-GHOST-ROUTE-VISIBILITY-PURGE-V1`; keep archived as removed public intake route evidence.
- Archive classification: `PUBLIC_INTAKE_GHOST_ROUTE_REMOVED_FROM_ROUTER_AND_NAVIGATION`
- Related finding: `FINDING-CONNECTED-DOES-NOT-MEAN-NEEDED-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Route Registry, Archive Registry, Operations Registry, Operations Index.

## 2. Ghost Page Cards

### ARCHIVE_CARD_GHOST_PAGE_CAPITAL_OPERATIONS_PLACEHOLDERS_V1

- Card ID: `ARCHIVE_CARD_GHOST_PAGE_CAPITAL_OPERATIONS_PLACEHOLDERS_V1`
- Item name: `SCapitalOperationsOfficePage` placeholder districts
- Type: Page
- Old purpose: Construction-era operations office surface.
- Previous user journey: Capital operations navigation.
- Current status: `GHOST_SURFACE`
- Why it became ghost: The source page says construction placeholder, while incident, maintenance, broadcast, and emergency sections have no backing services.
- Risk if left alive: Operations surfaces look healthier than runtime truth.
- Removal recommendation: Hide/remove ghost subsections or keep only as explicit construction documentation after Owner decision.
- Archive classification: `PLACEHOLDER_SURFACE_ARCHIVE_CANDIDATE`
- Related finding: `FINDING-FUNCTIONLESS-LEGACY-RISK-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Archive Registry, Route Registry, Memory Registry, Operations Registry.

### ARCHIVE_CARD_OWNER_DECISION_PAGE_S_CITY_PLACEHOLDERS_V1

- Card ID: `ARCHIVE_CARD_OWNER_DECISION_PAGE_S_CITY_PLACEHOLDERS_V1`
- Item name: S City placeholder routes: `/s/city/tools`, `/s/city/programs`, `/s/city/marketplace`
- Type: Route / Page
- Old purpose: Future tools, programs, and marketplace map.
- Previous user journey: S City navigation.
- Current status: `UNKNOWN_OWNER_DECISION`
- Why it became ghost: Router cases are connected, but no tool, program, or marketplace runtime was found.
- Risk if left alive: Placeholder map may be read as feature completion.
- Removal recommendation: Owner decides whether to keep as governed construction map or archive until runtime exists.
- Archive classification: `OWNER_DECISION_PLACEHOLDER_CARD`
- Related finding: `FINDING-CONNECTED-DOES-NOT-MEAN-NEEDED-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Route Registry, Archive Registry, Memory Registry.

### ARCHIVE_CARD_OWNER_DECISION_PAGE_CAPITAL_PLACEHOLDERS_V1

- Card ID: `ARCHIVE_CARD_OWNER_DECISION_PAGE_CAPITAL_PLACEHOLDERS_V1`
- Item name: Capital placeholder routes: `/s/capital/departments`, `/s/capital/trust-safety`, `/s/capital/reports`
- Type: Route / Page / Role-gated Surface
- Old purpose: Capital governance and monitoring map.
- Previous user journey: Protected Capital navigation.
- Current status: `UNKNOWN_OWNER_DECISION`
- Why it became ghost: Generic or protected surfaces exist without dedicated workflow evidence.
- Risk if left alive: Protected empty authority surfaces can imply live governance.
- Removal recommendation: Owner decides visible placeholder policy before testing.
- Archive classification: `OWNER_DECISION_AUTHORITY_PLACEHOLDER_CARD`
- Related finding: `FINDING-FUNCTIONLESS-LEGACY-RISK-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Route Registry, Archive Registry, Memory Registry.

## 3. Ghost Rule / Collection Cards

### ARCHIVE_CARD_OWNER_DECISION_SAVED_DESTINATIONS_V1

- Card ID: `ARCHIVE_CARD_OWNER_DECISION_SAVED_DESTINATIONS_V1`
- Item name: `saved_destinations`
- Type: Collection / Rule / Workflow
- Old purpose: Store saved destinations from client or session discovery.
- Previous user journey: Client/account-era saved preference and later session save actions.
- Current status: `OWNER_DECISION`
- Why it became ghost: Writes are session-scoped, but no user-visible session readback journey was found.
- Risk if left alive: Write-only storage and stale preference analytics.
- Removal recommendation: Owner decides to remove, expose as session readback, or preserve as monitoring-only signal evidence.
- Archive classification: `OWNER_DECISION_COLLECTION_CARD`
- Related finding: `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Collection Registry, Archive Registry, Signal Governance Registry, Memory Registry, Operations Registry.

### ARCHIVE_CARD_OWNER_DECISION_SIGNAL_AGGREGATES_LIFECYCLE_V1

- Card ID: `ARCHIVE_CARD_OWNER_DECISION_SIGNAL_AGGREGATES_LIFECYCLE_V1`
- Item name: `signal_aggregates`
- Type: Collection / Rule
- Old purpose: Monitoring aggregate read model.
- Previous user journey: Owner/monitoring observability.
- Current status: `RULE_GHOST / OWNER_DECISION`
- Why it became ghost: Rules and models exist, but no active aggregate write service was found in the audit.
- Risk if left alive: Empty monitoring read model can imply live aggregate intelligence.
- Removal recommendation: Focused aggregate lifecycle audit before removal or activation.
- Archive classification: `OWNER_DECISION_RULE_CARD`
- Related finding: `FINDING-CONNECTED-DOES-NOT-MEAN-NEEDED-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Collection Registry, Signal Governance Registry, Archive Registry.

### ARCHIVE_CARD_GHOST_COLLECTION_ACCESSIBILITY_RESOURCES_V1

- Card ID: `ARCHIVE_CARD_GHOST_COLLECTION_ACCESSIBILITY_RESOURCES_V1`
- Item name: `accessibility_resources`
- Type: Collection / Model
- Old purpose: Future accessibility resource collection.
- Previous user journey: Accessibility resource discovery.
- Current status: `RULE_GHOST`
- Why it became ghost: Model declares a collection name, but current resources are static samples and no repository/rule path was found.
- Risk if left alive: Future CMS collection can be mistaken as active runtime.
- Removal recommendation: Archive as future-only or create an approved runtime collection later.
- Archive classification: `FUTURE_COLLECTION_GHOST_CARD`
- Related finding: `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Collection Registry, Archive Registry, Accessibility memory records.

## 4. Ghost Signal Cards

### ARCHIVE_CARD_GHOST_SIGNAL_COMMUNICATION_PREFERENCE_SELECTED_V1

- Card ID: `ARCHIVE_CARD_GHOST_SIGNAL_COMMUNICATION_PREFERENCE_SELECTED_V1`
- Item name: `communication_preference_selected`
- Type: Signal
- Old purpose: Capture communication preference selection.
- Previous user journey: Client preference or room preference selection.
- Current status: `REMOVED_FROM_RUNTIME`
- Why it became ghost: Factory/registry only; no producer or consumer found beyond governance surfaces.
- Risk if left alive: Monitoring schemas include a signal that never arrives.
- Removal recommendation: Completed in `OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1`; keep archived as removed runtime evidence.
- Archive classification: `GHOST_SIGNAL_REMOVED_FROM_RUNTIME`
- Related finding: `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Signal Registry, Signal Governance Registry, Archive Registry, Operations Registry.

### ARCHIVE_CARD_GHOST_SIGNAL_GOAL_SELECTED_V1

- Card ID: `ARCHIVE_CARD_GHOST_SIGNAL_GOAL_SELECTED_V1`
- Item name: `goal_selected`
- Type: Signal
- Old purpose: Capture client goal selection.
- Previous user journey: Client dashboard/personal space preference flow.
- Current status: `REMOVED_FROM_RUNTIME`
- Why it became ghost: No current emitter after client identity hard removal.
- Risk if left alive: Old residential analytics shape remains after the journey was removed.
- Removal recommendation: Completed in `OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1`; do not restore without a new Owner-approved session signal card.
- Archive classification: `CLIENT_ERA_SIGNAL_REMOVED_FROM_RUNTIME`
- Related finding: `FINDING-FUNCTIONLESS-LEGACY-RISK-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Signal Registry, Residential Signal Ownership Registry, Signal Governance Registry, Archive Registry.

### ARCHIVE_CARD_GHOST_SIGNAL_INTEREST_SELECTED_V1

- Card ID: `ARCHIVE_CARD_GHOST_SIGNAL_INTEREST_SELECTED_V1`
- Item name: `interest_selected`
- Type: Signal
- Old purpose: Capture client interest selection.
- Previous user journey: Client dashboard/personal space preference flow.
- Current status: `REMOVED_FROM_RUNTIME`
- Why it became ghost: No active producer was found.
- Risk if left alive: Stale residential analytics category.
- Removal recommendation: Completed in `OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1`; do not restore without a new Owner-approved session signal card.
- Archive classification: `CLIENT_ERA_SIGNAL_REMOVED_FROM_RUNTIME`
- Related finding: `FINDING-FUNCTIONLESS-LEGACY-RISK-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Signal Registry, Residential Signal Ownership Registry, Signal Governance Registry, Archive Registry.

### ARCHIVE_CARD_GHOST_SIGNAL_ACCESSIBILITY_INTEREST_V1

- Card ID: `ARCHIVE_CARD_GHOST_SIGNAL_ACCESSIBILITY_INTEREST_V1`
- Item name: `accessibility_interest`
- Type: Signal
- Old purpose: Bridge client interest toward accessibility.
- Previous user journey: Client account or residential preference flow.
- Current status: `REMOVED_FROM_RUNTIME`
- Why it became ghost: Dedicated accessibility signals now exist and no producer was found for this old bridge.
- Risk if left alive: Duplicate accessibility intent model.
- Removal recommendation: Completed in `OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1`; dedicated accessibility gateway signals remain separate.
- Archive classification: `SUPERSEDED_SIGNAL_REMOVED_FROM_RUNTIME`
- Related finding: `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Signal Registry, Signal Governance Registry, Archive Registry, Accessibility signal memory.

### ARCHIVE_CARD_GHOST_SIGNAL_ACCESSIBILITY_MODE_SELECTED_V1

- Card ID: `ARCHIVE_CARD_GHOST_SIGNAL_ACCESSIBILITY_MODE_SELECTED_V1`
- Item name: `accessibility_mode_selected`
- Type: Signal
- Old purpose: Capture selected accessibility mode.
- Previous user journey: Accessibility mode selection.
- Current status: `REMOVED_FROM_RUNTIME`
- Why it became ghost: Type exists, but no UI producer was found.
- Risk if left alive: Dead metric in accessibility observability.
- Removal recommendation: Completed in `OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1`; any future mode signal requires a new card and producer.
- Archive classification: `ACCESSIBILITY_GHOST_SIGNAL_REMOVED_FROM_RUNTIME`
- Related finding: `FINDING-CONNECTED-DOES-NOT-MEAN-NEEDED-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Signal Registry, Signal Governance Registry, Archive Registry.

### ARCHIVE_CARD_OWNER_DECISION_SIGNAL_DESTINATION_SAVED_V1

- Card ID: `ARCHIVE_CARD_OWNER_DECISION_SIGNAL_DESTINATION_SAVED_V1`
- Item name: `destination_saved`
- Type: Signal / Workflow
- Old purpose: Record saved provider/center destination.
- Previous user journey: Save destination from discovery or details page.
- Current status: `OWNER_DECISION`
- Why it became ghost: Producer exists, but no readback journey was found for session users.
- Risk if left alive: Write-only signal/storage with weak user-facing purpose.
- Removal recommendation: Decide together with `saved_destinations`.
- Archive classification: `OWNER_DECISION_SIGNAL_CARD`
- Related finding: `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Signal Registry, Signal Governance Registry, Collection Registry, Archive Registry.

## 5. Ghost Asset / YAML Cards

### ARCHIVE_CARD_GHOST_ASSET_CLIENT_DASHBOARD_BRANDING_V1

- Card ID: `ARCHIVE_CARD_GHOST_ASSET_CLIENT_DASHBOARD_BRANDING_V1`
- Item name: `assets/branding/client_dashboard/**`
- Type: Asset
- Old purpose: Client dashboard branding backgrounds.
- Previous user journey: Old client dashboard.
- Current status: `REMOVED_FROM_DISK`
- Why it became ghost: Files remain on disk but are unbundled and no active runtime references were found.
- Risk if left alive: Future accidental rebundle and client identity language reintroduction.
- Removal recommendation: Completed in `OP-PACKAGE-B-GHOST-ASSET-YAML-PURGE-V1`; keep archived as removed asset evidence.
- Archive classification: `UNBUNDLED_CLIENT_ASSET_REMOVED_FROM_DISK`
- Related finding: `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Asset Registry, Archive Registry, Operations Registry.

### ARCHIVE_CARD_GHOST_ASSET_WEB_REGISTRATION_CLIENTS_V1

- Card ID: `ARCHIVE_CARD_GHOST_ASSET_WEB_REGISTRATION_CLIENTS_V1`
- Item name: `assets/branding/web_registration/clients/**`
- Type: Asset
- Old purpose: Client registration image assets.
- Previous user journey: Old client registration route.
- Current status: `REMOVED_FROM_DISK`
- Why it became ghost: Client registration runtime was removed and no active route uses the image.
- Risk if left alive: Old client registration can be inferred as restorable runtime.
- Removal recommendation: Completed in `OP-PACKAGE-B-GHOST-ASSET-YAML-PURGE-V1`; keep archived as removed asset evidence.
- Archive classification: `UNBUNDLED_CLIENT_REGISTRATION_ASSET_REMOVED_FROM_DISK`
- Related finding: `FINDING-FUNCTIONLESS-LEGACY-RISK-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Asset Registry, Archive Registry, Operations Registry.

### ARCHIVE_CARD_GHOST_ASSET_CLIENT_DASHBOARD_ACTIONS_V1

- Card ID: `ARCHIVE_CARD_GHOST_ASSET_CLIENT_DASHBOARD_ACTIONS_V1`
- Item name: `assets/images/client_dashboard/actions/**`
- Type: Asset
- Old purpose: Old client dashboard action icons.
- Previous user journey: Old client dashboard action grid.
- Current status: `REMOVED_FROM_DISK`
- Why it became ghost: Files remain on disk but are unbundled and no active runtime references were found.
- Risk if left alive: Accidental reuse can recreate client dashboard assumptions.
- Removal recommendation: Completed in `OP-PACKAGE-B-GHOST-ASSET-YAML-PURGE-V1`; keep archived as removed asset evidence.
- Archive classification: `UNBUNDLED_CLIENT_ACTION_ASSET_REMOVED_FROM_DISK`
- Related finding: `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Asset Registry, Archive Registry, Operations Registry.

### ARCHIVE_CARD_OWNER_DECISION_WORKFLOW_GITHUB_FIREBASE_HOSTING_V1

- Card ID: `ARCHIVE_CARD_OWNER_DECISION_WORKFLOW_GITHUB_FIREBASE_HOSTING_V1`
- Item name: `.github/workflows/firebase-hosting-*.yml`
- Type: Workflow / YAML
- Old purpose: Firebase Hosting deployment automation.
- Previous user journey: Repository push or pull-request hosting automation.
- Current status: `OWNER_DECISION`
- Why it became ghost: Workflows are present from previous sweep but not Owner-approved for commit/deploy behavior.
- Risk if left alive: Accidental hosting automation activation if committed.
- Removal recommendation: Owner decides whether to keep, delete, or hold outside commit.
- Archive classification: `OWNER_DECISION_WORKFLOW_CARD`
- Related finding: `FINDING-CONNECTED-DOES-NOT-MEAN-NEEDED-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Archive Registry, Memory Registry, Operations Registry.

### ARCHIVE_CARD_OWNER_DECISION_FIREBASE_HOSTING_TARGET_V1

- Card ID: `ARCHIVE_CARD_OWNER_DECISION_FIREBASE_HOSTING_TARGET_V1`
- Item name: Firebase hosting target `public-landing`
- Type: YAML / Hosting Workflow
- Old purpose: Static public landing hosting.
- Previous user journey: Firebase-hosted public entry.
- Current status: `OWNER_DECISION`
- Why it became ghost: Hosting target may not match Flutter web output after runtime transformation.
- Risk if left alive: Wrong deployed surface.
- Removal recommendation: Firebase hosting sweep before any deploy.
- Archive classification: `OWNER_DECISION_HOSTING_CARD`
- Related finding: `FINDING-CONNECTED-DOES-NOT-MEAN-NEEDED-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Archive Registry, Memory Registry, Operations Registry.

## 6. Ghost Localization Cards

### ARCHIVE_CARD_OWNER_DECISION_LOCALIZATION_CLIENT_ADMIN_RESIDUE_V1

- Card ID: `ARCHIVE_CARD_OWNER_DECISION_LOCALIZATION_CLIENT_ADMIN_RESIDUE_V1`
- Item name: localization client/admin residue
- Type: Localization
- Old purpose: Client support, client metrics, and admin-era contact copy.
- Previous user journey: Client dashboard/support/admin-contact language.
- Current status: `LOCALIZATION_GHOST / OWNER_DECISION`
- Why it became ghost: Client identity was removed, but keys such as `clientSupport`, `clientSupportRequests`, `clientLinksAndCodes`, `clientRatingsCount`, `clientAverageStars`, `clientOverallAverage`, and admin-named `centerRequestViaAdmin` remain.
- Risk if left alive: Future developers may infer a client account/admin layer still exists.
- Removal recommendation: Dedicated localization cleanup pass after Owner approval.
- Archive classification: `LOCALIZATION_RESIDUE_OWNER_DECISION_CARD`
- Related finding: `FINDING-FUNCTIONLESS-LEGACY-RISK-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Archive Registry, Memory Registry, Operations Registry, generated localization verification.

## 7. Ghost Workflow / Hosting Cards

### ARCHIVE_CARD_OWNER_DECISION_PUBLIC_PORTAL_REQUEST_WORKFLOW_V1

- Card ID: `ARCHIVE_CARD_OWNER_DECISION_PUBLIC_PORTAL_REQUEST_WORKFLOW_V1`
- Item name: public portal request workflow
- Type: Workflow / Route / Page
- Old purpose: Let public users request services or packages.
- Previous user journey: `/request/service` and `/request/package`.
- Current status: `GHOST_WORKFLOW`
- Why it became ghost: Routes exist, but no persistence/runtime intake was found.
- Risk if left alive: Public request intent can be captured by no governed backend.
- Removal recommendation: Hide/remove until intake doctrine and storage are approved.
- Archive classification: `PUBLIC_INTAKE_WORKFLOW_REMOVAL_CANDIDATE`
- Related finding: `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Route Registry, Archive Registry, Memory Registry, Operations Registry.

### ARCHIVE_CARD_OWNER_DECISION_SAVED_DESTINATION_WORKFLOW_V1

- Card ID: `ARCHIVE_CARD_OWNER_DECISION_SAVED_DESTINATION_WORKFLOW_V1`
- Item name: saved destination workflow
- Type: Workflow / Collection / Signal
- Old purpose: Let users save provider or center destinations.
- Previous user journey: Account-era saved preference, later session save action.
- Current status: `OWNER_DECISION`
- Why it became ghost: Write path remains, but readback and user-facing purpose are unclear.
- Risk if left alive: Silent storage and stale analytics.
- Removal recommendation: Owner chooses remove, expose session list, or convert to observability-only signal.
- Archive classification: `OWNER_DECISION_WORKFLOW_CARD`
- Related finding: `FINDING-GHOST-INFRASTRUCTURE-AFTER-CLIENT-EXTRACTION-V1`
- Related operation: `OP-PURPOSE-NULL-AUDIT-GHOST-INFRASTRUCTURE-V1`
- Registry updates required: Collection Registry, Signal Governance Registry, Archive Registry, Memory Registry.

## Minimum Immediate Remove Candidate Coverage

| Immediate candidate | Covered by card |
| --- | --- |
| `communication_preference_selected` | `ARCHIVE_CARD_GHOST_SIGNAL_COMMUNICATION_PREFERENCE_SELECTED_V1` |
| `goal_selected` | `ARCHIVE_CARD_GHOST_SIGNAL_GOAL_SELECTED_V1` |
| `interest_selected` | `ARCHIVE_CARD_GHOST_SIGNAL_INTEREST_SELECTED_V1` |
| `accessibility_interest` | `ARCHIVE_CARD_GHOST_SIGNAL_ACCESSIBILITY_INTEREST_V1` |
| `accessibility_mode_selected` | `ARCHIVE_CARD_GHOST_SIGNAL_ACCESSIBILITY_MODE_SELECTED_V1` |
| `/s/capital/incidents` | `ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_INCIDENTS_V1` |
| `/s/capital/maintenance` | `ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_MAINTENANCE_V1` |
| `/s/capital/broadcasts` | `ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_BROADCASTS_V1` |
| `/s/capital/emergency-brief` | `ARCHIVE_CARD_GHOST_ROUTE_S_CAPITAL_EMERGENCY_BRIEF_V1` |
| `/request/service` | `ARCHIVE_CARD_GHOST_ROUTE_REQUEST_SERVICE_V1` |
| `/request/package` | `ARCHIVE_CARD_GHOST_ROUTE_REQUEST_PACKAGE_V1` |
| `assets/branding/client_dashboard/**` | `ARCHIVE_CARD_GHOST_ASSET_CLIENT_DASHBOARD_BRANDING_V1` |
| `assets/branding/web_registration/clients/**` | `ARCHIVE_CARD_GHOST_ASSET_WEB_REGISTRATION_CLIENTS_V1` |
| `assets/images/client_dashboard/actions/**` | `ARCHIVE_CARD_GHOST_ASSET_CLIENT_DASHBOARD_ACTIONS_V1` |

## Owner Decision Coverage

| Owner decision item | Covered by card |
| --- | --- |
| `saved_destinations` | `ARCHIVE_CARD_OWNER_DECISION_SAVED_DESTINATIONS_V1` |
| `destination_saved` | `ARCHIVE_CARD_OWNER_DECISION_SIGNAL_DESTINATION_SAVED_V1` |
| `.github workflows` | `ARCHIVE_CARD_OWNER_DECISION_WORKFLOW_GITHUB_FIREBASE_HOSTING_V1` |
| Firebase hosting target | `ARCHIVE_CARD_OWNER_DECISION_FIREBASE_HOSTING_TARGET_V1` |
| S City placeholder routes | `ARCHIVE_CARD_OWNER_DECISION_PAGE_S_CITY_PLACEHOLDERS_V1` |
| Capital placeholder routes | `ARCHIVE_CARD_OWNER_DECISION_PAGE_CAPITAL_PLACEHOLDERS_V1` |
| localization client/admin residue | `ARCHIVE_CARD_OWNER_DECISION_LOCALIZATION_CLIENT_ADMIN_RESIDUE_V1` |

## Registry Update Checklist

- Archive Registry: add this guide as the unified ghost archival guide and list covered archive-card families.
- Finding Registry: link existing ghost infrastructure findings to this archival guide.
- Memory Registry: add ghost archival guide memory.
- Route Registry: mark route candidates as `ARCHIVAL_CARD_CREATED_PENDING_OWNER_REMOVAL_APPROVAL`.
- Signal Governance Registry: mark ghost signals as archival-carded pending removal approval.
- Signal Ownership Registry: preserve active signal families and mark ghost signal candidates as archive candidates.
- Asset Registry: mark unbundled client asset families as archival-carded pending removal approval.
- Operations Registry: close this operation.
- Operations Index: close this operation.

## Final Verdict

GHOST_ARCHIVAL_GUIDE_READY_FOR_REMOVAL
