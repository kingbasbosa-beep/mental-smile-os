# MONITORING_ARCHITECTURE_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7E
Runtime effect: none

## Scope

Monitoring Domain includes Monitoring Room, Signal Monitoring, Escalations, Aggregates, and Observability.

## Active Architecture

| System | Primary Files | Classification | Health |
| --- | --- | --- | --- |
| Signal monitoring room | `lib/features/s_capital/presentation/pages/s_signal_monitoring_room_page.dart` | ACTIVE | PASS |
| Capital operations surfaces | `lib/features/s_capital/presentation/pages/s_capital_operations_office_page.dart` | ACTIVE | PASS |
| Support Room observation | `lib/features/s_support_room/presentation/pages/s_support_room_page.dart` | ACTIVE_READ_ONLY | PASS |
| Chat escalations page | `lib/features/safety/presentation/pages/chat_escalations_page.dart` | ACTIVE | PASS |
| Chat escalation report page | `lib/features/chat/presentation/pages/chat_escalation_report_page.dart` | ACTIVE | PASS |
| Chat escalation service/model | `lib/features/chat/data/services/chat_firestore_service.dart`, `chat_escalation_model.dart` | ACTIVE | PASS |
| Signal storage service | `lib/features/signals/data/services/signal_storage_service.dart` | ACTIVE | PASS |
| Signal package and registries | `lib/features/signals/domain/**` | ACTIVE | PASS |
| Monitoring core | `lib/features/monitoring/domain/**` | ACTIVE | PASS |
| Residential monitoring | `lib/features/monitoring/residential/**` | ACTIVE | PASS |
| Commercial monitoring | `lib/features/monitoring/commercial/**` | ACTIVE | PASS |
| Domain status service | `lib/core/system/domain_status_service.dart` | ACTIVE | PASS |

## Monitoring Routes

| Route | Surface | Classification |
| --- | --- | --- |
| `/s/capital` | Capital home | ACTIVE |
| `/s/capital/operations-office` | Operations office | ACTIVE |
| `/s/capital/incidents` | Incidents | ACTIVE |
| `/s/capital/maintenance` | Maintenance | ACTIVE |
| `/s/capital/broadcasts` | Broadcasts | ACTIVE |
| `/s/capital/emergency-brief` | Emergency brief | ACTIVE |
| `/s/capital/signal-monitoring-room` | Signal Monitoring Room | ACTIVE |
| `/s/capital/departments` | Departments | ACTIVE |
| `/s/capital/trust-safety` | Trust Safety | ACTIVE |
| `/s/capital/reports` | Capital Reports | ACTIVE |
| `/chat/escalations` | Chat Escalations | ACTIVE |
| `/chat/escalation/report` | Chat Escalation Report | ACTIVE |
| `/s/support-room` | Support Room | CROSS_DOMAIN |
| `/account-blocked` | Account/visibility block | CROSS_DOMAIN |

## Collections

| Collection | Purpose | Classification |
| --- | --- | --- |
| `signal_events` | signal event stream | ACTIVE |
| `chat_escalations` | chat escalation records | ACTIVE |
| `chat_escalations/{id}/reports` | escalation reports | ACTIVE |
| `support_requests` | support/risk/technical signals | ACTIVE_CROSS_DOMAIN |
| `system_domains` | domain status observation | ACTIVE |

## Measures

| Classification | Items |
| --- | --- |
| Active | signal monitoring, capital rooms, chat escalations, signal registries, monitoring aggregates |
| Legacy | Control Room Era naming risk in doctrine |
| Dead | none confirmed |
| Duplicate | Support Room is both Residential support and Monitoring observation |
| Unknown | runtime persistence for aggregate read models, authority registry for monitoring mutations |

## Architecture Health

Monitoring architecture is deeper than the UI surfaces: signal packages, registries, aggregate validators, residential/commercial monitoring modules, and domain status services exist. The core risk is not absence of architecture; it is authority boundary hardening so monitoring remains observability, not control.
