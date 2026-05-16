# clean_core Human Review Stop Conditions

Stop future human review extraction if any condition below appears.

## Import Stop Conditions

- Firebase import.
- Flutter import.
- provider SDK import.
- networking import.
- app-owned import.
- generated import.
- routing import.
- notification/messaging runtime import.

## Semantic Stop Conditions

- escalation labels treated as execution authority.
- queue acceptance treated as automatic routing.
- visibility scope treated as real authorization.
- review state treated as approval power.
- boundary marker treated as backend authority.
- client outcome writes allowed.
- emergency guarantee implies live intervention.

## Export Stop Conditions

- whole-directory export.
- Firestore-coupled file export.
- queue evaluator export without review.
- assignment/review/resolution export without adapter split.
- backend authority fields exported without documentation.

## Current Stop Conditions

Active stop condition exists for:

- `escalation_assignment.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`

Reason: `cloud_firestore` imports.
