# clean_core Human Review Export Safety

This document recommends future export posture for the human review lane. No exports were changed.

## Safe Future Export Candidates

Potential future curated exports after final review:

- `escalation_audit_link.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

## Export With Authority Caveat

Potential future export only with clear marker-only documentation:

- `escalation_boundary_marker.dart`

Reason: it references backend governance and client outcome writes.

## Keep Hidden/Internal

- `escalation_queue.dart`

Reason: it includes queue acceptance evaluation and could be mistaken for routing/assignment authority.

## Do Not Export Yet

- `escalation_assignment.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

Reason: Firestore-coupled and action/persistence oriented.

## Export Safety Verdict

Human review lane supports a future curated label/reference export subset, but whole-directory export is not safe.
