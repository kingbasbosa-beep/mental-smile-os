# EX-70 AuditTrace Mapper Boundary Freeze

## Host-Side Mapper Ownership

A future mapper must own:

- `cloud_firestore`
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- Firestore field names
- null handling
- nested `AuditReference` serialization/deserialization
- `AuditRuntimeMarker` serialization/deserialization
- translation between `AuditRuntimeMarker` and `AuditProcessingContext`

## Package Prohibitions

The package model must not own:

- `toMap`
- `fromMap`
- Firestore imports
- persistence logic
- document field naming
- server timestamp behavior
- runtime marker interpretation

## Mapper Location

Approved future mapper location:

- `clean_core/lib/core/audit/firestore/audit_trace_firestore_mapper.dart`

## Mapper Freeze Verdict

All persistence and runtime-marker mapping responsibilities remain host-side.
