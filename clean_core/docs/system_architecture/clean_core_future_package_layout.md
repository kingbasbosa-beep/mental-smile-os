# clean_core Future Package Layout

## Conceptual Package Shape

```text
mental_smile_clean_core/
  lib/
    mental_smile_clean_core.dart
    src/
      backend_boundaries/
      policy_runtime/
      safety_decision/
      trusted_backend/
      trusted_pipeline/
      governance/
        kernel/
        lifecycle/
        compliance/
        capability/
        federation/
      runtime_governance/
      provider_governance/
      internal/
      adapters/
      runtime_deferred/
  test/
    contracts/
  docs/
    system_architecture/
```

## Public Areas

Public candidate areas:

- `src/backend_boundaries/`
- `src/policy_runtime/`
- `src/safety_decision/`
- `src/trusted_backend/`
- `src/trusted_pipeline/`
- stable governance contract groups after review

These areas should expose stable enums, request/response models, guard contracts, policy contracts, references, audit links, review markers, and fail-closed fallback contracts.

## Internal Areas

Internal-only areas:

- `src/internal/`
- unstable topology/federation internals
- lock/seal implementation details
- non-public runtime coordination placeholders
- experimental governance markers

Internal areas should not be exported from the root barrel.

## Adapter-Only Areas

Adapter-only conceptual areas:

- `src/adapters/firebase/`
- `src/adapters/auth/`
- `src/adapters/routing/`
- `src/adapters/localization/`
- `src/adapters/environment/`
- `src/adapters/provider/`
- `src/adapters/backend/`
- `src/adapters/observability/`

These should contain contracts only when created later. Implementations remain host/backend owned.

## Runtime-Deferred Areas

Runtime-deferred conceptual areas:

- `src/runtime_deferred/`
- provider execution planning
- orchestration planning
- runtime activation coordination
- release/bootstrap runtime coordination
- telemetry/analytics runtime coordination

These areas should remain hidden until semantic review and runtime governance approval.

## Documentation Area

`docs/system_architecture/` should retain architecture, extraction, governance, adapter, and runtime-deferral documentation. Docs may be included for handoff/reference but should not imply runtime implementation.
