# clean_core Wave 2 Runtime Ownership Review

This review confirms runtime ownership boundaries before any Wave 2 work.

## Runtime-Owned Areas

Runtime remains host/backend-owned for:

- AI execution
- provider execution
- orchestration
- Firebase runtime
- auth/session runtime
- telemetry and analytics transport
- routing/navigation
- localization generation
- print/PDF/export runtime
- notifications/background services
- queue processing

## Runtime-Deferred clean_core Areas

The following should remain deferred or internal:

- `core/runtime_activation/`
- `core/runtime_enablement/`
- `core/runtime_execution/`
- `core/runtime_wiring/`
- `core/runtime_environment/`
- `core/runtime_readiness/`
- `core/runtime_bootstrap/`
- `core/runtime_release/`
- `core/runtime_observability/`
- `core/runtime_isolation/`
- `core/runtime_rollback/`
- `core/secure_runtime_envelope/`
- `core/ai_runtime/`

## Runtime Extraction Rule

Runtime-named contracts may be extracted only if they are proven:

- pure Dart
- contract-only
- disabled by default
- fail-closed
- deny-by-default
- not executable
- not provider-activating

## Runtime Review Verdict

Wave 2 should not prioritize runtime folders. Runtime concepts remain deferred until adapter and authority reviews are complete.
