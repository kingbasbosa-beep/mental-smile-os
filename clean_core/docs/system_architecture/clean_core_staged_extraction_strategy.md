# Clean Core Staged Extraction Strategy

Draft staged extraction strategy.

## Stage 1: Core Governance Contracts

Candidate groups:

- Governance contracts.
- Policy contracts.
- Audit/review contracts.
- Safety decision contracts.

Validation expectations:

- Pure Dart only.
- No Firebase, Flutter UI, generated files, routing, provider SDKs, or networking.
- Fail-closed defaults verified.

## Stage 2: Review, Legal, And Signed Authority Contracts

Candidate groups:

- Escalation/review contracts.
- Legal/compliance contracts.
- Signed-operation contracts.
- Protected-field authority contracts.

Validation expectations:

- Backend authority semantics reviewed.
- No client-side trusted outcomes.
- Audit/review sensitivity documented.

## Stage 3: Operational And Adapter Contract Surfaces

Candidate groups:

- Feedback/control-room contracts.
- Backend-boundary contracts.
- Adapter contract surfaces.

Validation expectations:

- Adapter contracts are implementation-free.
- Host/backend ownership is documented.
- No runtime SDK setup enters clean_core.

## Stage 4 Later: Runtime-Deferred Placeholders

Candidate groups:

- Runtime-deferred placeholders only if stabilized.
- Runtime activation, enablement, routing, release, rollback, bootstrap, observability, and isolation contracts only if public API need is proven.

Validation expectations:

- No active runtime API.
- No provider execution.
- Backend-governed activation remains future-only.

## Stop Conditions

Stop a stage if:

- App-owned imports appear.
- Runtime activation appears.
- Provider SDKs appear.
- Privileged client writes appear.
- Fail-closed or deny-by-default posture weakens.

## Explicit Non-Action

No staged extraction was performed.
