# Firebase Collection Decision Matrix V1

Status: COLLECTION_DECISION_MATRIX_CREATED
Prompt Asset: PROMPT_ASSET_062

## Collection Decisions

| Discovered Collection | Decision | Generation 1 Fate | Notes |
| --- | --- | --- | --- |
| clients | MIGRATE_TO_GENERATION_1 | app_screen_state / app identity model later | Must not be reused as-is. |
| providers | UNKNOWN | provider_public_profiles or provider_registration_records | Not directly discovered; requested concept requires verification. |
| clinicians | MIGRATE_TO_GENERATION_1 | provider_registration_records / provider_public_profiles | Rename/reclassify provider vocabulary. |
| centers | MIGRATE_TO_GENERATION_1 | center_registration_records / center_public_profiles | Split registration/public. |
| clinician_profile_change_requests | MIGRATE_TO_GENERATION_1 | provider_registration_records | Source evidence for review/status workflow. |
| center_profile_change_requests | MIGRATE_TO_GENERATION_1 | center_registration_records | Source evidence for review/status workflow. |
| signal_events | KEEP_AND_REFACTOR | app_room_signals or gateway-owned signal collections | Must conform to gateway model. |
| signal_aggregates | KEEP_AND_REFACTOR | monitoring_reports or archive summaries | Client-side aggregate writes remain forbidden. |
| support_requests | ARCHIVE_AS_HISTORICAL_EVIDENCE | None direct | Legacy support surface. |
| chat_threads | ARCHIVE_AS_HISTORICAL_EVIDENCE | None direct | Legacy support/chat residue. |
| messages | ARCHIVE_AS_HISTORICAL_EVIDENCE | None direct | Chat subcollection residue. |
| chat_escalations | ARCHIVE_AS_HISTORICAL_EVIDENCE | None direct | Legacy escalation residue. |
| reports | ARCHIVE_AS_HISTORICAL_EVIDENCE | archive_snapshots only after rebuild | Source evidence. |
| provider_contact_requests | MIGRATE_TO_GENERATION_1 | provider_public_profiles contact pathway package | Rebuild under public zone. |
| center_contact_requests | MIGRATE_TO_GENERATION_1 | center_public_profiles contact pathway package | Rebuild under public zone. |
| saved_destinations | ARCHIVE_AS_HISTORICAL_EVIDENCE | None direct | Legacy discovery residue. |
| system_domains | KEEP_AND_REFACTOR | owner_authority_records | Rebuild governance authority model. |
| analytics_summaries | UNKNOWN | strategic_reports or monitoring_reports if approved | Functions output not in approved blueprint. |
| admins | REMOVE_AFTER_ARCHIVE | Forbidden | Hidden/admin authority forbidden. |
| booking_requests | REMOVE_AFTER_ARCHIVE | Forbidden | Not directly discovered in primary rules; concept forbidden. |

## Rule

No discovered legacy collection is KEEP_AS_IS.

