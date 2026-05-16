# EX-42 True Leaf Rollback Plan

Phase: EX-42 - True Leaf Extraction Review

## Rollback Scope if Future Movement Occurs

Rollback for these true leaf candidates would be limited to:

- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_retention_policy.dart`
- matching explicit package export lines, if added
- empty `mental_smile_clean_core/lib/src/audit/` folder only if applicable

## Rollback Simplicity

Rollback is simple because:

- no consumers were found
- no imports would need reconnect
- no package dependencies would change
- no runtime/provider/Firebase systems would be affected
- no excluded audit consumers would be touched

## Rollback Guardrails

Rollback must not touch:

- `audit_event.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`
- `safety_observability_contract.dart`
- `audit_runtime_marker.dart`
- package pubspec files
- root pubspec files
- Wave 1 extracted files

## Rollback Finding

These candidates have clean rollback boundaries if moved later under separate authorization.

