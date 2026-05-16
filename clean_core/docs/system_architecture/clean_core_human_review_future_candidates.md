# clean_core Human Review Future Candidates

This document proposes future human review extraction candidates without executing extraction.

## Candidate Batch A: Safe Labels and References

- `escalation_audit_link.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

## Candidate Batch B: Boundary Marker Review

- `escalation_boundary_marker.dart`

Requires explicit backend-authority documentation.

## Hidden/Internal Candidate

- `escalation_queue.dart`

Requires queue authority and routing review before export.

## Blocked Until Split

- `escalation_assignment.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

Required split:

- pure Dart contract model
- host/backend Firestore mapper
- host/backend assignment/review/resolution execution

## Candidate Verdict

Human review lane is partially suitable for future staged extraction, starting with label/reference contracts only.
