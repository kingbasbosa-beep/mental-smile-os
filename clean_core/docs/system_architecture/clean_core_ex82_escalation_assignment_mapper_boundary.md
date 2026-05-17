# EX-82 EscalationAssignment Mapper Boundary

## Mapper Split Requirement

Mapper split is required. Current `escalation_assignment.dart` imports Firestore, owns `toMap`, uses `FieldValue.serverTimestamp()`, and converts `DateTime?` into `Timestamp`.

## Host Mapper Responsibilities

A future host-side mapper must own:

- `cloud_firestore`
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- Firestore field names
- null handling
- `EscalationState.key` serialization
- compatibility with the existing host storage shape

## Package Restrictions

The package model must not own:

- Firestore imports
- serialization
- persistence
- mapper behavior
- server timestamp behavior

## Verdict

Future execution must use an additive mapper split with compatibility path preserved.
