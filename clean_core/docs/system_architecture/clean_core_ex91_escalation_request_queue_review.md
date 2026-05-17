# EX-91 EscalationRequest Queue Review

## Queue File Reviewed

- `clean_core/lib/core/human_review/escalation_queue.dart`

## Queue Semantics

`EscalationQueue` contains:

- queue id;
- accepted reasons;
- accepted priorities;
- visible-to scope;
- allowed states;
- `accepts` matching logic.

## Risk Finding

`EscalationQueue.accepts` is behavioral matching logic. It is more than passive vocabulary and should not be bundled into a package request split.

## Request Impact

`EscalationRequest` does not import `EscalationQueue`, but it carries the exact fields that queues use to decide acceptance:

- `reason`
- `priority`
- `state`
- `visibilityScope`

This creates queue-adjacent semantics.

## Boundary Rule

Future package request models must not claim queue admission, queue routing, scheduling, or review assignment. Queue matching remains host/backend-owned.

## Verdict

Queue semantics are a blocker for direct execution. They do not block a future metadata-only request model, but they require explicit queue-detox caveats first.
