# RESIDENTIAL_COLLECTION_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `clients` | Client/System | Client Room, Personal Space | Auth, Firestore | clientSignals | `clients` | ACTIVE | Runtime | ACTIVE |
| `saved_destinations` | Client/System | Client dashboard, saved repo | Auth, Firestore | destinationSaved | `saved_destinations` | ACTIVE | Runtime | ACTIVE |
| `support_requests` | Client/Support Observer | Support Room, Monitoring | Firestore, support selector | support/risk/technical | `support_requests` | ACTIVE | Runtime | CROSS_DOMAIN |
| `chat_threads` | Client/System | Chat | Firestore, chat service | chat activity | `chat_threads` | ACTIVE | Runtime | ACTIVE |
| `chat_threads/{threadId}/messages` | Client/System | Chat | Firestore, chat service | message activity | subcollection | ACTIVE | Runtime | ACTIVE |
| `signal_events` | System/Monitoring | Personal Space, Monitoring | Signal storage | signal packages | `signal_events` | ACTIVE | Runtime | CROSS_DOMAIN |
