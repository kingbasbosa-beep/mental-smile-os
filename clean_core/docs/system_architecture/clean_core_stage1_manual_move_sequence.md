# clean_core Stage 1 Manual Move Sequence

## Rule

The future move sequence must be manual, staged, and checkpointed. This document does not perform the move.

## Step 0: Prepare Destination Later

Future preparation should:

- create the package folder only after approval
- create only the approved pure-Dart skeleton
- create no runtime package setup
- create no Firebase setup
- create no provider setup
- create no networking setup

## Step 1: Move Batch 1 Later

Paths:

- `lib/core/backend_boundaries/`
- `lib/core/safety_decision/`

Sequence:

- prepare destination folders
- move files
- inspect imports
- review exports
- pause for checkpoint
- confirm rollback available

## Step 2: Move Batch 2 Later

Path:

- `lib/core/policy_runtime/`

Sequence:

- prepare destination folder
- move files
- inspect imports
- review policy semantics
- confirm no runtime execution semantics
- pause for checkpoint
- confirm rollback available

## Step 3: Move Batch 3 Later

Paths:

- `lib/core/trusted_backend/`
- `lib/core/trusted_pipeline/`

Sequence:

- prepare destination folders
- move files
- inspect imports
- review trusted-boundary semantics
- confirm no networking/backend runtime
- confirm no orchestration/runtime execution
- pause for checkpoint
- confirm rollback available

## Step 4: Move Batch 4 Later

Paths:

- `lib/core/governance_kernel/`
- `lib/core/governance_lifecycle/`
- `lib/core/governance_compliance/`

Sequence:

- prepare destination folders
- move files only after review
- inspect imports
- review legal/audit references
- confirm references are contract-only
- pause for checkpoint
- confirm rollback available

## Step 5: Move Batch 5 Later

Paths:

- `lib/core/governance_capability/`
- `lib/core/governance_federation/`

Sequence:

- prepare destination folders
- move files only after semantic review
- inspect imports
- review public/internal visibility
- confirm federation remains non-executing
- pause for final Wave 1 checkpoint
- confirm rollback available

## Manual Move Restrictions

During future migration:

- no broad move
- no automated rewrite
- no repo-wide formatting
- no runtime activation
- no provider execution
- no Firebase setup
- no networking
- no Cloud Functions runtime
- no app-owned path inclusion

## Completion Rule

Wave 1 should complete only after all batches pass manual checkpoints and the extracted package remains pure-Dart, contract-only, backend-governed, fail-closed, and deny-by-default.
