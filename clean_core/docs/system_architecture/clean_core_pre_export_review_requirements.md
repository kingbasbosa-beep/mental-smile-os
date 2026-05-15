# Clean Core Pre-Export Review Requirements

Draft review requirements before future public export.

## Governance Review

Confirm:

- Backend-governed authority is preserved.
- Client-side governance authority is not introduced.
- Runtime/provider execution remains disabled.
- Sensitive workflows remain review-aware.

## Adapter Review

Confirm:

- Adapter contracts are implementation-free.
- Host/backend ownership is documented.
- Firebase, provider, routing, localization, environment, observability, and deployment adapters remain outside clean_core implementation.

## Export Review

Confirm:

- Public API is curated.
- No broad export-all barrels.
- Stable contracts are exported first.
- Internal markers remain hidden.

## Contamination Review

Confirm:

- No parent-path imports.
- No legacy package identity coupling.
- No generated-file leakage.
- No Firebase/provider SDK leakage.
- No UI/app-shell leakage.

## Rollback Review

Confirm:

- Extraction rollback checkpoints exist.
- Dual-link strategy is documented.
- Partial extraction recovery is understood.

## Reconnect Review

Confirm:

- Reconnect order is documented.
- Host app responsibilities are clear.
- Firebase and routing reconnects remain app-owned.
- Runtime/provider reconnects remain deferred.

## Firebase Boundary Review

Confirm:

- Firebase setup remains host-owned.
- Firestore protected fields remain backend-governed.
- Functions runtime remains backend-owned.
- Emulator tests remain host/test-harness owned.

## Observability Review

Confirm:

- No raw sensitive content in fixtures or contracts.
- Audit links and sanitized observations are preserved.
- Telemetry runtime remains outside clean_core.

## Security/Fail-Closed Review

Confirm:

- Missing authority fails closed.
- Missing backend fails closed.
- Missing provider remains blocked.
- Missing environment uses fallback-only/runtime-disabled state.
- Review-required state is preserved.

## Explicit Non-Action

No review was executed or recorded in this phase.
