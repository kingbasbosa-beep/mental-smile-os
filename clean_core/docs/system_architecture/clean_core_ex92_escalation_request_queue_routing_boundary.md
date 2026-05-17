# EX-92 EscalationRequest Queue Routing Boundary

## Queue File

- `clean_core/lib/core/human_review/escalation_queue.dart`

## Queue Logic

`EscalationQueue` contains routing-adjacent matching logic through:

- accepted reasons
- accepted priorities
- visible-to scope
- allowed states
- `accepts`

## Boundary Finding

Queue acceptance is not passive metadata. It evaluates whether a reason, priority, and state match a queue profile. That logic must remain host/backend-owned.

## Request Relationship

`EscalationRequest` carries queue-relevant metadata:

- `reason`
- `priority`
- `state`
- `visibilityScope`

Those fields can be package-safe only if they do not imply queue admission, routing, scheduling, or assignment.

## Prohibited Queue Semantics

Future package request model must not:

- select a queue
- route work
- schedule review
- guarantee queue acceptance
- assign reviewers
- trigger escalation handling

## Queue/Routing Verdict

Queue and routing behavior remain excluded. Future package request model may carry passive labels only.
