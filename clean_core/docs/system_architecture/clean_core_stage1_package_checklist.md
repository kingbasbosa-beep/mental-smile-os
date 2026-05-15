# clean_core Stage 1 Package Checklist

## Before Move

Confirm:

- full backup exists
- rollback tags exist
- working tree is clean or intentionally reviewed
- EX-1 import scan is complete
- EX-2 export/package plan is complete
- EX-3 Wave 1 batch plan is complete
- blocked files are excluded
- deferred Firestore-coupled files are excluded
- package name and future layout are approved
- public barrel plan is approved
- rollback plan is available

## During Move

For each batch:

- move only the approved batch
- do not use broad moves
- do not perform automated import rewrites
- inspect imports manually
- inspect exports manually
- preserve original semantics
- preserve fail-closed posture
- preserve deny-by-default posture
- keep runtime disabled
- keep provider execution blocked
- pause for checkpoint review

## After Move

Confirm:

- package structure matches approved layout
- only approved Wave 1 files are present
- no Firebase dependency exists
- no Flutter UI dependency exists
- no generated imports exist
- no provider SDK dependency exists
- no networking dependency exists
- no Cloud Functions runtime exists
- no runtime/provider execution exists
- root barrel is curated
- internal files are not publicly exported
- host app still owns runtime systems
- rollback path remains available

## Blocked File Checklist

Confirm absence of:

- `lib/main.dart`
- `lib/firebase_options.dart`
- `lib/app/**`
- `lib/l10n/**`
- `lib/features/**`
- `lib/shared/ui_kit/**`
- `lib/core/auth/**`
- `lib/core/storage/**`
- `assets/**`
- app-coupled tests
- Firestore-coupled `ai_safety`, `audit`, `human_review`, and `legal` files

## Acceptance Checklist

Stage 1 package creation is acceptable only if:

- pure Dart-first strategy is preserved
- backend authority model is preserved
- governance-first architecture is preserved
- adapter boundaries remain isolated
- runtime remains disabled
- provider execution remains blocked
- rollback is still practical
- each batch passed checkpoint review
