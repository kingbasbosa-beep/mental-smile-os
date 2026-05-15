# clean_core Final Extraction Execution Authorization

## Status

This document authorizes only a future staged Wave 1 extraction review. It does not move files, create package files, rewrite imports, activate runtime systems, or enable provider execution.

## Authorization Summary

Wave 1 is conceptually approved for staged execution only under manual checkpoint control. Broad automated migration is not authorized.

## Approved Wave 1 Scope

Approved first-wave candidate groups:

- `lib/core/backend_boundaries/`
- `lib/core/safety_decision/`
- `lib/core/policy_runtime/`
- `lib/core/trusted_backend/`
- `lib/core/trusted_pipeline/`

Approved after review:

- `lib/core/governance_kernel/`
- `lib/core/governance_lifecycle/`
- `lib/core/governance_compliance/`
- `lib/core/governance_capability/`
- `lib/core/governance_federation/`

## Blocked Scope

Blocked from Wave 1:

- `lib/main.dart`
- `lib/firebase_options.dart`
- `lib/app/**`
- `lib/l10n/**`
- `lib/features/**`
- `lib/shared/ui_kit/**`
- `lib/core/auth/**`
- `lib/core/storage/**`
- `assets/**`
- current app-coupled tests
- Firestore-coupled `ai_safety`, `audit`, `human_review`, and `legal` files

## Approved Batches

Batch 1:

- `lib/core/backend_boundaries/`
- `lib/core/safety_decision/`

Batch 2:

- `lib/core/policy_runtime/`

Batch 3:

- `lib/core/trusted_backend/`
- `lib/core/trusted_pipeline/`

Batch 4:

- `lib/core/governance_kernel/`
- `lib/core/governance_lifecycle/`
- `lib/core/governance_compliance/`

Batch 5:

- `lib/core/governance_capability/`
- `lib/core/governance_federation/`

## Required Checkpoints

Each batch requires:

- file list review
- import review
- export review
- package path review
- blocked-scope review
- runtime-disabled confirmation
- provider-blocked confirmation
- rollback checkpoint confirmation

## Rollback Authority

Rollback is authorized at every batch boundary if contamination, unstable exports, host-app breakage, or authority expansion appears.

## Stop Authority

Execution must stop immediately if a mandatory stop condition appears. Stop authority takes priority over schedule, convenience, and broad migration momentum.

## Execution Discipline

Future extraction must remain:

- staged
- manual-review driven
- rollback-first
- checkpoint-first
- pure-Dart first
- contract-only
- backend-authority preserving
- fail-closed
- deny-by-default

## Final Authorization

Approved for staged Wave 1 extraction only. Not approved for broad automated migration, runtime activation, provider execution, or app-owned dependency movement.
