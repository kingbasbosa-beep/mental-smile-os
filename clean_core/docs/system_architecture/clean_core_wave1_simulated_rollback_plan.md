# clean_core Wave 1 Simulated Rollback Plan

## Rollback Principle

Rollback must preserve fail-closed defaults, deny-by-default behavior, backend authority, and host-app stability. Rollback must not activate runtime systems or provider execution.

## Rollback After Batch 1

Trigger examples:

- backend-boundary import contamination
- safety-decision import contamination
- incorrect package path placement
- root barrel exposure too broad

Response:

- restore Batch 1 files to original locations
- remove simulated package references
- keep host app references unchanged
- reclassify offending files before retry

## Rollback After Batch 2

Trigger examples:

- policy file implies live execution
- permissive policy fallback appears
- policy barrel grants client-side authority

Response:

- restore policy files to original locations
- remove policy barrel exports
- mark questionable files for semantic review

## Rollback After Batch 3

Trigger examples:

- trusted backend file imports networking/backend runtime
- trusted pipeline file imports orchestration/runtime execution
- trusted boundary naming creates activation ambiguity

Response:

- restore trusted backend/pipeline files
- remove trusted barrels
- keep runtime/provider disabled
- update boundary documentation before retry

## Rollback After Batch 4

Trigger examples:

- governance files depend on deferred audit/legal runtime
- compliance files imply privileged client authority
- lifecycle files import app-owned systems

Response:

- restore governance kernel/lifecycle/compliance files
- split risky files into later review queue
- keep only pure contracts in future retry

## Rollback After Batch 5

Trigger examples:

- federation files are too internal for public export
- capability files imply runtime permission grants
- internal markers leak through public barrel

Response:

- restore capability/federation files
- mark as internal-only or runtime-deferred
- complete Wave 1 with earlier successful batches only if approved

## Barrel Export Rollback

Rollback if:

- root barrel exports whole directories blindly
- internal files become public
- runtime-deferred files become public
- app-owned files become public

Response:

- remove broad exports
- restore curated exports only
- document public/internal decision before retry

## Host-App Import Rollback

Rollback if:

- host app imports break unexpectedly
- dual-link imports become inconsistent
- app-owned paths are pulled into package

Response:

- restore host imports to original paths
- keep package migration paused
- review dependency direction before retry

## Hidden Dependency Rollback

Rollback if any extracted file reveals:

- Firebase import
- Flutter UI import
- generated import
- provider SDK import
- networking import
- Cloud Functions coupling

Response:

- restore affected files
- classify as blocked, adapter-only, app-owned, or runtime-deferred
- do not continue to the next batch until reviewed
