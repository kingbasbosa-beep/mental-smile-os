# clean_core Adapter Layer Philosophy

## Adapter Role

Adapters connect clean_core contracts to host/backend runtime systems without allowing clean_core to own runtime behavior.

## Adapter Boundaries

Adapters may define:

- contract shapes
- request/result envelopes
- authority references
- fallback results
- blocked results
- review-required results

Adapters must not implement inside clean_core:

- Firebase runtime
- provider execution
- networking
- Cloud Functions calls
- routing execution
- UI rendering
- telemetry pipelines

## Runtime Bridge Isolation

Runtime bridges must remain:

- host-owned or backend-owned
- explicitly authorized
- audit-aware
- review-aware
- fail-closed
- deny-by-default

## Backend Authority Preservation

Adapters must preserve:

- backend-governed authority
- signed-operation expectations
- protected-field rules
- no privileged client writes
- no silent escalation

## Adapter Failure Posture

If an adapter is missing or unavailable:

- block trusted action
- return fallback/review-required contract
- do not activate runtime
- do not switch providers
- do not bypass backend governance

## Adapter Verdict

Adapter layers are future reconnect boundaries, not runtime execution permission.
