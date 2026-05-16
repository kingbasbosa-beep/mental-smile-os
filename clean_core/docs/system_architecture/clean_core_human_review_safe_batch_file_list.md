# clean_core Human Review Safe Batch File List

This document defines the exact approved future movement scope for the Human Review Safe Batch.

## Included Files

| File | Future Classification |
| --- | --- |
| `clean_core/lib/core/human_review/escalation_audit_link.dart` | Safe declarative reference candidate |
| `clean_core/lib/core/human_review/escalation_level.dart` | Safe escalation label candidate |
| `clean_core/lib/core/human_review/escalation_policy_reference.dart` | Safe policy reference candidate |
| `clean_core/lib/core/human_review/escalation_reason.dart` | Safe escalation label candidate with provider-label caveat |
| `clean_core/lib/core/human_review/escalation_state.dart` | Safe lifecycle label candidate |
| `clean_core/lib/core/human_review/review_priority.dart` | Safe priority label candidate |
| `clean_core/lib/core/human_review/review_visibility_scope.dart` | Safe visibility label candidate with backend-label caveat |

## Excluded Files

Explicitly excluded:

- `escalation_boundary_marker.dart`
- `escalation_queue.dart`
- `escalation_assignment.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

## File List Verdict

Only the seven included safe batch files may be considered in a future movement phase. Whole-directory human review movement remains disallowed.
