# EX-50 Audit Snapshot Future Rollback

Phase: EX-50 - audit_snapshot Split Simulation

## Rollback Scope

Future rollback must remain:

- local
- reconnect-free
- export-limited
- runtime-free

## Simulated Rollback Items

Rollback would include:

- removing or moving back `mental_smile_clean_core/lib/src/audit/audit_snapshot.dart`
- removing `export 'src/audit/audit_snapshot.dart';`
- removing or reverting the host/backend mapper file if introduced
- restoring previous source shape if split changed the original file

## Rollback Exclusions

Rollback must not touch:

- package pubspec
- root pubspec
- runtime systems
- provider systems
- Firebase initialization
- observability files
- queue/boundary files
- unrelated audit files

## Rollback Finding

Rollback remains manageable only if future split execution is scoped to one pure model and one mapper.

