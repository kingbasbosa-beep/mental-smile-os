# EX-42 True Leaf Export Safety

Phase: EX-42 - True Leaf Extraction Review

## Export Safety Criteria

Future export safety requires:

- no imports
- no runtime semantics
- no Firebase/Flutter/provider/networking/generated dependencies
- no known consumers that would break
- no hidden authority semantics
- explicit file-by-file export only

## Candidate Export Safety

| Candidate | Export safety | Notes |
| --- | --- | --- |
| `audit_hash_placeholder.dart` | export-safe candidate | Pure deterministic placeholder utility |
| `audit_redaction.dart` | export-safe candidate after safety wording review | Pure redaction helper, safety-sensitive semantics |
| `audit_retention_policy.dart` | export-safe candidate after compliance wording review | Pure retention policy value object |

## Barrel Requirements if Moved Later

If future movement is authorized, package barrel additions must be explicit:

- `src/audit/audit_hash_placeholder.dart`
- `src/audit/audit_redaction.dart`
- `src/audit/audit_retention_policy.dart`

No wildcard exports.

No directory exports.

No audit event/trace/snapshot/runtime/observability exports.

## Export Safety Finding

The three candidates are suitable for future export consideration as true leaves, provided movement remains file-by-file and explicit.

