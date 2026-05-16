# clean_core Human Review Hidden Contracts

This document identifies hidden or internal-only human review surfaces.

## Hidden/Internal Candidates

| File | Reason |
| --- | --- |
| `escalation_queue.dart` | Contains queue acceptance evaluation. |
| `escalation_boundary_marker.dart` | Backend/client-write boundary flags require authority documentation before export. |
| `escalation_assignment.dart` | Firestore-coupled assignment persistence. |
| `escalation_request.dart` | Firestore-coupled request persistence. |
| `escalation_resolution.dart` | Firestore-coupled resolution persistence. |
| `escalation_review.dart` | Firestore-coupled review persistence. |

## Hidden Contract Rules

- Queue evaluation does not own routing authority.
- Boundary markers do not grant backend authority.
- Assignment/review/resolution records do not execute escalation.
- Firestore mapping belongs to host/backend adapters.

## Hidden Verdict

Hidden/internal treatment is required for evaluation and persistence files until authority and adapter boundaries are explicit.
