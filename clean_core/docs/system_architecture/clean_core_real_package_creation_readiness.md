# clean_core Real Package Creation Readiness

## Status

This document prepares the final readiness structure before real package extraction starts. No package is created, no files are moved, no imports are rewritten, and no runtime/provider behavior is activated by this phase.

## Readiness Objective

The first real package creation step should be small, staged, and rollback-safe. It should create a future pure-Dart package surface only after the approved Wave 1 file groups have passed manual review.

## Required Preconditions

Before any package creation begins:

- full backup exists
- rollback tags exist
- working tree is reviewed for cleanliness
- EX-1 import scan is reviewed
- EX-2 package/export plan is reviewed
- EX-3 Wave 1 batch plan is reviewed
- blocked paths are excluded
- deferred Firestore-coupled domains are excluded
- runtime remains disabled
- provider execution remains blocked

## Package Creation Readiness Criteria

The future extracted package must:

- start as pure Dart
- avoid Flutter UI dependencies
- avoid Firebase dependencies
- avoid generated localization/config/router/assets
- avoid provider SDK dependencies
- avoid networking dependencies
- avoid Cloud Functions runtime
- expose curated contracts only
- preserve fail-closed defaults
- preserve deny-by-default defaults
- keep backend authority outside client-owned code

## Wave 1 Creation Scope

Approved first-wave package creation should prepare for:

- `backend_boundaries`
- `safety_decision`
- `policy_runtime`
- `trusted_backend`
- `trusted_pipeline`
- selected governance areas only after review

## Excluded From Package Creation

Do not include:

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

## Readiness Decision

The package should be created only when the Wave 1 batch list, public barrel plan, internal visibility plan, and rollback plan are all reviewed together.
