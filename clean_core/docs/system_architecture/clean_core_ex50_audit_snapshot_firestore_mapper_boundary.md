# EX-50 Audit Snapshot Firestore Mapper Boundary

Phase: EX-50 - audit_snapshot Split Simulation

## Mapper Ownership

Future mapper must remain outside `mental_smile_clean_core`.

Recommended name:

- `AuditSnapshotFirestoreMapper`

## Mapper Responsibilities

Mapper owns:

- `package:cloud_firestore/cloud_firestore.dart`
- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- map serialization
- Firestore field names
- nullable timestamp handling
- persistence semantics

## Simulated Serialization Behavior

The mapper should preserve current behavior:

- map `snapshotId`
- map `policyVersion`
- map `createdBy`
- map `hashPlaceholder`
- map `visibilityScope.key`
- map `immutable`
- map `createdAt`

Timestamp behavior:

- if `useServerTimestamp == true`, use `FieldValue.serverTimestamp()`
- otherwise convert `DateTime?` to `Timestamp?`

## Mapper Boundary Finding

The mapper is integration code. It must not become a package contract and must not imply backend authority by itself.

