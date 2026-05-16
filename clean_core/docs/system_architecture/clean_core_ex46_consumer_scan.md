# EX-46 Consumer Scan

Phase: EX-46 - Next True Leaf Discovery

## Audit Consumer Findings

Consumer-bound audit contracts:

| Candidate | Known consumers | Classification |
| --- | --- | --- |
| `audit_actor_type.dart` | `audit_event.dart` | consumer-bound |
| `audit_event_type.dart` | `audit_event.dart` | consumer-bound |
| `audit_reference.dart` | `audit_event.dart`, `audit_trace.dart`, `safety_observability_contract.dart` | consumer-bound |
| `audit_severity.dart` | `audit_event.dart` | consumer-bound |
| `audit_visibility_scope.dart` | `audit_event.dart`, `audit_snapshot.dart` | consumer-bound |

Blocked audit consumers:

- `audit_event.dart` imports Cloud Firestore and multiple local audit contracts.
- `audit_snapshot.dart` imports Cloud Firestore and audit visibility.
- `audit_trace.dart` imports Cloud Firestore, audit reference, and audit runtime marker.
- `safety_observability_contract.dart` imports audit reference and audit runtime marker.

## Human Review Consumer Findings

Consumer-bound human review contracts:

| Candidate | Known consumers | Classification |
| --- | --- | --- |
| `escalation_audit_link.dart` | `escalation_request.dart`, `escalation_resolution.dart`, `escalation_review.dart` | consumer-bound |
| `escalation_level.dart` | `escalation_request.dart` | consumer-bound |
| `escalation_policy_reference.dart` | `escalation_request.dart` | consumer-bound |
| `escalation_reason.dart` | `escalation_queue.dart`, `escalation_request.dart` | consumer-bound |
| `escalation_state.dart` | `escalation_assignment.dart`, `escalation_queue.dart`, `escalation_request.dart`, `escalation_resolution.dart`, `escalation_review.dart` | consumer-bound |
| `review_priority.dart` | `escalation_queue.dart`, `escalation_request.dart` | consumer-bound |
| `review_visibility_scope.dart` | `escalation_queue.dart`, `escalation_request.dart` | consumer-bound |

Blocked human review consumers:

- `escalation_assignment.dart` imports Cloud Firestore.
- `escalation_queue.dart` encodes queue acceptance behavior.
- `escalation_request.dart` imports Cloud Firestore and boundary marker.
- `escalation_resolution.dart` imports Cloud Firestore.
- `escalation_review.dart` imports Cloud Firestore.

## Consumer Scan Finding

No new reconnect-free true leaf candidate was found among remaining audit or human review labels/references. They remain consumer-bound.

