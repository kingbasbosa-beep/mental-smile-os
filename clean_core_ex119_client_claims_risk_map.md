# EX-119 Client Claims Risk Map

## Client-Visible Claim Risks

Runtime/provider terms can become misleading if surfaced to clients.

## Risk Areas

| Claim | Risk | Classification |
| --- | --- | --- |
| AI is enabled | Implies execution availability. | host/backend-only |
| Provider is available | Implies provider health/selection proof. | backend-only |
| Provider supports capability | Implies capability guarantee. | backend-only |
| Fallback is active | Implies fallback execution. | host/backend-only |
| Runtime disabled | Could imply verified backend state. | host-only if displayed |
| Backend unavailable | Could imply outage proof. | backend-only |
| Response safe for display | Implies safety validation. | host/backend-only |
| Telemetry inactive/active | Implies privacy/observability proof. | backend-only |
| Emergency/safety handled | Implies ownership/availability. | blocked |

## Observability/Telemetry Hooks

Runtime observability includes owner checks, sanitized observation checks,
trace/audit references, no-telemetry requirements, backend governance checks,
and active observability markers.

Classification: backend-only for proof; host-only for display if externally
provided.

## Client Claims Verdict

Client-facing runtime/provider claims must remain conservative. Package labels
must not imply execution, safety, provider health, fallback recovery, telemetry
proof, or backend enforcement.
