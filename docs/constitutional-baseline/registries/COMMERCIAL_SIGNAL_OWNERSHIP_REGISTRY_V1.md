# COMMERCIAL_SIGNAL_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Provider capability signals | Clinician/System | Specialists list/details | clinician profiles | providerSignals.capabilitySignals | `clinicians` | ACTIVE | Runtime | ACTIVE |
| Provider contact started | Commercial/System | Contact requests, Monitoring future | ContactRequestRepository | providerContactStarted | `provider_contact_requests` | ACTIVE | Runtime | ACTIVE |
| Center contact started | Commercial/System | Contact requests, Monitoring future | ContactRequestRepository | centerContactStarted | `center_contact_requests` | ACTIVE | Runtime | ACTIVE |
| Center discovery signals | Center/System | Centers list/details | center profiles | center capability/readiness | `centers` | ACTIVE | Runtime | ACTIVE |
| Tool usage signals | Owner/System | Future tools/monitoring | Tool Registry | tool usage | `tool_registry` | UNKNOWN | Future | UNKNOWN |
| Marketplace signals | Owner/System | Future marketplace/monitoring | Domain Boundary Registry | marketplace intent | unknown | UNKNOWN | Future | UNKNOWN |
