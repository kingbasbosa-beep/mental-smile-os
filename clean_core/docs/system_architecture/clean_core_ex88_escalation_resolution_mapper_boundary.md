# EX-88 EscalationResolution Mapper Boundary

## Mapper Split Requirement

Mapper split is required. The current host file imports `cloud_firestore`, emits Firestore maps, converts `DateTime` to `Timestamp`, and can use `FieldValue.serverTimestamp()`.

## Future Host Mapper Responsibilities

A future host-side mapper must own:

- `cloud_firestore` imports
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- Firestore field names
- null handling
- `EscalationState.key` serialization
- nested `EscalationAuditLink` serialization/deserialization
- compatibility with the existing host storage shape

## Package Model Responsibilities

A future package model may own only passive fields:

- `escalationId`
- `resolvedBy`
- `state`
- `outcomeKey`
- `sanitizedResolutionNote`
- `auditLink`
- `resolvedAt`

## Prohibited Package Responsibilities

The package model must not contain:

- `cloud_firestore`
- `Timestamp`
- `FieldValue`
- `toMap`
- `fromMap`
- persistence logic
- storage field names
- mapper logic

## Mapper Verdict

Future execution must be additive: create a pure package model and a host-owned Firestore mapper while preserving the existing compatibility file.
