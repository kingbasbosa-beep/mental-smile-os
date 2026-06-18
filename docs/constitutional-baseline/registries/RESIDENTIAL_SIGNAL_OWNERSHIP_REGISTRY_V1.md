# RESIDENTIAL_SIGNAL_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_OWNERSHIP_REGISTRY
Phase: 8B
Runtime effect: none

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Client goal signals | Archive/System | Archived client dashboard/personal space | none | goalSignals | none | ARCHIVED_HARD_REMOVED | Runtime archive | PURE_CLIENT_IDENTITY_REMOVED |
| Client interest signals | Archive/System | Archived client dashboard/personal space | none | interestSignals | none | ARCHIVED_HARD_REMOVED | Runtime archive | PURE_CLIENT_IDENTITY_REMOVED |
| Accessibility signals | Session/System | Accessibility/session surfaces | signal_events | accessibilitySignals | `signal_events` | ACTIVE_SESSION_SCOPED | Runtime | SESSION_SCOPED |
| Communication signals | Session/System | Accessible communication surfaces | signal_events | communicationSignals | `signal_events` | ACTIVE_SESSION_SCOPED | Runtime | SESSION_SCOPED |
| Saved destination signal | Session/System | Discovery save actions, Monitoring | SavedDestinationRepository | destinationSaved | `saved_destinations`, `signal_events` | ACTIVE_SESSION_SCOPED | Runtime | SESSION_SCOPED |
| Support request signal | Session/Support Observer | Support Room, Monitoring | Support Issue Selector | support/risk | `support_requests` | ACTIVE | Runtime | CROSS_DOMAIN |
| Chat escalation signal | Monitoring Operator | Chat escalation surfaces | Chat service | escalation | `chat_escalations` | ACTIVE | Runtime | CROSS_DOMAIN |

## Ghost Infrastructure Archival Guide Notes

| Entry | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Client-era goal signal candidate | Archive/System | none verified | OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1 | `goal_selected` | none | REMOVED_FROM_RUNTIME | Runtime archive | CLIENT_ERA_GHOST_SIGNAL |
| Client-era interest signal candidate | Archive/System | none verified | OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1 | `interest_selected` | none | REMOVED_FROM_RUNTIME | Runtime archive | CLIENT_ERA_GHOST_SIGNAL |
| Client-era accessibility interest candidate | Archive/System | none verified | OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1 | `accessibility_interest` | none | REMOVED_FROM_RUNTIME | Runtime archive | SUPERSEDED_SIGNAL |
| Communication preference candidate | Archive/System | none verified | OP-PACKAGE-A-GHOST-SIGNAL-PURGE-V1 | `communication_preference_selected` | none | REMOVED_FROM_RUNTIME | Runtime archive | GHOST_SIGNAL |
| Saved destination signal decision | Residential/Owner decision | Monitoring / saved destination workflow | SavedDestinationRepository | `destination_saved` | `saved_destinations`, `signal_events` | OWNER_DECISION_REQUIRED | Runtime decision | WRITEBACK_PURPOSE_UNCLEAR |
