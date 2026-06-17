# COMMERCIAL_ROUTE_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `/module/specialists` | System | Clients, discovery | Router, specialist catalog | discovery intent | `clinicians` | ACTIVE | Runtime | ACTIVE |
| `/module/specialists/list` | System | Clients, discovery | Firestore clinicians | providerSignals | `clinicians` | ACTIVE | Runtime | ACTIVE |
| `/module/specialists/details` | System | Clients, contact requests | ContactRequestRepository | provider contact/saved destination | `clinicians`, `provider_contact_requests`, `saved_destinations` | ACTIVE | Runtime | ACTIVE |
| `/module/centers` | System | Clients, discovery | Router | discovery intent | `centers` | ACTIVE | Runtime | ACTIVE |
| `/module/centers/list` | System | Clients, discovery | CentersFirestoreService | center discovery | `centers` | ACTIVE | Runtime | ACTIVE |
| `/module/centers/details` | System | Clients, contact requests | ContactRequestRepository | center contact/saved destination | `centers`, `center_contact_requests`, `saved_destinations` | ACTIVE | Runtime | ACTIVE |
| `/s/city/tools` | Owner/System | Public city users | Router placeholder | future tool signals | `tool_registry` | UNKNOWN | Future | UNKNOWN |
| `/s/city/marketplace` | Owner/System | Public city users | Router placeholder | future marketplace signals | unknown | UNKNOWN | Future | UNKNOWN |
| `/register/provider` | Public/System | Public registration | Router | provider registration intent | `clinicians` | PRESENT | Transitional | LEGACY |
