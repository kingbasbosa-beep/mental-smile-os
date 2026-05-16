# EX-46 Safe Movement Candidates

Phase: EX-46 - Next True Leaf Discovery

## Safe Movement Candidate List

No new movement candidate is recommended from the reviewed areas.

## Already Extracted True Leaves

The previous safe leaf extraction already moved:

- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_retention_policy.dart`

## Why No New Safe Movement

Remaining audit and human review candidates are:

- consumed by local excluded files
- Firestore-coupled
- runtime-sensitive
- observability-sensitive
- queue-sensitive
- backend-authority-sensitive

## Safe Movement Finding

The safe next action is not movement. The safe next action is to plan dependency cluster splitting or package-aware consumer resolution.

