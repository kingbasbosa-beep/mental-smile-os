# Route Registry V1

Status: ACTIVE_BASELINE_REGISTRY
Classification: EXISTING_HISTORICAL_PROMOTE
Runtime effect: none

## Historical References

- `mental-smile-os-workspace/docs/mental-smile-os/pure-runtime/ACTIVE_RUNTIME_ROUTE_REGISTRY_V1.md`
- `mental-smile-os-workspace/docs/mental-smile-os/route-system/MASTER_ROUTE_REGISTRY_MODEL_V1.md`

## Baseline Route Families

| Route Family | Status |
| --- | --- |
| Portal routes | ACTIVE |
| Core shell routes | ACTIVE |
| Client routes | ACTIVE_WITH_LEGACY_CANDIDATES |
| Clinician/provider routes | ACTIVE_BUT_NAMING_DRIFT |
| Center routes | ACTIVE |
| Chat/safety routes | ACTIVE |
| Module discovery routes | ACTIVE |
| Web registration routes | ACTIVE |
| S/sovereign routes | ACTIVE |
| Native clinician/center registration aliases | LEGACY_ALIAS |

## Rule

No route removal or rename before route card and Owner approval.

## Phase 8 Route Notes

| Route | Status | Classification | Note |
| --- | --- | --- | --- |
| `/client/session-room` | ACTIVE | ACCOUNT_FREE_CLIENT_SESSION_ROOM | Introduced as no-account-required session entry. |
| `/login` | ACTIVE | LEGACY_CANDIDATE | Temporarily retained for account continuity. |
| `/register/client` | ARCHIVED_PENDING_MANUAL_VERIFICATION | CLIENT_LEGACY_REMOVED | Removed in Phase 14; client access rewired to `/client/session-room`. |
| `/client/dashboard` | ARCHIVED_PENDING_MANUAL_VERIFICATION | CLIENT_LEGACY_REMOVED | Removed in Phase 14; client role/menu access rewired to `/client/session-room`. |
| `/s/personal-space` | ARCHIVED_HARD_REMOVED | PURE_CLIENT_IDENTITY_REMOVED | Removed in OP-059 because it depended on `clients`, `clientSignals`, privacy preferences, and room preferences. |

## Phase 11 Route Notes

| Route | Status | Classification | Note |
| --- | --- | --- | --- |
| `/accessibility/organizations` | ACTIVE_PENDING_OWNER_MANUAL_VERIFICATION | ACCESSIBILITY_PARTNERSHIP_DIRECTORY | Introduced as governed organizations directory and partnership request preparation surface. |

## Ghost Infrastructure Archival Guide Route Notes

| Route / Route Group | Status | Classification | Related Guide | Note |
| --- | --- | --- | --- | --- |
| `/s/capital/incidents` | REMOVED_FROM_ROUTER_AND_NAVIGATION | GHOST_ROUTE_PURGED | `GHOST_ROUTE_VISIBILITY_PURGE_REPORT_V1.md` | Route constant, router case, navigation link, and overview placeholder visibility removed in Package C. |
| `/s/capital/maintenance` | REMOVED_FROM_ROUTER_AND_NAVIGATION | GHOST_ROUTE_PURGED | `GHOST_ROUTE_VISIBILITY_PURGE_REPORT_V1.md` | Route constant, router case, navigation link, and overview placeholder visibility removed in Package C. |
| `/s/capital/broadcasts` | REMOVED_FROM_ROUTER_AND_NAVIGATION | GHOST_ROUTE_PURGED | `GHOST_ROUTE_VISIBILITY_PURGE_REPORT_V1.md` | Route constant, router case, navigation link, and overview placeholder visibility removed in Package C. |
| `/s/capital/emergency-brief` | REMOVED_FROM_ROUTER_AND_NAVIGATION | HIGH_TRUST_GHOST_ROUTE_PURGED | `GHOST_ROUTE_VISIBILITY_PURGE_REPORT_V1.md` | Route constant, router case, navigation link, and overview placeholder visibility removed in Package C. |
| `/request/service` | REMOVED_FROM_ROUTER_AND_NAVIGATION | PUBLIC_INTAKE_GHOST_ROUTE_PURGED | `GHOST_ROUTE_VISIBILITY_PURGE_REPORT_V1.md` | Route constant, router case, public nav/action link, and intake page removed in Package C. |
| `/request/package` | REMOVED_FROM_ROUTER_AND_NAVIGATION | PUBLIC_INTAKE_GHOST_ROUTE_PURGED | `GHOST_ROUTE_VISIBILITY_PURGE_REPORT_V1.md` | Route constant, router case, public nav link, and intake page removed in Package C. |
| `/s/city/tools`, `/s/city/programs`, `/s/city/marketplace` | OWNER_DECISION_REQUIRED | PLACEHOLDER_ROUTE_GROUP | `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` | Keep as governed placeholders or archive until runtime exists. |
| `/s/capital/departments`, `/s/capital/trust-safety`, `/s/capital/reports` | OWNER_DECISION_REQUIRED | AUTHORITY_PLACEHOLDER_ROUTE_GROUP | `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` | Protected/generic surfaces require Owner visibility decision. |
