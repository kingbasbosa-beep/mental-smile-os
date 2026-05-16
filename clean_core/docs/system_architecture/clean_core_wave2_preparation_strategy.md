# clean_core Wave 2 Preparation Strategy

## Status

Wave 2 is not executed by this document.

## Potential Wave 2 Themes

Wave 2 planning may review:

- additional pure governance contracts
- runtime readiness contracts
- topology contracts
- adapter contract surfaces
- provider governance contracts
- observability/environment contracts

## Required Wave 2 Review

Before any Wave 2 movement:

- inspect imports
- classify app-owned/deferred/internal surfaces
- review public export risk
- review hidden authority semantics
- verify no Firebase/Flutter/provider/networking coupling
- preserve rollback

## Deferred or Sensitive Areas

Require special caution:

- AI safety
- audit
- human review
- legal
- runtime execution
- provider execution
- Firebase/Cloud Functions
- generated/app-shell systems

## Print/PDF/Report Recovery Audit

Future reporting and PDF/print recovery should be reviewed as host/app or adapter-owned unless proven pure Dart and contract-only.

## Wave 2 Verdict

Wave 2 may be planned next, but not executed until a separate pre-move semantic/import review is completed.
