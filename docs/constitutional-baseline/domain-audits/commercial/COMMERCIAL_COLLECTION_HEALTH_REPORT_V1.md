# COMMERCIAL_COLLECTION_HEALTH_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7B
Runtime effect: none

## Commercial Collections

| Collection | Purpose | Owner | Classification | Health |
| --- | --- | --- | --- | --- |
| `clinicians` | Specialists/provider discovery and profile source | Clinician/System | ACTIVE | PASS |
| `centers` | Center discovery and profile source | Center/System | ACTIVE | PASS |
| `provider_contact_requests` | Provider contact request records | Commercial/System | ACTIVE | PASS |
| `center_contact_requests` | Center contact request records | Commercial/System | ACTIVE | PASS |
| `saved_destinations` | Saved provider/center path records | Client/System | ACTIVE/CROSS_DOMAIN | PASS |
| `support_requests` | Handoff to support from commercial surfaces | Client/Support Observer | ACTIVE/CROSS_DOMAIN | PASS |
| `tool_registry` | Planned/unknown tool registry | Owner/System | UNKNOWN | UNKNOWN |

## Collection Measures

| Classification | Count |
| --- | ---: |
| Active | 4 |
| Active/Cross-domain | 2 |
| Legacy | 0 |
| Dead | 0 |
| Duplicate | 0 |
| Unknown | 1 |

## Notes

- Contact request collections are active and represent the post-booking commercial request pattern.
- `tool_registry` exists in governance inventory as unknown, not verified as active runtime storage.
