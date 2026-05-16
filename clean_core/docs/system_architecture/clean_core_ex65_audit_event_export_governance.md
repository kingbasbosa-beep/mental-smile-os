# EX-65 AuditEvent Export Governance

## Future Export Rule

If the package-safe `AuditEvent` is introduced, the root barrel may add only:

```dart
export 'src/audit/audit_event.dart';
```

## Export Restrictions

- No wildcard exports.
- No directory exports.
- No Firestore mapper exports.
- No host compatibility exports.
- No runtime marker exports.
- No observability exports.
- No provider, Firebase, adapter, or runtime exports.

## Naming Caveat

Future package documentation must frame `AuditEvent` as a passive audit record model, not runtime execution, provider action, access enforcement, or backend authority.

## Verdict

Future export is safe only as an explicit file-by-file export with semantic caveats.
