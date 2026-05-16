# EX-48 Audit Snapshot Firestore Mapper Plan

Phase: EX-48 - audit_snapshot Split Design

## Mapper Ownership

The Firestore mapper must remain outside `mental_smile_clean_core`.

Recommended ownership:

- host app integration layer, or
- backend bridge layer, or
- Firebase-specific mapper module outside the pure package

## Mapper Responsibilities

The mapper owns:

- `package:cloud_firestore/cloud_firestore.dart`
- Firestore field names
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate(...)`
- nullable timestamp handling
- serialization to Firestore map shape
- future deserialization from Firestore map shape if needed

## Current Mapper Behavior to Preserve

Current behavior:

- `useServerTimestamp == true` maps `createdAt` to `FieldValue.serverTimestamp()`
- `useServerTimestamp == false` maps `DateTime?` through `Timestamp.fromDate(...)`
- `createdAt == null` maps to `null` when not using server timestamp

## Future Mapper Naming

Possible future mapper names:

- `AuditSnapshotFirestoreMapper`
- `HostAuditSnapshotMapper`
- `BackendAuditSnapshotMapper`

Naming should make ownership clear and should not imply package-owned Firestore behavior.

## Mapper Finding

The Firestore mapper is integration code and must remain host/backend-owned.

