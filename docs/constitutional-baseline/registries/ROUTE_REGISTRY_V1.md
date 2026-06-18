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

## Phase 11 Route Notes

| Route | Status | Classification | Note |
| --- | --- | --- | --- |
| `/accessibility/organizations` | ACTIVE_PENDING_OWNER_MANUAL_VERIFICATION | ACCESSIBILITY_PARTNERSHIP_DIRECTORY | Introduced as governed organizations directory and partnership request preparation surface. |
