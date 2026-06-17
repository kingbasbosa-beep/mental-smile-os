# RELEASE_ROLLBACK_PLAN_V1

## Purpose

Define rollback behavior for release candidate preparation.

## Rollback Order

1. Stop release process.
2. Preserve validation logs and release candidate notes.
3. If push was not performed, unstage incorrect files using non-destructive git commands.
4. If commit was created but not pushed, create a corrective commit or request Owner approval before history rewrite.
5. If push was performed, use revert commit unless Owner explicitly approves another strategy.
6. If tag was created locally but not pushed, delete local tag only after Owner confirms.
7. If tag was pushed, create a corrective release note and do not delete remote tag without Owner approval.
8. If Firebase deploy occurred, use `FIREBASE_ROLLBACK_PLAN_V1`.
9. If runtime patch caused failure, use `RUNTIME_ROLLBACK_PLAN_V1`.
10. If identity patch caused failure, use `IDENTITY_ROLLBACK_PLAN_V1`.

## Forbidden Rollback Actions

- No destructive reset without Owner confirmation.
- No deletion of historical evidence.
- No Firebase project deletion.
- No GitHub repository deletion.
- No archive movement during rollback.

