# ADMINISTRATIVE_COLLECTION_HEALTH_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7C
Runtime effect: none

## Administrative Collections

| Collection | Purpose | Owner | Classification | Health |
| --- | --- | --- | --- | --- |
| `clients` | client registration records | Client/System | ACTIVE | PASS |
| `clinicians` | clinician registration, declaration, profile, readiness | Clinician/System | ACTIVE | PASS |
| `centers` | center registration, declaration, profile, readiness | Center/System | ACTIVE | PASS |
| `clinician_profile_change_requests` | clinician profile update declarations | Clinician/Declaration Reviewer | ACTIVE | PASS |
| `center_profile_change_requests` | center profile update declarations | Center/Declaration Reviewer | ACTIVE | PASS |

## Collection Measures

| Classification | Count |
| --- | ---: |
| Active | 5 |
| Legacy | 0 |
| Dead | 0 |
| Duplicate | 0 |
| Unknown | 1 |

## Unknowns

- Whether declaration review decisions are intended to mutate source profile records directly is not fully represented as a dedicated collection or registry in the current documentation.

## Notes

- Web registration writes directly to `clinicians` and `centers`.
- Profile changes are separated into request/declaration collections.
- Declaration Review Room observes source and change-request collections.
