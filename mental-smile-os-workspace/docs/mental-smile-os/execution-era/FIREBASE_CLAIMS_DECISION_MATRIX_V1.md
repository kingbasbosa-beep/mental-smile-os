# Firebase Claims Decision Matrix V1

Status: CLAIMS_DECISION_MATRIX_CREATED
Prompt Asset: PROMPT_ASSET_062

## Claims Decisions

| Claim / Role | Decision | Generation 1 Fate |
| --- | --- | --- |
| owner | KEEP_AND_REFACTOR | Keep as owner claim with audited doctrine. |
| client | KEEP_AND_REFACTOR | Keep as client claim within App Zone boundary. |
| center | KEEP_AND_REFACTOR | Keep as center claim with zone split boundaries. |
| clinician | MIGRATE_TO_GENERATION_1 | Rename/reclassify as provider. |
| monitoring_operator | MIGRATE_TO_GENERATION_1 | Reclassify as monitoring. |
| registry_steward | ARCHIVE_AS_HISTORICAL_EVIDENCE | Not approved claim. |
| declaration_reviewer | ARCHIVE_AS_HISTORICAL_EVIDENCE | Review role evidence only. |
| support_observer | ARCHIVE_AS_HISTORICAL_EVIDENCE | Legacy support role evidence only. |
| admin | REMOVE_AFTER_ARCHIVE | Forbidden Generation 1 claim. |
| unknown live claims | UNKNOWN | Live Auth state not queried. |

## Rule

No admin, super_admin, god_mode, hidden_owner, or wildcard_admin claim may enter Generation 1.

