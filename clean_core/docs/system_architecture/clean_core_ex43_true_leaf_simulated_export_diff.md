# EX-43 True Leaf Simulated Export Diff

Phase: EX-43 - True Leaf Simulated Move Plan

## Simulated Barrel Additions

If a future movement phase is authorized, add only these explicit exports:

```dart
export 'src/audit/audit_hash_placeholder.dart';
export 'src/audit/audit_redaction.dart';
export 'src/audit/audit_retention_policy.dart';
```

## Export Rules

Future export must preserve:

- explicit file-by-file exports only
- no wildcard exports
- no directory exports
- no audit event export
- no audit trace export
- no audit snapshot export
- no audit runtime marker export
- no safety observability export
- no Firestore-coupled export

## Export Safety

The simulated export surface is safe because:

- candidates have no imports
- candidates have no known consumers
- candidates are declarative utilities/value contracts
- no reconnect is expected

## Export Diff Finding

Future export diff should contain exactly three new export lines and no other barrel changes.

