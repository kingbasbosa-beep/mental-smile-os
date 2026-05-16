# EX-47 Split Stop Conditions

Phase: EX-47 - Mapper Split Strategy

## Mandatory Stop Conditions

Stop any future split if:

- `cloud_firestore` would enter `mental_smile_clean_core`
- `FieldValue` would enter `mental_smile_clean_core`
- `Timestamp` would enter `mental_smile_clean_core`
- Firestore serialization remains inside the pure model
- backend authority is implied by a client contract
- runtime/provider execution is introduced
- Firebase/provider reconnect is required
- broad migration is required
- package barrel changes exceed explicitly approved contracts
- privacy-sensitive fields are exposed without review
- boundary marker semantics are moved without authority review

## File-Specific Stop Conditions

Stop audit split if:

- `audit_runtime_marker.dart` must move without runtime marker review
- observability contract becomes part of the split without observability review

Stop human review split if:

- `escalation_boundary_marker.dart` must move without authority review
- queue routing semantics become part of pure package
- resolution/review authority is treated as client-owned

## Stop Finding

Mapper split is safe only if Firestore behavior remains outside the package and authority-sensitive semantics remain backend-governed.

