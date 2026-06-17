# MONITORING_AUTHORITY_REGISTRY_V1

Status: ACTIVE_GOVERNANCE_REGISTRY
Phase: 8A
Runtime effect: none

## Purpose

Define Monitoring authority so monitoring observes, reports, aggregates, and escalates without becoming hidden admin/control authority.

## Authority

Monitoring Operator may observe registered monitoring surfaces. Support Observer may observe registered support signals. Owner approves any monitoring mutation or intervention flow.

## Owner

Owner, with Monitoring Operator as operational observer.

## Consumers

- Monitoring Room.
- Signal Monitoring Room.
- Support Room.
- Chat Escalation surfaces.
- Operations Registry.
- Future escalation ownership registry.

## Inputs

- `signal_events`.
- `support_requests`.
- `chat_escalations`.
- `chat_escalations/{id}/reports`.
- `system_domains`.
- Signal aggregates.

## Outputs

- Observation.
- Escalation report.
- Aggregate view.
- Domain status context.
- Owner-facing monitoring memory.

## Dependencies

- Signal registries.
- Domain Boundary Registry.
- Owner Approval Registry.
- Collection Registry.
- Route Registry.
- Governance Decision Registry.

## Escalation Path

Signal/event -> Monitoring observation -> Escalation report if needed -> Owner decision if intervention/mutation is required.

## Compliance Status

ACTIVE_REQUIRED

Monitoring is observability-first. Any write, resolution, intervention, authority expansion, or operational command requires Owner approval and decision registry entry.

## Authority Matrix

| Capability | Monitoring Operator | Support Observer | Owner Approval |
| --- | --- | --- | --- |
| View signal monitoring room | YES | NO | Existing role gate |
| View support room | OWNER/Support Observer | YES | Existing role gate |
| View escalations | YES | NO | Existing role gate |
| Create reports | LIMITED_EXISTING_FLOW | NO | Required for expansion |
| Resolve/intervene | NO_BY_DEFAULT | NO | REQUIRED |
| Mutate domain status | NO_BY_DEFAULT | NO | REQUIRED |
