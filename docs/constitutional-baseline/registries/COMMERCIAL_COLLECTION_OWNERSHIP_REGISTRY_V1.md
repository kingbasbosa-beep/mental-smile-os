# COMMERCIAL_COLLECTION_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `clinicians` | Clinician/System | Specialists discovery | Firestore | providerSignals | `clinicians` | ACTIVE | Runtime | ACTIVE |
| `centers` | Center/System | Centers discovery | Firestore | center signals | `centers` | ACTIVE | Runtime | ACTIVE |
| `provider_contact_requests` | Commercial/System | Specialist details | ContactRequestRepository | providerContactStarted | `provider_contact_requests` | ACTIVE_SESSION_SCOPED | Runtime | SESSION_SCOPED |
| `center_contact_requests` | Commercial/System | Center details | ContactRequestRepository | centerContactStarted | `center_contact_requests` | ACTIVE_SESSION_SCOPED | Runtime | SESSION_SCOPED |
| `saved_destinations` | Archive/System | Archived discovery save actions | OP-SAVED-DESTINATIONS-EXTRACTION-V1 | none | none | REMOVED_FROM_RUNTIME | Runtime archive | FRESH_SIGNALS_DOCTRINE_REMOVAL |
| `tool_registry` | Owner/System | Future tools | Governance decision | future tool signals | `tool_registry` | UNKNOWN | Future | UNKNOWN |
