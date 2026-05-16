# EX-41B Human Review Consumer Graph

Phase: EX-41B - Consumer Dependency Topology Audit

## Local Human Review Import Graph

Human review consumer files and their sibling dependencies:

| Consumer | Consumed human review contracts | Coupling |
| --- | --- | --- |
| `escalation_assignment.dart` | `escalation_state` | Firestore-coupled assignment |
| `escalation_queue.dart` | `escalation_reason`, `escalation_state`, `review_priority`, `review_visibility_scope` | queue/escalation-sensitive |
| `escalation_request.dart` | `escalation_audit_link`, `escalation_boundary_marker`, `escalation_level`, `escalation_policy_reference`, `escalation_reason`, `escalation_state`, `review_priority`, `review_visibility_scope` | Firestore-coupled request with boundary marker |
| `escalation_resolution.dart` | `escalation_audit_link`, `escalation_state` | Firestore-coupled resolution |
| `escalation_review.dart` | `escalation_audit_link`, `escalation_state` | Firestore-coupled review |

## Safe Contracts Consumed by Excluded Files

The attempted Wave 2 Human Review Batch A2 files are consumed by excluded human review files:

- `escalation_audit_link.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

## Boundary-Sensitive Contract

`escalation_boundary_marker.dart` remains a local excluded dependency of `escalation_request.dart`.

This keeps `escalation_request.dart` blocked from pure movement until authority semantics are reviewed.

## Queue-Sensitive Cluster

`escalation_queue.dart` is queue/escalation-sensitive because it evaluates accepted reasons, priorities, visibility, and states.

It is pure by import shape but not safe to move automatically because queue semantics can imply routing or execution.

## Human Review Graph Finding

The human review safe batch was consumer-bound. Moving the labels/references alone broke excluded assignment, queue, request, resolution, and review consumers.

