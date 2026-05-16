# clean_core Audit Batch A Simulated Rollback

This document simulates rollback for future Audit Batch A movement.

## Rollback Scope

Rollback would include:

- eight moved files
- eight root barrel export lines
- future `mental_smile_clean_core/lib/src/audit/` folder if empty after rollback

## Rollback Steps

1. Move the eight Batch A files back to `clean_core/lib/core/audit/`.
2. Remove the eight `src/audit/...` export lines from the package root barrel.
3. Remove `mental_smile_clean_core/lib/src/audit/` only if it is empty.
4. Confirm excluded audit files remained untouched.
5. Confirm no host imports were migrated.

## Rollback Checkpoints

- Checkpoint before folder creation.
- Checkpoint after file movement.
- Checkpoint after barrel export additions.
- Checkpoint before any future reconnect.

## Rollback Verdict

Rollback should remain low-risk because Batch A files are import-free and dependency-free.
