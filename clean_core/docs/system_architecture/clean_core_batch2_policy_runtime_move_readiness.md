# clean_core Batch 2 Policy Runtime Move Readiness

## Batch 2 Target

- `clean_core/lib/core/policy_runtime/`

## Movement Readiness

The full directory is move-ready as a pure-Dart contract group.

Reasons:

- imports are local sibling Dart imports only
- no Firebase contamination was found
- no Flutter UI contamination was found
- no generated-file contamination was found
- no provider SDK contamination was found
- no networking contamination was found
- no app-owned imports were found
- no parent-path escaping imports were found
- no runtime/provider execution implementation was found

## Export Readiness

Public export readiness is partial.

Export-safe after movement:

- audit link
- fallback reasons
- runtime policy modes
- modules
- requirements
- restrictions
- scopes
- snapshot references
- state models

Keep hidden or review-required:

- guard
- pack
- profile
- resolver

## Rollback Readiness

Rollback remains clear if Batch 2 is moved as a single isolated directory after approval.

Required future checkpoint:

- verify moved file count
- verify package-local imports
- verify no forbidden dependency
- update barrel file-by-file only
- confirm resolver/profile/guard/pack export status
- confirm runtime remains disabled
- confirm provider execution remains blocked

## Readiness Verdict

Batch 2 may proceed later under checkpointed execution.

Batch 2 is not approved for:

- broad automated migration
- broad barrel export
- runtime activation
- provider execution
- Firebase integration
- networking
- app-owned dependency movement

No Batch 2 movement was performed during this review.
