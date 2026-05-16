# EX-51 Audit Snapshot Source Edit Boundaries

Phase: EX-51 - audit_snapshot Controlled Split Execution Review

## Future Source Edit Boundary

Future execution may touch only:

- `mental_smile_clean_core/lib/src/audit/audit_snapshot.dart`
- `clean_core/lib/core/audit/firestore/audit_snapshot_firestore_mapper.dart`
- `clean_core/lib/core/audit/audit_snapshot.dart`
- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

Only if explicitly approved.

## Allowed Future Imports

Pure package model:

- may import package-safe audit visibility contract only if already available in package or moved through approved strategy
- must not import Firestore

Firestore mapper:

- may import `package:cloud_firestore/cloud_firestore.dart`
- may import the pure model
- may import visibility scope support as approved

Compatibility source:

- may preserve existing imports temporarily
- must not broaden dependencies
- must not activate runtime

## Allowed Future Exports

Only explicit package export:

```dart
export 'src/audit/audit_snapshot.dart';
```

No wildcard exports.

No mapper export.

No directory export.

## Blocked Source Edits

Do not touch:

- audit event
- audit trace
- audit runtime marker
- safety observability contract
- human review files
- package pubspec
- root pubspec
- runtime/provider/Firebase initialization

## Source Boundary Finding

Future execution must be one-file-cluster scoped and must not expand into wider audit migration.

