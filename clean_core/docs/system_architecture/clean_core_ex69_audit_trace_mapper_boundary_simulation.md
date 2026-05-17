# EX-69 AuditTrace Mapper Boundary Simulation

## Host-Side Mapper Responsibilities

A future host-side mapper should own:

- `cloud_firestore`
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- Firestore field names
- null handling
- nested `AuditReference` serialization/deserialization
- `AuditRuntimeMarker` serialization/deserialization
- translation from `AuditRuntimeMarker` to `AuditProcessingContext`

## Current Host-Owned Logic

Current `audit_trace.dart` owns:

- `toMap`
- `runtimeMarker.toMap()`
- `references.map((reference) => reference.toMap()).toList()`
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate`

These responsibilities should remain outside `mental_smile_clean_core`.

## Mapper Boundary Verdict

The future mapper should mirror the `audit_event` mapper pattern and import local compatibility files where needed.
