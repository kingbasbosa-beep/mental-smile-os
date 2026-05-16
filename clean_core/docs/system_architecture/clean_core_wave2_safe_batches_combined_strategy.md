# clean_core Wave 2 Safe Batches Combined Strategy

EX-31 defines a combined movement strategy for the two approved Wave 2 safe batches. No files were moved, exports modified, imports rewritten, dependencies added, adapters created, runtime activated, or providers reconnected.

## Approved Safe Batches

### Wave 2 Batch A1: Audit Safe Batch

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

### Wave 2 Batch A2: Human Review Safe Batch

- `escalation_audit_link.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

## Strategy Decision

Prefer two sequential movements, not one combined movement.

Reason:

- rollback clarity stays stronger
- export review remains smaller
- stop conditions are easier to isolate
- host impact remains easier to confirm
- each lane retains its own semantic boundary

## Combined Strategy Verdict

Wave 2 safe movement should be staged as:

1. Batch A1: audit safe batch.
2. Batch A2: human review safe batch.
3. Stop before reconnect.

Movement is not executed in EX-31.
