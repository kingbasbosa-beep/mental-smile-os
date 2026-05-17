# EX-119 Runtime Orchestration Mapping

## Scope

Review/docs only. This map identifies runtime/provider orchestration
responsibilities before any package exposure, refactor, or diagnostic
introduction. No runtime/source files, contracts, mappers, exports, consumers,
imports, pub get/analyze, providers, adapters, Firebase, or runtime execution
were changed or activated.

## Runtime Execution Ownership

Runtime execution is not package-safe. It is represented by:

- `AiProviderAdapter.complete`
- `AiRuntimeRequest`
- `AiRuntimeResponse`
- `AiRuntimeResult.success`
- `RuntimeExecutionGuard`
- `RuntimeExecutionPolicy`
- `ResponseComposition.isSafeForDisplay`

Classification: backend-only or host/backend-owned.

## Runtime State and Mode

Runtime state concepts include:

- `aiEnabled`
- `fallbackOnlyMode`
- `runtimeMode`
- `allowedProviderIds`
- `blockedProviderIds`
- `backendGoverned`

Classification: host-only for display, backend-only for enforcement.

## Runtime Orchestration Responsibilities

| Responsibility | Owner |
| --- | --- |
| decide runtime enabled/disabled | backend/host |
| decide provider allowed/blocked | backend |
| decide fallback-only mode | backend/host |
| execute provider adapter | backend/runtime host |
| validate AI output | backend/host |
| decide safe display | backend/host |
| persist runtime request/response | backend only if allowed |

## Package-Safe Candidates

None for execution/orchestration. Only passive reference labels already exposed
elsewhere are safe.

## Runtime Verdict

Runtime orchestration must remain outside package contracts and public passive
diagnostics.
