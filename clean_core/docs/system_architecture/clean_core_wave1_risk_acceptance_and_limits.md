# clean_core Wave 1 Risk Acceptance and Limits

## Accepted Risks

The following risks are acceptable only within checkpointed Wave 1 execution:

- temporary dual-link complexity
- staged import inconsistency during migration checkpoints
- limited host-app compile instability during checkpoints
- delayed runtime/provider integration
- semantic review delays for governance capability/federation
- temporary public/internal export uncertainty before final barrel review

## Risk Controls

Accepted risks require:

- small batch movement
- manual review
- rollback checkpoint
- no broad automated rewrite
- no unrelated refactor
- no runtime activation
- no provider execution

## Unacceptable Risks

The following are not acceptable:

- runtime activation
- provider execution
- Firebase contamination
- Flutter UI contamination
- generated-file contamination
- app-owned leakage
- irreversible rewrites
- broad uncontrolled exports
- client-side authority expansion
- privileged client writes
- networking or Cloud Functions runtime
- weakening fail-closed behavior
- weakening deny-by-default behavior

## Risk Limit

If an unacceptable risk appears, Wave 1 must stop. The affected files should be restored or reclassified as blocked, adapter-only, internal-only, app-owned, or runtime-deferred.

## Final Execution Verdict

Wave 1 is approved for staged extraction only under checkpointed/manual-review execution.

Wave 1 is not approved for:

- broad automated migration
- runtime activation
- provider execution
- Firebase integration
- package-wide import rewriting
- app-owned dependency movement

Runtime activation remains prohibited. Provider execution remains prohibited. Backend authority must remain preserved.
