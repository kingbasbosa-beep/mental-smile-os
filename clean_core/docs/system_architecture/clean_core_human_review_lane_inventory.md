# clean_core Human Review Lane Inventory

EX-29A reviews only `clean_core/lib/core/human_review/`. No files were moved, imports reconnected, exports modified, dependencies added, adapters created, or runtime systems activated.

## File Inventory

| File | Classification | Notes |
| --- | --- | --- |
| `escalation_audit_link.dart` | Safe declarative candidate | Audit reference fields only. |
| `escalation_level.dart` | Escalation-sensitive declarative candidate | Severity/level labels only. |
| `escalation_policy_reference.dart` | Safe declarative candidate | Policy snapshot/hash reference only. |
| `escalation_reason.dart` | Escalation-sensitive declarative candidate | Includes `providerFailure`, but no provider execution. |
| `escalation_state.dart` | Escalation-sensitive declarative candidate | Review lifecycle labels only. |
| `review_priority.dart` | Safe declarative candidate | Priority labels only. |
| `review_visibility_scope.dart` | Backend-authority-sensitive declarative candidate | Includes `backendOnly`; no enforcement. |
| `escalation_boundary_marker.dart` | Backend-authority-sensitive candidate | Boundary marker with backend-governed and client-write fields. |
| `escalation_queue.dart` | Hidden/internal candidate | Pure Dart, but contains queue acceptance evaluation. |
| `escalation_request.dart` | Host-coupled/block candidate | Imports `cloud_firestore`; request persistence model. |
| `escalation_review.dart` | Host-coupled/block candidate | Imports `cloud_firestore`; review persistence model. |
| `escalation_resolution.dart` | Host-coupled/block candidate | Imports `cloud_firestore`; resolution persistence model. |
| `escalation_assignment.dart` | Host-coupled/block candidate | Imports `cloud_firestore`; assignment persistence model. |

## Inventory Verdict

The human review lane is partially extraction-ready. Label/reference contracts are candidate-safe after review, queue/evaluation semantics should remain hidden, and Firestore-coupled request/review/resolution/assignment files are blocked from immediate extraction.
