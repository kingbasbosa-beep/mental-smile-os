# Clean Core Internal-Only Contracts

Draft internal-only contract guidance.

## Internal-Only Areas

Keep out of public exports unless later stabilized:

- Runtime orchestration.
- Provider runtime coordination.
- Internal safety pipelines.
- Runtime activation coordination.
- Release/bootstrap coordination.
- Observability pipelines.
- Shutdown/circuit-breaker coordination.
- Internal escalation coordination.
- Topology/readiness/federation internals.
- Architecture freeze internals.
- Lock/seal markers not intended as stable API.

## Why Internal

These areas are:

- Runtime sensitive.
- Backend authority sensitive.
- Review sensitive.
- Likely to evolve during extraction.
- Too easy to mistake for active runtime behavior.

## Rules

- Not export-safe.
- Not public API.
- No export-all barrels.
- Keep backend/runtime-sensitive semantics documented.
- Do not imply client-side authority.
- Do not imply runtime activation.

## Promotion Criteria

Promote only after:

- Manual import scan.
- Semantic review.
- Authority review.
- Fail-closed review.
- Versioning review.
- Public API review.

## Explicit Non-Action

No internal visibility enforcement was added.
