# ADMINISTRATIVE_COLLECTION_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `clients` | Client/System | client registration, login routing | Firebase Auth | client registration | `clients` | ACTIVE | Runtime | ACTIVE |
| `clinicians` | Clinician/System | registration, declaration review, discovery | Firebase Auth, readiness | declaration readiness | `clinicians` | ACTIVE | Runtime | ACTIVE |
| `centers` | Center/System | registration, declaration review, discovery | Firebase Auth, readiness | declaration readiness | `centers` | ACTIVE | Runtime | ACTIVE |
| `clinician_profile_change_requests` | Clinician/Declaration Reviewer | clinician room, declaration review | Firestore | profile declaration | `clinician_profile_change_requests` | ACTIVE | Runtime | ACTIVE |
| `center_profile_change_requests` | Center/Declaration Reviewer | center room, declaration review | Firestore | profile declaration | `center_profile_change_requests` | ACTIVE | Runtime | ACTIVE |
