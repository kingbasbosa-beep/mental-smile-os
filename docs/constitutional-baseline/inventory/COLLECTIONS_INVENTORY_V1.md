# COLLECTIONS_INVENTORY_V1

Status: ACTIVE_INVENTORY
Phase: 6
Runtime effect: none

| Collection | Purpose | Owner | Status |
| --- | --- | --- | --- |
| `clients` | Client profiles and personal-space entry | Client/System | ACTIVE |
| `clinicians` | Clinician profiles, registration, discovery | Clinician/System | ACTIVE |
| `centers` | Center profiles, registration, discovery | Center/System | ACTIVE |
| `saved_destinations` | Client saved destination records | Client/System | ACTIVE |
| `support_requests` | Support issue/request records | Client/Support Observer | ACTIVE |
| `chat_threads` | Chat thread records | Client/System | ACTIVE |
| `chat_threads/{id}/messages` | Chat thread messages | Client/System | ACTIVE |
| `chat_escalations` | Chat escalation records | Monitoring Operator | ACTIVE |
| `chat_escalations/{id}/reports` | Escalation reports | Monitoring Operator | ACTIVE |
| `signal_events` | Signal event storage | Monitoring/System | ACTIVE |
| `clinician_profile_change_requests` | Clinician profile change review | Declaration Reviewer | ACTIVE |
| `center_profile_change_requests` | Center profile change review | Declaration Reviewer | ACTIVE |
| `provider_contact_requests` | Provider contact requests | Commercial/System | ACTIVE |
| `center_contact_requests` | Center contact requests | Commercial/System | ACTIVE |
| `system_domains` | Domain status service/seeder records | Owner/System | ACTIVE |
| `ai_policies` | AI policy seeder records | Owner/System | UNKNOWN |
| dynamic account access collections | Account access lookup by collection/doc id | System | UNKNOWN |

## Counts

- Total collection entries inventoried: 17
- ACTIVE: 15
- UNKNOWN: 2
- LEGACY: 0
- SHADOW: 0
- ARCHIVED: 0
