# EX-46 Blocked Candidate Review

Phase: EX-46 - Next True Leaf Discovery

## Firestore-Coupled Candidates

Blocked due to direct Cloud Firestore imports:

- `audit_event.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`
- `escalation_assignment.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

These files require a pure contract plus host/backend mapper split before extraction.

## Runtime/Observability-Sensitive Candidates

Blocked due to runtime or observability semantics:

- `audit_runtime_marker.dart`
- `safety_observability_contract.dart`

These require runtime marker and observability isolation review before movement.

## Queue/Escalation-Sensitive Candidates

Blocked due to queue or escalation behavior semantics:

- `escalation_queue.dart`

This file is pure by import shape but not a safe leaf because it evaluates queue acceptance criteria.

## Backend-Authority-Sensitive Candidates

Blocked due to boundary/authority semantics:

- `escalation_boundary_marker.dart`

This requires backend authority review before any export or movement.

## Consumer-Bound Candidates

Blocked from standalone movement because consumers remain in place:

- audit labels/references
- human review labels/references

## Blocked Finding

Most remaining candidates are blocked not because they are impure themselves, but because moving them alone would break consumer topology.

