# Firebase Collection Reality Registry V1

Status: COLLECTION_REALITY_REGISTERED
Prompt Asset: PROMPT_ASSET_061

## Source

Local repository files only.

Live Firestore collections were not queried.

## Repo-Declared Collections

| Collection | Source | Classification | Notes |
| --- | --- | --- | --- |
| clients | firestore.rules, storage.rules | LEGACY_COLLECTION | Maps loosely to client identity but not Generation 1 family. |
| clinicians | firestore.rules, storage.rules | LEGACY_COLLECTION | Should be reclassified under provider zones if retained. |
| centers | firestore.rules, storage.rules | LEGACY_COLLECTION | Should be reclassified under center zones if retained. |
| clinician_profile_change_requests | firestore.rules, indexes | LEGACY_COLLECTION | Provider registration/public parity source evidence. |
| center_profile_change_requests | firestore.rules, indexes | LEGACY_COLLECTION | Center registration/public parity source evidence. |
| support_requests | firestore.rules, indexes | LEGACY_COLLECTION | Legacy support surface. |
| provider_contact_requests | firestore.rules | LEGACY_COLLECTION | Public contact pathway source evidence. |
| center_contact_requests | firestore.rules | LEGACY_COLLECTION | Public contact pathway source evidence. |
| saved_destinations | firestore.rules | LEGACY_COLLECTION | Legacy discovery residue. |
| chat_threads | firestore.rules, indexes | LEGACY_COLLECTION | Legacy support/chat residue. |
| messages | firestore.rules, indexes | LEGACY_SUBCOLLECTION | Chat residue. |
| chat_escalations | firestore.rules | LEGACY_COLLECTION | Support/safety escalation residue. |
| reports | firestore.rules | LEGACY_SUBCOLLECTION | Chat escalation report residue. |
| system_domains | firestore.rules | LEGACY_GOVERNANCE_REFERENCE | Source evidence for governance only. |
| signal_events | firestore.rules, indexes | PARTIAL_MATCH | Related to signal family but not Generation 1 gateway model. |
| signal_aggregates | firestore.rules | PARTIAL_MATCH | Related to monitoring but not pure model. |
| analytics_summaries | functions/index.js | UNKNOWN | Functions output collection not in approved collection blueprint. |
| admins | storage.rules | FORBIDDEN_COMPONENT | Hidden/admin authority risk. |

## Active Collections

Unknown. Live Firestore state was not queried.

## Removal Candidate Collections

No live removal is authorized.

Potential future removal candidates must be determined after live inventory and archive evidence.

