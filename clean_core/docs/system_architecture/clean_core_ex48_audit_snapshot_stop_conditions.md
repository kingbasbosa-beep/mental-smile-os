# EX-48 Audit Snapshot Stop Conditions

Phase: EX-48 - audit_snapshot Split Design

## Mandatory Stop Conditions

Stop any future split or movement if:

- `cloud_firestore` would enter `mental_smile_clean_core`
- `FieldValue` would enter `mental_smile_clean_core`
- `Timestamp` would enter `mental_smile_clean_core`
- `toMap` remains Firestore-specific inside the pure package
- server timestamp behavior remains package-owned
- backend authority is implied by the pure model
- `immutable` is treated as client-enforced persistence authority
- `policyVersion` is treated as active policy authority
- privacy-sensitive fields are exposed without review
- movement requires broad reconnect
- package barrel changes include anything beyond approved explicit export

## Mapper Stop Conditions

Stop mapper work if:

- mapper is placed inside `mental_smile_clean_core`
- mapper creates trusted backend outcomes
- mapper bypasses backend governance
- mapper performs runtime/provider/Firebase activation beyond serialization ownership

## Stop Condition Finding

The split is safe only if the pure model and Firestore mapper remain cleanly separated.

