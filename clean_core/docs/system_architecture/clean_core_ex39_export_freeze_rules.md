# EX-39 Export Freeze Rules

Phase: EX-39 - Package Surface Freeze

## Frozen Surface Rule

The current package surface is frozen as of EX-39.

No new export may be added without a separate export governance phase.

## Permanent Export Rules

The following rules apply to all future package surface changes:

- no wildcard exports ever
- no directory exports ever
- explicit file-by-file exports only
- no consumer imports from `lib/src`
- no runtime marker exports without review
- no queue or boundary exports without review
- no Firestore-coupled exports
- no observability exports without isolation review
- no adapter exports without adapter governance approval
- no provider SDK exports
- no Firebase exports
- no networking/runtime client exports

## Barrel Governance

The root barrel must remain:

- curated
- explicit
- review-gated
- rollback-friendly
- grouped by stable contract semantics
- free of runtime implementation authority

## No Broad Migration Rule

Export changes must not be combined with:

- reconnect work
- import migration
- package dependency changes
- runtime activation
- adapter implementation
- host-app feature work

## Freeze Finding

The package surface may evolve only by staged, file-by-file authorization. Broad exports are permanently disallowed.

