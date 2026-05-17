# EX-113 Runtime/Provider Public Doctrine Map

## Scope

Initial Runtime/Provider Public Doctrine map before any package exposure review.
This is docs/review only. No runtime/source logic, package contracts, mappers,
exports, consumers, imports, pub get/analyze, providers, adapters, Firebase, or
runtime execution were changed or activated.

## Commands Used

- `Get-ChildItem clean_core/lib/core/ai_runtime`
- `Get-ChildItem clean_core/lib/core/providers`
- `Get-ChildItem clean_core/lib/core/provider_governance`
- `Get-ChildItem clean_core/lib/core/runtime_execution`
- `Get-ChildItem clean_core/lib/core/runtime_observability`
- `Get-ChildItem clean_core/lib/core/execution_routing`
- `Get-ChildItem -Filter "clean_core_ex*.md"`
- `Get-Content` for selected AI runtime, provider governance, runtime execution,
  runtime observability, and EX-101 through EX-112 doctrine files
- `rg` for runtime/provider/fallback/recovery/observability terminology

Note: `clean_core/lib/core/providers` was not present. Provider-related
contracts were found under `clean_core/lib/core/provider_governance`.

## Doctrine Baseline

EX-100 through EX-112 established that labels are facts, not powers. Runtime and
provider terms are higher risk than passive review labels because they can imply
actual execution, provider selection, backend governance, safety ownership,
telemetry activity, fallback recovery, or AI output authority.

## Mapped Concept Groups

### Runtime ownership concepts

- `aiEnabled`
- `fallbackOnlyMode`
- `runtimeMode`
- `executionEnabled`
- `runtimeAllowed`
- `backendGoverned`
- runtime markers
- runtime locks and fail-closed policy

Classification: backend-only or host-only. Public package exposure requires
redesign into passive labels.

### Provider ownership concepts

- provider IDs
- provider registry
- provider capabilities
- provider trust level
- provider restrictions
- provider approval/blocked states

Classification: backend-only for enforcement; metadata-only possible only as
externally reported labels after detox.

### Adapter bridge concepts

- `AiProviderAdapter.complete`
- `DisabledAiProviderAdapter`
- provider request/response bridge

Classification: permanently blocked from public passive package exposure.
Adapters are execution boundaries.

### Fallback/provider failure concepts

- `providerUnavailable`
- `providerFailure`
- `fallbackOnlyMode`
- `fallbackLoop`
- `runtimeDisabled`
- `backendUnavailable`

Classification: metadata-only possible after detox, but not public execution
signals. Provider/fallback causality remains host/backend-owned.

## Doctrine Summary

Runtime/provider semantics must remain internal until a separate public doctrine
defines passive terminology, public caveats, and misuse boundaries.
