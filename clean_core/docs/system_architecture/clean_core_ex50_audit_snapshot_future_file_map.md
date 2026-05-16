# EX-50 Audit Snapshot Future File Map

Phase: EX-50 - audit_snapshot Split Simulation

## Scope

This document simulates future split files only.

No source files were modified, no files were moved, no imports were changed, no exports were changed, no dependencies were added, and no runtime systems were activated.

## Current Source

Current file:

- `clean_core/lib/core/audit/audit_snapshot.dart`

## Simulated Pure Package File

Future pure package file:

- `mental_smile_clean_core/lib/src/audit/audit_snapshot.dart`

Ownership:

- `mental_smile_clean_core`
- declarative contract only
- no Firestore ownership

## Simulated Host/Backend Mapper File

Recommended future mapper location:

- `clean_core/lib/core/audit/firestore/audit_snapshot_firestore_mapper.dart`

Alternative acceptable host/backend locations:

- `clean_core/lib/core/firebase_mappers/audit_snapshot_firestore_mapper.dart`
- `clean_core/lib/core/backend_mappers/audit_snapshot_firestore_mapper.dart`

Ownership:

- host/backend integration layer
- Firebase/Firestore-specific
- not part of `mental_smile_clean_core`

## File Map Finding

Future split should create a pure package contract and keep Firestore serialization in a host/backend-owned mapper.

