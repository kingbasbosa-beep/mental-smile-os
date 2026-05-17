# EX-73 Human Review Candidate Ranking

## Highest Safety Candidates

1. `escalation_level.dart`
2. `review_priority.dart`
3. `review_visibility_scope.dart`
4. `escalation_state.dart`
5. `escalation_reason.dart`

These are pure enum/key vocabulary files. They still require semantic caveats because level, priority, visibility, state, and reason labels can be misread as routing, access, workflow, provider, or authority guarantees.

## Medium Safety Candidates

1. `escalation_audit_link.dart`
2. `escalation_policy_reference.dart`

These are small metadata contracts but include `toMap`. Package-safe versions should remove serialization ownership and caveat trace hash, policy version, snapshot id, and hash placeholder semantics.

## Mapper-Bound Candidates

1. `escalation_assignment.dart`
2. `escalation_resolution.dart`
3. `escalation_review.dart`
4. `escalation_request.dart`

These require additive split with host-side Firestore mappers and compatibility paths preserved.

## High-Risk / Defer Candidates

1. `escalation_boundary_marker.dart`
2. `escalation_queue.dart`

Boundary marker is authority-sensitive. Queue has evaluation/routing semantics. Both require deeper authority detox before any package introduction.

## Recommended Next Candidate

Start with a semantic freeze/simulation phase for the pure vocabulary batch, not direct execution. The safest first review batch is:

- `escalation_level.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`
- `escalation_state.dart`
- `escalation_reason.dart`
