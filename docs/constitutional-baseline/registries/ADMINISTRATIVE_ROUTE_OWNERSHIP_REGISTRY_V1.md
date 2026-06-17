# ADMINISTRATIVE_ROUTE_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `/login` | Public/System | all roles | Firebase Auth, account access | auth state | role/account docs | ACTIVE | Runtime | ACTIVE |
| `/register/client` | Client/System | public clients | Firebase Auth, Firestore | client registration | `clients` | ACTIVE | Runtime | ACTIVE |
| `/web/clinician/register` | Clinician/System | clinicians | Firebase Auth, readiness | declaration signals | `clinicians` | ACTIVE | Runtime | ACTIVE |
| `/web/clinician/profile` | Clinician/System | clinicians | Firestore | profile declaration | `clinicians` | ACTIVE | Runtime | ACTIVE |
| `/web/clinician/documents` | Clinician/System | clinicians | Firestore, readiness | document declaration | `clinicians` | ACTIVE | Runtime | ACTIVE |
| `/web/center/register` | Center/System | centers | Firebase Auth, readiness | declaration signals | `centers` | ACTIVE | Runtime | ACTIVE |
| `/web/center/profile` | Center/System | centers | Firestore | profile declaration | `centers` | ACTIVE | Runtime | ACTIVE |
| `/web/center/media` | Center/System | centers | Firestore | media declaration | `centers` | ACTIVE | Runtime | ACTIVE |
| `/web/center/pricing` | Center/System | centers | Firestore | pricing declaration | `centers` | ACTIVE | Runtime | ACTIVE |
| `/web/center/documents` | Center/System | centers | Firestore | document declaration | `centers` | ACTIVE | Runtime | ACTIVE |
| `/s/declaration-review-room` | Declaration Reviewer/Owner | reviewer, owner | role gate, Firestore | declaration observation | `clinicians`, `centers`, profile request collections | ACTIVE | Runtime | ACTIVE_READ_ONLY |
| `/register/clinician` | Clinician/System | app registration alias | router | registration intent | `clinicians` | PRESENT | Transitional | ALIAS |
| `/register/center` | Center/System | app registration alias | router | registration intent | `centers` | PRESENT | Transitional | ALIAS |
