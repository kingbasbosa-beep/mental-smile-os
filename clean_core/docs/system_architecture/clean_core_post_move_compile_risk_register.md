# Post-Move Compile Risk Register

Phase: EX-40B - Post-Move Broken Consumer Strategy

## Known Compile Risk

Remaining excluded consumers import moved files through sibling imports that no longer resolve.

## Audit Risk Register

| File | Broken dependency type | Risk |
| --- | --- | --- |
| `audit_event.dart` | moved audit labels/references | Firestore-coupled consumer now missing declarative contracts |
| `audit_snapshot.dart` | moved audit visibility scope | Firestore-coupled consumer now missing visibility contract |
| `audit_trace.dart` | moved audit reference | Firestore-coupled consumer now missing reference contract |
| `safety_observability_contract.dart` | moved audit reference | observability-sensitive consumer now missing reference contract |

## Human Review Risk Register

| File | Broken dependency type | Risk |
| --- | --- | --- |
| `escalation_assignment.dart` | moved escalation state | Firestore-coupled assignment surface now missing state contract |
| `escalation_queue.dart` | moved reason/state/priority/visibility | queue semantics now missing declarative labels |
| `escalation_request.dart` | moved escalation/review labels and references | Firestore-coupled request surface now missing contracts |
| `escalation_resolution.dart` | moved audit link/state | Firestore-coupled resolution surface now missing contracts |
| `escalation_review.dart` | moved audit link/state | Firestore-coupled review surface now missing contracts |

## Risk Severity

Current compile risk: known and expected after movement.

Runtime risk: low, because no runtime was activated.

Architecture risk: medium, because the package split is currently ahead of reconnect/package-consumer readiness.

Validation risk: high until one resolution option is selected and executed.

## Risk Control

Do not apply ad hoc imports. Choose one governed resolution path before further movement or reconnect work.

