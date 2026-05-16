# clean_core Audit Batch A Rollback Plan

This plan defines rollback expectations for a future Audit Batch A movement. No movement was executed in EX-27.

## Future Rollback Scope

If Batch A is moved later, rollback should cover only:

- eight moved audit files
- package barrel export additions for those files
- any package-local import corrections limited to those files

## Rollback Steps

1. Restore the eight Batch A files to `clean_core/lib/core/audit/`.
2. Remove the eight Batch A exports from `mental_smile_clean_core/lib/mental_smile_clean_core.dart`.
3. Confirm excluded audit files were never moved.
4. Confirm no host imports were migrated.
5. Confirm no runtime/provider/Firebase reconnect occurred.

## Rollback Safety

Rollback should remain simple because Batch A files have no imports and no runtime dependencies.

## Non-Rollback Areas

Rollback must not touch:

- Firestore-coupled audit files
- package identity/pubspec
- host root pubspec
- host app feature files
- runtime/provider systems

## Rollback Verdict

Future Batch A movement is rollback-safe if kept to the exact eight approved files and explicit barrel entries.
