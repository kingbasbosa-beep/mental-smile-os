# clean_core Human Review Backend Authority Flags

This review flags backend authority concerns in the human review lane.

## Backend-Sensitive Files

- `escalation_boundary_marker.dart`
- `review_visibility_scope.dart`
- `escalation_queue.dart`
- `escalation_assignment.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`
- `escalation_request.dart`

## Backend-Sensitive Fields

- `backendGoverned`
- `clientOutcomeWritesAllowed`
- `backendOnly`
- `resolvedBy`
- `assignedBy`
- `reviewerId`
- `state`
- `outcomeKey`

## Authority Rules

- Backend owns trusted escalation execution.
- Backend owns final resolution authority where sensitive.
- Host/backend owns assignment runtime.
- clean_core labels do not authorize state transitions.
- client outcome writes remain blocked by default.

## Backend Verdict

Human review contracts can describe backend-governed review states, but they must not own authority or trusted persistence.
