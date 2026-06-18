# Collection Registry V1

Status: ACTIVE_BASELINE_REGISTRY
Classification: EXISTING_HISTORICAL_PROMOTE
Runtime effect: none

## Historical References

- `mental-smile-os-workspace/docs/mental-smile-os/pure-runtime/ACTIVE_RUNTIME_COLLECTION_REGISTRY_V1.md`
- historical references to `GENERATION_1_APPROVED_COLLECTION_REGISTRY_V1`

## Baseline Collections

| Collection | Status |
| --- | --- |
| `clients` | ARCHIVED_HARD_REMOVED |
| `clinicians` | ACTIVE |
| `centers` | ACTIVE |
| `provider_contact_requests` | ACTIVE_SESSION_SCOPED |
| `center_contact_requests` | ACTIVE_SESSION_SCOPED |
| `saved_destinations` | ACTIVE_SESSION_SCOPED |
| `support_requests` | ACTIVE |
| `chat_threads` | ACTIVE |
| `chat_threads/{threadId}/messages` | ACTIVE |
| `chat_escalations` | ACTIVE |
| `chat_escalations/{escalationId}/reports` | ACTIVE |
| `signal_events` | ACTIVE |
| `signal_aggregates` | ACTIVE |
| `system_domains` | ACTIVE_GOVERNANCE |
| `ai_policies` | SHADOW |
| `analytics_summaries` | SHADOW_OPS |
| `booking_requests` | ARCHIVE_CANDIDATE |
| `tool_registry` | UNKNOWN |

## Ghost Infrastructure Archival Guide Collection Notes

| Collection / Collection Name | Status | Related Guide | Related Operation | Note |
| --- | --- | --- | --- | --- |
| `saved_destinations` | OWNER_DECISION_REQUIRED | `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` | OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1 | Session-scoped writes exist, but user-visible readback journey was not found in the Purpose Null Audit. |
| `signal_aggregates` | OWNER_DECISION_REQUIRED | `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` | OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1 | Read rules/models exist, but aggregate write lifecycle requires focused audit before activation or removal. |
| `accessibility_resources` | ARCHIVAL_CARD_CREATED_PENDING_OWNER_DECISION | `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` | OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1 | Model collection name exists while current accessibility resources are static sample data. |
| `ai_policies` | OWNER_DECISION_REQUIRED | `GHOST_INFRASTRUCTURE_ARCHIVAL_GUIDE_V1.md` | OP-GHOST-INFRASTRUCTURE-ARCHIVAL-GUIDE-V1 | Registry/seeder references exist without a confirmed Firestore rule path in the Purpose Null Audit. |

## Rule

No collection creation, deletion, or rule change before Owner-approved collection governance.
