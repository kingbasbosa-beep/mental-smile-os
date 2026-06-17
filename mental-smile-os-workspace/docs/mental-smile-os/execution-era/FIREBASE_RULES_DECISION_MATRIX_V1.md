# Firebase Rules Decision Matrix V1

Status: RULES_DECISION_MATRIX_CREATED
Prompt Asset: PROMPT_ASSET_062

## Rule Section Decisions

| Rule Component | Source | Decision | Notes |
| --- | --- | --- | --- |
| firestore.rules full file | firestore.rules | KEEP_AND_REFACTOR | Source evidence only; rewrite from doctrine. |
| storage.rules full file | storage.rules | KEEP_AND_REFACTOR | Contains forbidden admin authority. |
| clients rules | firestore.rules | MIGRATE_TO_GENERATION_1 | Rebuild under App Zone boundary. |
| clinicians rules | firestore.rules | MIGRATE_TO_GENERATION_1 | Rebuild as Provider split. |
| centers rules | firestore.rules | MIGRATE_TO_GENERATION_1 | Rebuild as Center split. |
| profile change request rules | firestore.rules | MIGRATE_TO_GENERATION_1 | Rebuild under registration review/status model. |
| support/chat/escalation rules | firestore.rules | ARCHIVE_AS_HISTORICAL_EVIDENCE | Not Gen 1 pure foundation. |
| signal_events rules | firestore.rules | KEEP_AND_REFACTOR | Rebuild as gateway-owned signal collections. |
| signal_aggregates rules | firestore.rules | KEEP_AND_REFACTOR | Rebuild as monitoring/archive summaries. |
| system_domains rules | firestore.rules | KEEP_AND_REFACTOR | Rebuild as owner_authority_records if needed. |
| admin storage authority | storage.rules | REMOVE_AFTER_ARCHIVE | Forbidden. |
| admins collection fallback | storage.rules | REMOVE_AFTER_ARCHIVE | Forbidden hidden authority. |
| public storage marketing paths | storage.rules | KEEP_AND_REFACTOR | Rebuild by zone asset ownership. |
| private storage identity/document paths | storage.rules | MIGRATE_TO_GENERATION_1 | Rebuild under registration/private document zones. |
| DEV_BOOKING variant | firebase_rules | ARCHIVE_AS_HISTORICAL_EVIDENCE | Booking residue; forbidden for reuse. |
| session authority | scan result | UNKNOWN | No explicit match discovered; concept forbidden. |
| payment authority | scan result | UNKNOWN | No explicit match discovered; concept forbidden. |

## Rule

Current rules must not be deployed as Generation 1 pure rules.

