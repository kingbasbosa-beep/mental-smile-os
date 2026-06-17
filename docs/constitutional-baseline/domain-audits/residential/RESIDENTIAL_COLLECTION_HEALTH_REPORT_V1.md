# RESIDENTIAL_COLLECTION_HEALTH_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7A
Runtime effect: none

## Residential Collections

| Collection | Residential Purpose | Owner | Classification | Health |
| --- | --- | --- | --- | --- |
| `clients` | Client profile and client signal fields | Client/System | ACTIVE | PASS |
| `saved_destinations` | Client saved continuation destinations | Client/System | ACTIVE | PASS |
| `support_requests` | Structured support signals and requests | Client/Support Observer | ACTIVE | PASS |
| `chat_threads` | Chat conversation root records | Client/System | ACTIVE | PASS |
| `chat_threads/{threadId}/messages` | Chat message records | Client/System | ACTIVE | PASS |
| `chat_escalations` | Escalation records from chat | Monitoring Operator | ACTIVE | CROSS_DOMAIN |
| `chat_escalations/{escalationId}/reports` | Escalation reports | Monitoring Operator | ACTIVE | CROSS_DOMAIN |
| `signal_events` | Personal/residential signal event stream | Monitoring/System | ACTIVE | PASS |

## Collection Measures

| Classification | Count |
| --- | ---: |
| Active | 8 |
| Legacy | 0 |
| Dead | 0 |
| Unknown | 0 |
| Duplicate | 0 |
| Missing | 1 |

## Missing Collection Governance

- A dedicated residential collection ownership registry is not yet materialized.

## Notes

- Residential data is spread across profile, signal, support, saved destination, and chat collections.
- Monitoring-owned escalation collections are legitimate cross-domain collections.
