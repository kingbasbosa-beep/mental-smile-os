# clean_core Batch 5 Capability and Federation Move Readiness

## Batch 5 Targets

- `clean_core/lib/core/governance_capability/`
- `clean_core/lib/core/governance_federation/`

## Movement Readiness

Both directories are move-ready as pure-Dart, non-executing governance contract groups.

Reasons:

- imports are local sibling Dart imports only
- no Firebase contamination was found
- no Flutter UI contamination was found
- no generated-file contamination was found
- no provider SDK contamination was found
- no networking contamination was found
- no Cloud Functions runtime coupling was found
- no app-owned imports were found
- no parent-path escaping imports were found
- no orchestration/provider execution implementation was found
- safe defaults preserve blocked, locked, sealed, backend-governed, and fail-closed posture

## Export Readiness

Public export readiness is partial.

Export-safe after movement:

- audit links
- block reasons
- fallbacks
- references
- requirements
- review/runtime markers
- scopes
- states
- visibility scopes

Keep hidden or review-required:

- main capability object
- capability guard
- capability policy
- main federation object
- federation guard
- federation lock
- federation policy

## Rollback Readiness

Rollback remains clear if Batch 5 is moved as two isolated directories after approval.

Required future checkpoint:

- verify moved file counts
- verify package-local imports
- verify no forbidden dependencies
- update root barrel file-by-file only
- confirm authority-adjacent files remain hidden
- confirm runtime remains disabled
- confirm provider execution remains blocked

## Readiness Verdict

Batch 5 may proceed later under checkpointed execution.

Batch 5 is not approved for:

- broad automated migration
- broad barrel export
- runtime activation
- provider execution
- distributed authority expansion
- federation runtime activation
- orchestration assumptions
- Firebase integration
- networking
- app-owned dependency movement

No Batch 5 movement was performed during this review.
