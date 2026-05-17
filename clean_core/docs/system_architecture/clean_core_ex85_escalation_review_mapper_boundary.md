# EX-85 EscalationReview Mapper Boundary

## Mapper Split Requirement

Mapper split is required. Current `escalation_review.dart` imports Firestore, owns `toMap`, uses `FieldValue.serverTimestamp()`, serializes nested audit links, and converts `DateTime?` into `Timestamp`.

## Host Mapper Responsibilities

A future host-side mapper must own:

- `cloud_firestore`
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- Firestore field names
- null handling
- `EscalationState.key` serialization
- nested `EscalationAuditLink` serialization/deserialization
- compatibility with the existing host storage shape

## Package Restrictions

The package model must not own:

- Firestore imports
- serialization
- persistence
- mapper behavior
- server timestamp behavior
- audit-link serialization

## Verdict

Future execution must use an additive mapper split with compatibility path preserved.
