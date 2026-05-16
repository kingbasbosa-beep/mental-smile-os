# clean_core Human Review Safe Batch Rollback Plan

This plan defines rollback expectations for a future Human Review Safe Batch movement. No movement was executed in EX-30.

## Future Rollback Scope

If the safe batch is moved later, rollback should cover only:

- seven moved human review files
- package barrel export additions for those files
- any package-local import corrections limited to those files

## Rollback Steps

1. Restore the seven safe batch files to `clean_core/lib/core/human_review/`.
2. Remove the seven `src/human_review/...` exports from `mental_smile_clean_core/lib/mental_smile_clean_core.dart`.
3. Confirm excluded human review files were never moved.
4. Confirm no host imports were migrated.
5. Confirm no runtime/provider/Firebase reconnect occurred.

## Rollback Safety

Rollback should remain simple because the safe batch files have no imports and no runtime dependencies.

## Non-Rollback Areas

Rollback must not touch:

- Firestore-coupled human review files
- `escalation_queue.dart`
- `escalation_boundary_marker.dart`
- package identity/pubspec
- host root pubspec
- host app feature files
- runtime/provider systems

## Rollback Verdict

Future safe batch movement is rollback-safe if kept to the exact seven approved files and explicit barrel entries.
