# Clean Core Dual-Link Transition Simulation

Draft dual-link transition simulation.

## Dual-Link Principle

During future extraction, the host app may temporarily keep old source paths while gradually referencing the extracted package for curated contracts. This is a temporary safety strategy, not a permanent architecture.

## Temporary Coexistence

Allowed conceptually:

- Host app references old paths temporarily.
- Extracted package references curated contracts only.
- App-owned implementations remain in host app.
- Adapter reconnects happen incrementally.

Not allowed:

- Runtime activation.
- Provider execution.
- Firebase setup inside clean_core.
- Generated files exported from clean_core.
- Privileged client writes.

## Incremental Reconnect

Reconnect in small steps:

1. Pure contracts.
2. Environment/config contract.
3. Auth/session contract.
4. Firebase adapter contract.
5. Backend bridge contract.
6. Routing/text/asset intent contracts.
7. Observability contract.
8. Provider governance contract.

## Rollback Availability

At every step:

- Host app can return to old path.
- Extracted package can be temporarily disabled.
- App-owned implementation remains intact.
- Runtime remains disabled.
- Provider execution remains blocked.

## Exit Criteria

Dual-link phase ends only when:

- Curated contract imports are stable.
- Host app reconnects through adapters.
- No parent-path leaks remain.
- No generated/runtime contamination remains.
- Final governance review passes.

## Explicit Non-Action

No dual-link transition was implemented.
