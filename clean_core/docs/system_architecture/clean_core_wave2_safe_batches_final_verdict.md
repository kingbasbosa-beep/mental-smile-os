# clean_core Wave 2 Safe Batches Final Verdict

EX-31 combined strategy is complete.

## Findings

- Two approved safe batches exist.
- Sequential movement is preferred.
- Audit safe batch should move first.
- Human review safe batch should move second.
- No reconnect should occur during movement.
- Exports should be explicit file-by-file only.
- Rollback scopes should remain separate.

## Not Approved

- combined movement if rollback clarity weakens
- whole-directory movement
- Firestore-coupled files
- runtime/queue/boundary marker files
- adapter implementation
- runtime/provider activation
- Firebase/provider reconnect
- package barrel modification in EX-31

## Future Movement Verdict

Future movement is approved only as two staged executions:

1. Wave 2 Batch A1: audit safe batch.
2. Wave 2 Batch A2: human review safe batch.

EX-31 is planning only and executed no movement.
