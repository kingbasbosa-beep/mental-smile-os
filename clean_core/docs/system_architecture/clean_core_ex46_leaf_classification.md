# EX-46 Leaf Classification

Phase: EX-46 - Next True Leaf Discovery

## Classification Summary

| Area | Candidate | Classification |
| --- | --- | --- |
| audit | `audit_actor_type.dart` | consumer-bound |
| audit | `audit_event_type.dart` | consumer-bound |
| audit | `audit_reference.dart` | consumer-bound |
| audit | `audit_severity.dart` | consumer-bound |
| audit | `audit_visibility_scope.dart` | consumer-bound |
| audit | `audit_runtime_marker.dart` | runtime-sensitive |
| audit | `audit_event.dart` | Firestore-coupled cluster |
| audit | `audit_snapshot.dart` | Firestore-coupled cluster |
| audit | `audit_trace.dart` | Firestore-coupled and runtime-marker-bound |
| audit | `safety_observability_contract.dart` | runtime/observability-sensitive |
| human review | `escalation_audit_link.dart` | consumer-bound |
| human review | `escalation_level.dart` | consumer-bound |
| human review | `escalation_policy_reference.dart` | consumer-bound |
| human review | `escalation_reason.dart` | consumer-bound |
| human review | `escalation_state.dart` | consumer-bound |
| human review | `review_priority.dart` | consumer-bound |
| human review | `review_visibility_scope.dart` | consumer-bound |
| human review | `escalation_boundary_marker.dart` | backend-authority-sensitive |
| human review | `escalation_queue.dart` | queue/escalation-sensitive |
| human review | `escalation_assignment.dart` | Firestore-coupled cluster |
| human review | `escalation_request.dart` | Firestore-coupled and boundary-sensitive |
| human review | `escalation_resolution.dart` | Firestore-coupled cluster |
| human review | `escalation_review.dart` | Firestore-coupled cluster |

## True Leaf Classification

No new true leaf candidate was identified in the remaining reviewed source files.

## Leaf Finding

The next safe movement should not select remaining labels/references unless their consumers move with them or a package-aware consumer strategy is approved.

