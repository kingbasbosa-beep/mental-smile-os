# EX-82 EscalationAssignment Authority Detox

## Authority-Sensitive Fields

- `assignedTo`
- `assignedBy`
- `state`

## Required Caveats

- `assignedTo` is metadata only and does not prove reviewer or team authorization.
- `assignedBy` is metadata only and does not prove assignment authority.
- `state` is passive and does not progress workflow.
- `assignedAt` is timestamp metadata only and does not prove backend scheduling or execution.
- The assignment record does not route, approve, execute, or own escalation workflow.

## Prohibited Meanings

Package `EscalationAssignment` must not imply:

- assignment authority
- reviewer/team authorization
- queue routing
- backend ownership
- escalation approval
- operational dispatch

## Verdict

Authority detox is viable with explicit caveats.
