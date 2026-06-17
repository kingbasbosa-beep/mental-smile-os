# RESIDENTIAL_SIGNAL_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Client goal signals | Client/System | Client Dashboard, Personal Space | `clients.clientSignals` | goalSignals | `clients` | ACTIVE | Runtime | ACTIVE |
| Client interest signals | Client/System | Client Dashboard, Personal Space | `clients.clientSignals` | interestSignals | `clients` | ACTIVE | Runtime | ACTIVE |
| Accessibility signals | Client/System | Personal Space | `clients.clientSignals` | accessibilitySignals | `clients` | ACTIVE | Runtime | ACTIVE |
| Communication signals | Client/System | Personal Space | `clients.clientSignals` | communicationSignals | `clients` | ACTIVE | Runtime | ACTIVE |
| Saved destination signal | Client/System | Personal Space, Monitoring | SavedDestinationRepository | destinationSaved | `saved_destinations`, `signal_events` | ACTIVE | Runtime | ACTIVE |
| Support request signal | Client/Support Observer | Support Room, Monitoring | Support Issue Selector | support/risk | `support_requests` | ACTIVE | Runtime | CROSS_DOMAIN |
| Chat escalation signal | Monitoring Operator | Chat escalation surfaces | Chat service | escalation | `chat_escalations` | ACTIVE | Runtime | CROSS_DOMAIN |
