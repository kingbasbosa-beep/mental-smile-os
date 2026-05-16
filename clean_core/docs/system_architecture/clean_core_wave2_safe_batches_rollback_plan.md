# clean_core Wave 2 Safe Batches Rollback Plan

This document defines rollback boundaries for the two safe batches.

## Audit Batch Rollback

Rollback scope:

- eight audit files
- eight `src/audit/...` export lines
- `mental_smile_clean_core/lib/src/audit/` if empty

Restore files to:

`clean_core/lib/core/audit/`

## Human Review Batch Rollback

Rollback scope:

- seven human review files
- seven `src/human_review/...` export lines
- `mental_smile_clean_core/lib/src/human_review/` if empty

Restore files to:

`clean_core/lib/core/human_review/`

## Combined Rollback Rule

Rollback the most recent batch first. Do not roll back both batches unless required.

## Non-Rollback Areas

Do not touch:

- package identity
- host root pubspec
- Firestore-coupled files
- runtime/queue/boundary marker files
- host feature files
- runtime/provider systems

## Rollback Verdict

Separate movement phases preserve rollback clarity.
