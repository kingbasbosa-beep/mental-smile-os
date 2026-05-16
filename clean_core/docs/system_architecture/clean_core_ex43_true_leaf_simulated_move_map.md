# EX-43 True Leaf Simulated Move Map

Phase: EX-43 - True Leaf Simulated Move Plan

## Scope

This document simulates movement only. No files were moved, imports were changed, exports were changed, dependencies were added, or runtime systems were activated.

## Simulated Candidates

Only these true leaf candidates are in scope:

- `clean_core/lib/core/audit/audit_hash_placeholder.dart`
- `clean_core/lib/core/audit/audit_redaction.dart`
- `clean_core/lib/core/audit/audit_retention_policy.dart`

## Simulated Destination

Future destination:

- `mental_smile_clean_core/lib/src/audit/`

## Simulated Move Map

| Current path | Simulated future path | Visibility |
| --- | --- | --- |
| `clean_core/lib/core/audit/audit_hash_placeholder.dart` | `mental_smile_clean_core/lib/src/audit/audit_hash_placeholder.dart` | public explicit export candidate |
| `clean_core/lib/core/audit/audit_redaction.dart` | `mental_smile_clean_core/lib/src/audit/audit_redaction.dart` | public explicit export candidate after safety wording review |
| `clean_core/lib/core/audit/audit_retention_policy.dart` | `mental_smile_clean_core/lib/src/audit/audit_retention_policy.dart` | public explicit export candidate after compliance wording review |

## Movement Boundary

No whole audit folder movement is simulated.

The following remain out of scope:

- audit labels consumed by other files
- audit references consumed by other files
- audit event/trace/snapshot files
- audit runtime marker
- safety observability contract

## Simulated Move Finding

The simulated move is limited to three true leaf files and should not break known consumers because no consumers were identified in EX-42.

