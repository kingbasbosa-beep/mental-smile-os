# clean_core Wave 2 Safe Batches Checkpoint Plan

This checkpoint plan defines required future review points.

## Required Checkpoints

1. Before any movement.
2. After audit batch movement.
3. After audit exports.
4. After human review batch movement.
5. After human review exports.
6. Before any reconnect.
7. Final post-move validation.

## Checkpoint Reviews

Each checkpoint must confirm:

- exact scope only
- no excluded files moved
- no import rewrites beyond moved files if needed
- no broad exports
- no Firebase/provider/runtime reconnect
- no host import migration
- rollback remains clear

## Final Validation Expectations

Final post-move validation should verify:

- package folder structure
- explicit barrel entries
- excluded files remain in source locations
- source locations contain only excluded lane files
- host app unchanged
- runtime/provider systems inactive

## Checkpoint Verdict

Movement should stop after every batch/export pair for manual review.
