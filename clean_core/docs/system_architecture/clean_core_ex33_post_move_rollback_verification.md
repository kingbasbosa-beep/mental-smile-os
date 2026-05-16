# EX-33 Post-Move Rollback Verification

Phase: EX-34 - Post-Move Isolation Verification (Audit Batch A1)

## Rollback Scope

Rollback remains limited to:

- the eight moved audit files
- the eight audit export lines in `mental_smile_clean_core/lib/mental_smile_clean_core.dart`
- the empty `mental_smile_clean_core/lib/src/audit/` folder if no other files are later added

## Rollback File List

Rollback would return the following files from `mental_smile_clean_core/lib/src/audit/` to `clean_core/lib/core/audit/`:

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

## Barrel Rollback

Rollback would remove only the eight explicit audit export lines.

## Non-Rollback Areas

Rollback should not touch:

- human review files
- runtime marker files
- excluded audit runtime/event/trace/snapshot/observability files
- host imports
- pubspec files
- adapter/runtime/provider systems

## Rollback Finding

Rollback remains clear, isolated, and limited to the approved Batch A1 movement scope.

