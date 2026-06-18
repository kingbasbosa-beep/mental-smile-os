# COMMERCIAL_ROUTE_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `/module/specialists` | System | Session users, discovery | Router, specialist catalog | discovery intent | `clinicians` | ACTIVE | Runtime | SESSION_SCOPED |
| `/module/specialists/list` | System | Session users, discovery | Firestore clinicians | providerSignals | `clinicians` | ACTIVE | Runtime | SESSION_SCOPED |
| `/module/specialists/details` | System | Session users, contact requests | ContactRequestRepository | provider contact/saved destination | `clinicians`, `provider_contact_requests`, `saved_destinations` | ACTIVE | Runtime | SESSION_SCOPED |
| `/module/centers` | System | Session users, discovery | Router | discovery intent | `centers` | ACTIVE | Runtime | SESSION_SCOPED |
| `/module/centers/list` | System | Session users, discovery | CentersFirestoreService | center discovery | `centers` | ACTIVE | Runtime | SESSION_SCOPED |
| `/module/centers/details` | System | Session users, contact requests | ContactRequestRepository | center contact/saved destination | `centers`, `center_contact_requests`, `saved_destinations` | ACTIVE | Runtime | SESSION_SCOPED |
| `/s/city/tools` | Owner/System | Public city users | Router placeholder | future tool signals | `tool_registry` | UNKNOWN | Future | UNKNOWN |
| `/s/city/marketplace` | Owner/System | Public city users | Router placeholder | future marketplace signals | unknown | UNKNOWN | Future | UNKNOWN |
| `/register/provider` | Public/System | Public registration | Router | provider registration intent | `clinicians` | PRESENT | Transitional | LEGACY |
