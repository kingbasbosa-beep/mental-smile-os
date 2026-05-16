# clean_core Human Review Safe Batch Stop Conditions

Stop any future safe batch movement if any condition below appears.

## Import Stop Conditions

- Firebase import appears.
- Flutter import appears.
- provider SDK import appears.
- networking import appears.
- app-owned `flutterprojects` import appears.
- generated localization/config import appears.
- notification/messaging runtime import appears.

## Scope Stop Conditions

- Any excluded human review file is included.
- Whole `core/human_review/` directory movement is proposed.
- `escalation_boundary_marker.dart` is included.
- `escalation_queue.dart` is included.
- Any Firestore-coupled assignment/request/resolution/review file is included.

## Semantic Stop Conditions

- `providerFailure` is treated as provider execution.
- `backendOnly` is treated as authorization enforcement.
- `assigned` is treated as assignment execution.
- `resolved` or `rejected` is treated as final approval authority.
- escalation labels are treated as routing or notification execution.
- priority labels are treated as emergency intervention guarantee.

## Export Stop Conditions

- wildcard export
- directory-wide export
- Firestore-coupled export
- queue evaluator export
- boundary marker export

## Stop Verdict

The safe batch remains approved only while it stays pure, declarative, narrow, and file-scoped.
