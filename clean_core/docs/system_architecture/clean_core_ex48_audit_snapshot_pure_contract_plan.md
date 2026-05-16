# EX-48 Audit Snapshot Pure Contract Plan

Phase: EX-48 - audit_snapshot Split Design

## Future Pure Contract Goal

Create a future pure Dart audit snapshot contract/model that can live in `mental_smile_clean_core` without Firestore coupling.

## Package-Safe Fields

Future pure model may contain:

- `String snapshotId`
- `String policyVersion`
- `String createdBy`
- `String hashPlaceholder`
- `AuditVisibilityScope visibilityScope`
- `bool immutable`
- `DateTime? createdAt`

## Pure Contract Rules

The pure model must:

- use only Dart types and approved package contracts
- use `DateTime?` only, not `Timestamp`
- avoid `cloud_firestore`
- avoid `FieldValue`
- avoid Firestore map ownership
- be immutable/declarative
- not imply backend authority
- not perform persistence

## Excluded from Pure Contract

The pure contract must not own:

- Firestore field naming as integration authority
- server timestamp behavior
- Firestore timestamp conversion
- document write behavior
- backend approval semantics

## Pure Contract Finding

`AuditSnapshot` is a viable future pure contract after its Firestore mapper logic is removed or relocated.

