# EX-50 Audit Snapshot Pure Model Shape

Phase: EX-50 - audit_snapshot Split Simulation

## Simulated Pure Model

Future pure model may remain named:

- `AuditSnapshot`

## Simulated Fields

Pure Dart fields:

- `String snapshotId`
- `String policyVersion`
- `String createdBy`
- `String hashPlaceholder`
- `AuditVisibilityScope visibilityScope`
- `bool immutable`
- `DateTime? createdAt`

## Pure Model Requirements

The pure model must:

- use Dart-only types
- use `DateTime?` only for time
- treat `immutable` as data only
- contain no Firestore imports
- contain no `FieldValue`
- contain no `Timestamp`
- contain no persistence logic
- contain no backend authority enforcement
- contain no runtime activation

## Optional Pure Helpers

Allowed future pure helpers, if needed:

- constructor validation-free value carrying
- copy/equality helpers only if project style approves
- simple key conversion only if not Firestore-specific

## Pure Model Finding

The future pure model can be package-safe if it contains data only and avoids all Firestore map ownership.

