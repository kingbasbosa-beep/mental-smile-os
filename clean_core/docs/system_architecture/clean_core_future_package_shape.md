# Clean Core Future Package Shape

Draft future package shape. No package directories or exports were created.

## Conceptual Structure

```text
clean_core/
  contracts/
  governance/
  policy/
  audit/
  safety/
  escalation/
  review/
  backend_boundary/
  feedback/
  adapters/
  internal/
  runtime_deferred/
```

## Public Export Philosophy

- Curated exports only.
- Stable contracts first.
- No export-all barrels.
- No UI/runtime/generated exports.
- No Firebase/provider SDK exports.
- Public API should preserve fail-closed and deny-by-default defaults.

## Internal Visibility Expectations

Keep internal:

- Runtime orchestration internals.
- Runtime activation coordination.
- Release/bootstrap coordination.
- Shutdown/circuit-breaker internals.
- Topology/readiness/federation internals.
- Lock/seal markers unless stabilized.

## Adapter Ownership Expectations

- clean_core owns adapter contracts only.
- Host app owns Firebase, UI, routing, localization, assets, platform setup, environment loading, and generated files.
- Backend owns trusted operations, privileged writes, provider execution, and runtime orchestration if later approved.

## Semantic Versioning Expectations

After extraction:

- Patch: docs and non-breaking clarifications.
- Minor: additive stable contracts.
- Major: authority changes, fail-closed behavior changes, removed/renamed exported contracts, or runtime/provider activation surface changes.

## Stabilization Expectations

Before promoting any internal or runtime-deferred area:

- Manual import scan.
- Semantic review.
- Security/fail-closed review.
- Backend authority review.
- Adapter ownership review.
- Public API review.

## Explicit Non-Action

No package shape was created in the filesystem.
