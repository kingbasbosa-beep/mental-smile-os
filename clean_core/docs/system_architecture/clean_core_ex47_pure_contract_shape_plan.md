# EX-47 Pure Contract Shape Plan

Phase: EX-47 - Mapper Split Strategy

## Pure Model Rules

Future pure models must:

- avoid `cloud_firestore`
- avoid `FieldValue`
- avoid `Timestamp`
- avoid Firebase-specific map logic
- remain immutable and declarative
- avoid runtime execution
- avoid backend authority ownership

## Recommended Shape

Pure contracts may keep:

- typed enum/value fields
- string identifiers
- sanitized text fields
- audit links
- policy references
- visibility scopes
- `DateTime?` fields as plain Dart values

Pure contracts should not decide:

- server timestamp generation
- Firestore document shape
- backend approval
- review resolution
- queue execution
- runtime activation

## Audit Pure Shape Candidates

Potential future pure contracts:

- audit event contract
- audit trace contract
- audit snapshot contract

Each should expose declarative fields only and leave Firestore serialization to host/backend mappers.

## Human Review Pure Shape Candidates

Potential future pure contracts:

- escalation assignment contract
- escalation request contract
- escalation resolution contract
- escalation review contract

Each requires authority/privacy review before extraction.

## Pure Shape Finding

The future package can own pure contract shapes, but it must not own Firestore write behavior or server timestamp behavior.

