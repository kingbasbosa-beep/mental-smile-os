# Archive Registry V1

## Phase 14 Archive Entries

| Archive Card | Date | Domain | Status | Related Operation | Summary |
| --- | --- | --- | --- | --- | --- |
| `ARCHIVE_CARD_CLIENT_LOGIN_REGISTER_DASHBOARD_EXTRACTION_V1.md` | 2026-06-18 | RESIDENTIAL / CLIENT_IDENTITY_EXTRACTION | ACTIVE_ARCHIVE_CARD | OP-PHASE-14-CLIENT-LEGACY-REMOVAL-EXECUTION-V1 | Archives removed client registration and dashboard runtime surfaces while preserving provider/center/owner/monitoring identity. |
| `ARCHIVE_CARD_PURE_CLIENT_IDENTITY_HARD_REMOVAL_V1.md` | 2026-06-18 | RESIDENTIAL / CLIENT_IDENTITY / SESSION_DOCTRINE | ACTIVE_ARCHIVE_CARD | OP-PURE-CLIENT-IDENTITY-HARD-REMOVAL-V1 | Archives the hard removal of dormant client identity residue, including clients collection assumptions, personal space runtime, client signal model, client actor role emissions, and client dashboard/register asset bundles. |
| `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` | 2026-06-18 | GOVERNANCE / GHOST_INFRASTRUCTURE / REMOVAL_PREPARATION | ACTIVE_ARCHIVAL_GUIDE | OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1 | Unified guide converting purpose-null ghost routes, pages, collections, signals, assets, localization, and workflow items into governed archival cards before any Owner-approved removal. |
| `ARCHIVE_CARD_SAVED_DESTINATIONS_V1.md` | 2026-06-18 | RESIDENTIAL / SIGNALS / COLLECTIONS | REMOVED_FROM_RUNTIME | OP-SAVED-DESTINATIONS-EXTRACTION-V1 | Archives removal of `saved_destinations`, `SavedDestinationRepository`, save UI actions, and `destination_saved` signal producer under Fresh Signals doctrine. |

Status: ACTIVE_BASELINE_REGISTRY
Classification: MISSING_CREATE
Runtime effect: none

## Archive Cards

| Archive Card | Status |
| --- | --- |
| `ARCHIVE_CARD_C5_BOOKING_ERA_V1.md` | ACTIVE |
| `ARCHIVE_CARD_C6_LIBRARY_ERA_V1.md` | ACTIVE |
| `ARCHIVE_CARD_ADMIN_ZERO_TRANSITION_V1.md` | ACTIVE |
| `ARCHIVE_CARD_BOOKING_EXTRACTION_V1.md` | ACTIVE |
| `ARCHIVE_CARD_PROVIDER_VS_CLINICIAN_V1.md` | ACTIVE |
| `ARCHIVE_CARD_OLD_REPOSITORY_LINEAGE_V1.md` | ACTIVE_REFERENCE |
| `ARCHIVE_CARD_CLIENT_PROFILE_COMPLEXITY_V1.md` | ACTIVE |
| `ARCHIVE_CARD_CLIENT_LOGIN_REGISTRATION_PROFILE_LEGACY_V1.md` | ACTIVE |
| `ARCHIVE_CARD_PURE_CLIENT_IDENTITY_HARD_REMOVAL_V1.md` | ACTIVE |
| `ARCHIVE_CARD_SAVED_DESTINATIONS_V1.md` | REMOVED_FROM_RUNTIME |
| `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` | ACTIVE_ARCHIVAL_GUIDE |

## Ghost Infrastructure Archival Guide Entries

| Archive Card Group | Status | Related Operation | Notes |
| --- | --- | --- | --- |
| Ghost Route Cards | REMOVED_FROM_ROUTER_AND_NAVIGATION | OP-PACKAGE-C-GHOST-ROUTE-VISIBILITY-PURGE-V1 | Covers removed/hidden routes `/s/capital/incidents`, `/s/capital/maintenance`, `/s/capital/broadcasts`, `/s/capital/emergency-brief`, `/request/service`, and `/request/package`. |
| Ghost Signal Cards | REMOVED_FROM_RUNTIME | OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1 | Covers removed runtime signals `communication_preference_selected`, `goal_selected`, `interest_selected`, `accessibility_interest`, and `accessibility_mode_selected`. |
| Ghost Asset Cards | REMOVED_FROM_DISK | OP-PACKAGE-B-GHOST-ASSET-YAML-PURGE-V1 | Covers removed asset folders `assets/branding/client_dashboard/**`, `assets/branding/web_registration/clients/**`, and `assets/images/client_dashboard/actions/**`. |
| Owner Decision Cards | OWNER_DECISION_REQUIRED | OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1 | Originally covered saved destinations, destination saved, GitHub workflows, Firebase hosting target, S City placeholders, Capital placeholders, and localization residue. Saved destinations and `destination_saved` were later removed by OP-SAVED-DESTINATIONS-EXTRACTION-V1. |

## Rule

Archive registry indexes evidence. It does not delete, move, or clean runtime files.
