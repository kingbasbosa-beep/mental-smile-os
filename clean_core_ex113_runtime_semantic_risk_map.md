# EX-113 Runtime Semantic Risk Map

## Runtime Risk Findings

Runtime code includes guards, policies, execution boundaries, markers, fallback
results, request/response contracts, and observability gates. These are not
passive vocabulary.

## Runtime Capability Semantics

`AiRuntimeCapability` contains:

- `textSupport`
- `safetyClassification`
- `fallbackResponse`
- `auditTrace`

Risk: capability labels can imply actual model ability, safety ownership,
fallback availability, or audit support.

Classification:

- metadata-only possible after caveats
- redesign-needed before public export
- not safe as proof of capability

## Runtime State Claims

Risk terms:

- `aiEnabled`
- `fallbackOnlyMode`
- `allowedProviderIds`
- `blockedProviderIds`
- `backendGoverned`
- `runtimeMode`

Risk: these imply live runtime configuration, provider eligibility, and backend
enforcement.

Classification:

- backend-only for enforcement
- host-only for UI/runtime selection
- metadata-only possible only as externally reported state

## Runtime Orchestration Semantics

Risk terms:

- `RuntimeExecutionGuard.blockReason`
- `executionEnabled`
- `providerAllowed`
- `escalationSuggested`
- `failClosed`
- runtime locks
- active markers

Risk: these are decision and orchestration semantics.

Classification: backend-only or host-only. Public package exposure blocked
except for future passive diagnostic labels.

## AI Execution Semantics

Risk terms:

- `AiProviderAdapter.complete`
- `AiRuntimeRequest`
- `AiRuntimeResponse`
- `AiRuntimeResult.success`
- `validatedOutput`

Risk: these imply execution, generated output authority, provider causality, and
validation.

Classification: permanently blocked from passive public exposure. Execution APIs
require separate architecture and safety review.

## Observability/Telemetry Semantics

Risk terms:

- `RuntimeObservation`
- `telemetryRuntimeActive`
- observation owner
- sanitized observation
- trace hash
- no-telemetry runtime requirement

Risk: these imply telemetry state, privacy posture, trace validity, and
ownership.

Classification: backend-only or host-only. Metadata-only possible only for
sanitized, non-authoritative labels.
