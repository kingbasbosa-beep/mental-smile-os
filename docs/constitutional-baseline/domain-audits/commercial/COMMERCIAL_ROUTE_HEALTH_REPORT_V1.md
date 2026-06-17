# COMMERCIAL_ROUTE_HEALTH_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7B
Runtime effect: none

## Commercial Routes

| Route | Surface | Owner | Classification | Health |
| --- | --- | --- | --- | --- |
| `/module/specialists` | Specialists categories | System | ACTIVE | PASS |
| `/module/specialists/list` | Specialists list | System | ACTIVE | PASS |
| `/module/specialists/details` | Specialist details | System | ACTIVE | PASS |
| `/module/centers` | Centers landing | System | ACTIVE | PASS |
| `/module/centers/list` | Centers list | System | ACTIVE | PASS |
| `/module/centers/details` | Center details | System | ACTIVE | PASS |
| `/s/city` | City district | System | ACTIVE | PASS |
| `/s/city/services` | City services | System | ACTIVE/FUTURE | PARTIAL |
| `/s/city/tools` | City tools | Owner/System | UNKNOWN | PARTIAL |
| `/s/city/providers` | City providers | System | ACTIVE/FUTURE | PARTIAL |
| `/s/city/centers` | City centers | System | ACTIVE/FUTURE | PARTIAL |
| `/s/city/organizations` | City organizations | System | UNKNOWN | PARTIAL |
| `/s/city/programs` | City programs | System | UNKNOWN | PARTIAL |
| `/s/city/marketplace` | City marketplace | Owner/System | UNKNOWN | PARTIAL |
| `/request/service` | Portal service request | Public/System | ACTIVE/FUTURE | PARTIAL |
| `/request/package` | Portal package request | Public/System | ACTIVE/FUTURE | PARTIAL |
| `/register/provider` | Provider register portal | Public/System | LEGACY | WARNING |

## Route Measures

| Classification | Count |
| --- | ---: |
| Active | 8 |
| Active/Future | 5 |
| Legacy | 1 |
| Dead | 0 |
| Duplicate | 1 |
| Unknown | 4 |

## Notes

- `/register/provider` is legacy terminology because active runtime role language is clinician.
- City tools and marketplace routes exist but are not fully implemented commercial systems.
- Organizations and programs are present as city surfaces but remain unknown maturity.
