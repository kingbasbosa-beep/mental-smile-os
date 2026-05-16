# EX-49 Audit Snapshot Firestore Ownership

Phase: EX-49 - audit_snapshot Split Pre-Execution Approval

## Firestore-Owned Responsibilities

The mapper must own:

- `Timestamp` conversion
- `FieldValue.serverTimestamp()`
- Firestore field names
- nullable timestamp handling
- persistence semantics
- future `fromMap` behavior if introduced

## Host/Backend Ownership

The Firestore mapper must remain:

- outside `mental_smile_clean_core`
- host/backend-owned
- integration-specific
- rollback-isolated

## Current Firestore Coupling

Current Firestore coupling exists in:

- import of `package:cloud_firestore/cloud_firestore.dart`
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate(...)`
- `_timestampOrNull(...)`
- Firestore-oriented `toMap(...)`

## Firestore Ownership Verdict

Approved with caveats. The split is ready only if all Firestore behavior remains outside the pure package.

