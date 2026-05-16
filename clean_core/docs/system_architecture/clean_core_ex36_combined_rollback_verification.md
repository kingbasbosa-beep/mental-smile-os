# EX-36 Combined Rollback Verification

Phase: EX-36 - Combined Post-Move Verification

## Rollback Scope

Rollback remains isolated to:

- 15 moved files
- 15 explicit barrel export lines
- package-local corrections, if any are later introduced

No package-local corrections were required during the combined movement.

## Audit Rollback

Audit rollback would return the following files to `clean_core/lib/core/audit/`:

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

It would also remove the eight matching audit export lines.

## Human Review Rollback

Human review rollback would return the following files to `clean_core/lib/core/human_review/`:

- `escalation_audit_link.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

It would also remove the seven matching human review export lines.

## Non-Rollback Areas

Rollback should not touch:

- excluded audit files
- excluded human review files
- runtime marker files
- queue/boundary files
- host imports
- dependency files
- adapter/runtime/provider systems

## Rollback Finding

Rollback remains clear, isolated, and limited to the two approved safe batches.

