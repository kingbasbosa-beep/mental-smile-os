# clean_core Extraction Wave 1 Checkpoints

## Checkpoint Rule

No Wave 1 batch should begin until the previous batch has completed review. Checkpoints exist to keep the first extraction wave small, reversible, and contamination-aware.

## Required Checkpoint After Each Batch

Each batch requires:

- working tree review
- moved file list review
- import review
- package path review
- curated export review
- public/internal visibility review
- rollback checkpoint confirmation
- runtime-disabled confirmation
- provider-blocked confirmation
- host-app ownership confirmation

## Import Boundary Check

Confirm the batch contains no:

- `package:flutter/` imports
- `cloud_firestore` imports
- `firebase_*` imports
- `firebase_options` imports
- generated localization imports
- generated router imports
- generated asset imports
- app package identity imports
- parent-path imports escaping the future package boundary
- provider SDK imports
- networking imports
- Cloud Functions imports

## Runtime Safety Check

Confirm the batch does not introduce:

- runtime execution
- provider execution
- AI execution
- orchestration execution
- dependency injection runtime
- backend runtime
- networking
- Firebase setup
- privileged client writes
- release/deployment activation

## Export Check

Confirm exports remain:

- curated
- narrow
- contract-first
- pure Dart
- stable or explicitly review-marked
- free of app-owned files
- free of internal runtime coordination unless deliberately marked internal

## Rollback Check

Confirm before proceeding:

- the previous state can be restored from the backup/tag/checkpoint
- moved files are listed
- import changes are isolated
- no broad rewrite occurred
- host app still owns app shell/runtime systems
- fail-closed defaults remain intact

## Next-Batch Approval

The next batch should proceed only after manual review confirms:

- no contamination entered the extracted surface
- no blocked files were included
- no deferred domains leaked into Wave 1
- no generated/runtime dependencies were introduced
- no runtime/provider activation path was created
