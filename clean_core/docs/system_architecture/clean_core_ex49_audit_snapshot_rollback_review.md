# EX-49 Audit Snapshot Rollback Review

Phase: EX-49 - audit_snapshot Split Pre-Execution Approval

## Future Rollback Scope

Rollback for a future split should remain:

- local
- reconnect-free
- export-limited
- runtime-free

## Expected Rollback Items

Expected rollback scope:

- pure `audit_snapshot.dart` model movement or split changes
- mapper file creation or movement, if introduced
- explicit export line, if added

## Rollback Must Not Touch

Rollback must not touch:

- runtime/provider/Firebase activation
- observability systems
- queue/boundary files
- unrelated audit files
- package pubspec
- root pubspec
- Wave 1 extracted files

## Rollback Verdict

Rollback can remain controlled only if split execution is limited to one cluster and does not introduce reconnect or runtime behavior.

