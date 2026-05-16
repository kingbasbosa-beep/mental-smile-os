# clean_core Runtime Marker Observability Review

Phase: EX-32 - Runtime Marker Isolation Review

## Observability Boundary

Observability contracts must not become telemetry runtime, analytics runtime, or monitoring infrastructure inside `clean_core`.

The current observability posture is declarative only.

## Reviewed Observability Surfaces

Reviewed surfaces include:

- safety observability contract
- audit runtime marker
- runtime observability runtime marker
- runtime observation
- runtime observability profile
- runtime observability guard
- runtime observability policy
- runtime observability fallback

## Declarative Observability Labels

Label-only surfaces may describe:

- observation id
- observation owner
- sanitized preview
- trace hash
- fallback reason
- audit reference
- runtime marker
- telemetry runtime active flag

These labels do not start telemetry runtime.

## Observability Guard and Policy Risk

The observability guard and policy files are semantically sensitive because they evaluate:

- lock state
- policy version
- runtime allowed
- provider allowed
- review requirements
- audit link requirements
- observation ownership
- sanitization
- telemetry runtime absence
- backend governance
- fail-closed posture

These are hidden/internal review surfaces, not general public exports.

## Observability Activation Rule

No marker or contract may be used to activate telemetry or observability runtime.

Any future observability bridge must be host/backend-owned and adapter-isolated. Missing observability authority must fail closed where observability is required.

## Observability Verdict

Observability files are import-clean but semantically sensitive. Marker and fallback labels may become export candidates only after file-by-file review. Guard, policy, lock, and profile semantics should remain hidden/internal until later authority approval.

