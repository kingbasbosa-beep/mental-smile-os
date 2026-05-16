# clean_core Audit Batch A Simulated Export Diff

This file simulates future root barrel additions. No barrel was modified in EX-28.

## Simulated Additions

Future additions to `mental_smile_clean_core/lib/mental_smile_clean_core.dart` would be:

```dart
export 'src/audit/audit_actor_type.dart';
export 'src/audit/audit_event_type.dart';
export 'src/audit/audit_hash_placeholder.dart';
export 'src/audit/audit_redaction.dart';
export 'src/audit/audit_reference.dart';
export 'src/audit/audit_retention_policy.dart';
export 'src/audit/audit_severity.dart';
export 'src/audit/audit_visibility_scope.dart';
```

## Simulated Non-Additions

Do not add:

```dart
export 'src/audit/audit_runtime_marker.dart';
export 'src/audit/safety_observability_contract.dart';
export 'src/audit/audit_event.dart';
export 'src/audit/audit_trace.dart';
export 'src/audit/audit_snapshot.dart';
```

## Export Rules

- File-by-file exports only.
- No `export 'src/audit/...';` wildcard or directory-style export.
- No Firestore-coupled exports.
- No runtime marker export in Batch A.
- No adapter-boundary export in Batch A.

## Export Diff Verdict

Future export diff is simple and rollback-safe if kept to the eight explicit lines.
