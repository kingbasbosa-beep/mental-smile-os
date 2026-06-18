# RESIDENTIAL_COLLECTION_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `clients` | Archive/System | Archived client identity | none | none | `clients` | ARCHIVED_HARD_REMOVED | Runtime archive | PURE_CLIENT_IDENTITY_REMOVED |
| `saved_destinations` | Archive/System | Archived discovery save actions | OP-SAVED-DESTINATIONS-EXTRACTION-V1 | none | none | REMOVED_FROM_RUNTIME | Runtime archive | FRESH_SIGNALS_DOCTRINE_REMOVAL |
| `support_requests` | Client/Support Observer | Support Room, Monitoring | Firestore, support selector | support/risk/technical | `support_requests` | ACTIVE | Runtime | CROSS_DOMAIN |
| `chat_threads` | Client/System | Chat | Firestore, chat service | chat activity | `chat_threads` | ACTIVE | Runtime | ACTIVE |
| `chat_threads/{threadId}/messages` | Client/System | Chat | Firestore, chat service | message activity | subcollection | ACTIVE | Runtime | ACTIVE |
| `signal_events` | System/Monitoring | Session surfaces, Monitoring | Signal storage | signal packages | `signal_events` | ACTIVE_SESSION_SCOPED | Runtime | CROSS_DOMAIN |
