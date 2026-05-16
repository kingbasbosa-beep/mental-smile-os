# EX-43 True Leaf Simulated Rollback

Phase: EX-43 - True Leaf Simulated Move Plan

## Rollback Scope

Future rollback would be limited to:

- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_retention_policy.dart`
- the three matching explicit export lines
- `mental_smile_clean_core/lib/src/audit/` only if empty after rollback

## Rollback Steps

Simulated rollback sequence:

1. move the three files back to `clean_core/lib/core/audit/`
2. remove the three explicit export lines from `mental_smile_clean_core/lib/mental_smile_clean_core.dart`
3. remove the package audit folder only if empty and filesystem allows
4. verify no reconnect files were touched

## Rollback Exclusions

Rollback must not touch:

- Wave 1 extracted files
- package pubspec
- root pubspec
- audit event/trace/snapshot/runtime/observability files
- human review files
- runtime/provider/Firebase systems
- docs

## Rollback Finding

Rollback is simple because no consumers or reconnects are expected.

