# SIGNALS_INVENTORY_V1

Status: ACTIVE_INVENTORY
Phase: 6
Runtime effect: none

## Signal Sources

| Source | Domain | Status |
| --- | --- | --- |
| Library category opening | Library | ACTIVE |
| Personal Space signal board | Residential | ACTIVE |
| Chat threads/messages | Residential | ACTIVE |
| Chat escalations | Monitoring | ACTIVE |
| Support issue selector | Residential | ACTIVE |
| Domain status service | Monitoring/Owner | ACTIVE |

## Signal Consumers

| Consumer | Domain | Status |
| --- | --- | --- |
| Signal Monitoring Room | Monitoring | ACTIVE |
| Personal Space | Residential | ACTIVE |
| Owner strategic systems | Owner | ACTIVE |
| Chat escalation reports | Monitoring | ACTIVE |

## Signal Registries

| Registry | Status |
| --- | --- |
| Dedicated signal registry | UNKNOWN |
| Domain registry signal source/consumer columns | ACTIVE |
| Existing signal storage service constants | ACTIVE |

## Signal Collections

| Collection | Status |
| --- | --- |
| `signal_events` | ACTIVE |
| `chat_escalations` | ACTIVE |
| `chat_escalations/{id}/reports` | ACTIVE |
| `support_requests` | ACTIVE |
| `system_domains` | ACTIVE |

## Signal Topology

Signal-producing rooms and modules write or imply signal records. Monitoring consumes signal records. Owner systems consume summarized signal and governance memory. No Firebase mutation occurred in this inventory.

## Counts

- Signal sources inventoried: 6
- Signal consumers inventoried: 4
- Signal collections inventoried: 5
- Unknown signal registries: 1
