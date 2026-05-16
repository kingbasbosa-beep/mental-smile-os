# EX-51 Audit Snapshot Execution Strategy

Phase: EX-51 - audit_snapshot Controlled Split Execution Review

## Scope

This document prepares a future execution strategy only.

No source files were modified, no files were moved, no imports were changed, no exports were changed, no dependencies were added, and no runtime systems were activated.

## Future Split Targets

Future pure package model:

- `mental_smile_clean_core/lib/src/audit/audit_snapshot.dart`

Future host/backend Firestore mapper:

- `clean_core/lib/core/audit/firestore/audit_snapshot_firestore_mapper.dart`

Existing compatibility source:

- `clean_core/lib/core/audit/audit_snapshot.dart`

## Strategy Summary

The safest future execution strategy is not to delete the existing source file immediately.

Instead:

1. introduce a pure package model
2. introduce a host/backend Firestore mapper
3. keep `clean_core/lib/core/audit/audit_snapshot.dart` as a temporary compatibility surface
4. preserve existing consumers while future migration is planned

## Pure Model Responsibility

The pure model owns only:

- field definitions
- constructor
- Dart-only `DateTime?`
- declarative data semantics

It does not own:

- Firestore import
- `FieldValue`
- `Timestamp`
- Firestore `toMap`
- persistence
- backend authority

## Mapper Responsibility

The mapper owns:

- Firestore import
- `FieldValue.serverTimestamp()`
- `Timestamp.fromDate(...)`
- Firestore map fields
- nullable timestamp conversion
- future `fromMap` if needed

## Execution Strategy Finding

The future split should be additive-first and compatibility-preserving, not movement-first.

