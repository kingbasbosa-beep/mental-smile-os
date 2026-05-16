# EX-54 Audit Event Pure Contract Plan

Phase: EX-54 - audit_event Split Design

## Future Pure Model Goal

Future pure model may be:

- `AuditEvent`
- or `AuditEventContract`

The exact name should be approved before execution.

## Package-Safe Field Candidates

Potential pure fields:

- event type
- severity
- actor type
- actor id
- visibility scope
- sanitized preview
- policy version
- audit references
- runtime marker data or runtime marker reference
- `DateTime? createdAt`

## Package-Safe Constraints

The pure model must:

- be Dart-only
- avoid `cloud_firestore`
- avoid `FieldValue`
- avoid `Timestamp`
- avoid Firestore-specific `toMap`
- avoid persistence ownership
- avoid backend authority enforcement
- avoid runtime execution

## Runtime Marker Caveat

`runtimeMarker` is the main design caveat.

Options:

1. keep runtime marker out of the package pure model until runtime marker review
2. include a pure runtime marker value only after runtime marker approval
3. represent runtime marker as a simple string/reference value until stronger semantics are approved

## Pure Contract Finding

A pure audit event contract is possible, but it requires a runtime-marker decision before execution.

