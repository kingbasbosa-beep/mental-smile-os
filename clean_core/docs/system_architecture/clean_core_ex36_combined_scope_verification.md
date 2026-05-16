# EX-36 Combined Scope Verification

Phase: EX-36 - Combined Post-Move Verification

## Scope

This document verifies the combined movement scope after:

- EX-33 Audit Batch A1
- EX-35 Human Review Batch A2

No reconnect, dependency change, export expansion beyond approved file-by-file exports, runtime activation, provider activation, or adapter creation occurred during this verification phase.

## Moved Audit Batch A1 Files

The following eight files are present under `mental_smile_clean_core/lib/src/audit/`:

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

## Moved Human Review Batch A2 Files

The following seven files are present under `mental_smile_clean_core/lib/src/human_review/`:

- `escalation_audit_link.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

## Excluded Audit Files

The following excluded audit files remain under `clean_core/lib/core/audit/`:

- `audit_event.dart`
- `audit_runtime_marker.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`
- `safety_observability_contract.dart`

## Excluded Human Review Files

The following excluded human review files remain under `clean_core/lib/core/human_review/`:

- `escalation_assignment.dart`
- `escalation_boundary_marker.dart`
- `escalation_queue.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

## Scope Finding

The combined movement scope is limited to the approved 15 files. No whole-directory movement occurred.

