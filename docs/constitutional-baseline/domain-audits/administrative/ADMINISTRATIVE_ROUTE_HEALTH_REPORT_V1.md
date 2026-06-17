# ADMINISTRATIVE_ROUTE_HEALTH_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7C
Runtime effect: none

## Administrative Routes

| Route | Surface | Owner | Classification | Health |
| --- | --- | --- | --- | --- |
| `/login` | Login | Public/System | ACTIVE | PASS |
| `/register/client` | Client registration | Client/System | ACTIVE | PASS |
| `/web/clinician/register` | Clinician web registration | Clinician/System | ACTIVE | PASS |
| `/web/clinician/profile` | Clinician profile declaration | Clinician/System | ACTIVE | PASS |
| `/web/clinician/documents` | Clinician document declaration | Clinician/System | ACTIVE | PASS |
| `/web/center/register` | Center web registration | Center/System | ACTIVE | PASS |
| `/web/center/profile` | Center profile declaration | Center/System | ACTIVE | PASS |
| `/web/center/media` | Center media declaration | Center/System | ACTIVE | PASS |
| `/web/center/pricing` | Center pricing declaration | Center/System | ACTIVE | PASS |
| `/web/center/documents` | Center document declaration | Center/System | ACTIVE | PASS |
| `/web/register/success` | Registration success | System | ACTIVE | PASS |
| `/s/declaration-review-room` | Declaration Review Room | Declaration Reviewer | ACTIVE_READ_ONLY | PASS |
| `/clinician/profile-edit-request` | Clinician profile update declaration | Clinician | ACTIVE | PASS |
| `/center/profile-edit-request` | Center profile update declaration | Center | ACTIVE | PASS |
| `/register/clinician` | Clinician native alias | Clinician/System | ALIAS | WARNING |
| `/register/center` | Center native alias | Center/System | ALIAS | WARNING |
| `/register/provider` | Provider register portal | Public/System | LEGACY | WARNING |
| `/account-blocked` | Visibility/readiness/account block surface | System/Monitoring | CROSS_DOMAIN | PASS |

## Route Measures

| Classification | Count |
| --- | ---: |
| Active | 13 |
| Active read-only | 1 |
| Alias | 2 |
| Legacy | 1 |
| Cross-domain | 1 |
| Dead | 0 |
| Unknown | 0 |

## Notes

- Native clinician/center registration aliases point into web registration flow.
- Provider registration route is legacy language under Provider vs Clinician lineage.
- Declaration Review Room is read-only by code comment and implementation intent.
