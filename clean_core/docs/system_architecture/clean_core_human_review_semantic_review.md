# clean_core Human Review Semantic Review

This review assesses escalation, authority, runtime, and execution semantics in the human review lane.

## Safe Declarative Semantics

- `escalation_audit_link.dart`: audit id, trace hash, and policy version reference only.
- `escalation_policy_reference.dart`: policy version, snapshot id, and hash placeholder only.
- `review_priority.dart`: priority labels only.

## Escalation-Sensitive Labels

- `escalation_level.dart`: escalation level labels do not execute escalation.
- `escalation_reason.dart`: reason labels include safety, crisis, policy, provider failure, fallback loop, and support request.
- `escalation_state.dart`: lifecycle labels such as pending, assigned, in-review, resolved, rejected, archived.

## Backend-Authority-Sensitive Markers

- `review_visibility_scope.dart`: includes `backendOnly`, which is a visibility label, not authorization enforcement.
- `escalation_boundary_marker.dart`: declares backend-governed and client-write flags. Safe default blocks client outcome writes and avoids emergency guarantee.

## Hidden/Internal Evaluation Semantics

- `escalation_queue.dart`: pure Dart, but `accepts()` evaluates queue eligibility. It should remain hidden/internal until queue ownership and authority semantics are reviewed.

## Blocked Persistence Semantics

- `escalation_request.dart`
- `escalation_review.dart`
- `escalation_resolution.dart`
- `escalation_assignment.dart`

These are semantically useful but are coupled to Firestore serialization and timestamp behavior.

## Semantic Verdict

Human review contracts are mostly declarative, but escalation labels must not be mistaken for execution authority, and queue/persistence records require additional review.
