# EX-113 Runtime Boundary Matrix

| Concept family | Examples | Classification | Public doctrine |
| --- | --- | --- | --- |
| Passive provider issue reports | future `provider_issue_reported`-style labels | Metadata-only possible | Report only; no causality. |
| Passive fallback observations | future `fallback_loop_observed`-style labels | Metadata-only possible | Observation only; no recovery. |
| Runtime capability labels | `textSupport`, `safetyClassification`, `fallbackResponse`, `auditTrace` | Redesign-needed | No proof of capability or safety. |
| Runtime state claims | `aiEnabled`, `fallbackOnlyMode`, `runtimeMode` | Host/backend-only | Externally reported only if public. |
| Backend governance flags | `backendGoverned`, `requiresBackendGovernance` | Backend-only | Never package proof. |
| Provider trust/permission | trust levels, restrictions, permissions | Backend-only | Authority-bearing. |
| Adapter bridge | `AiProviderAdapter.complete` | Permanently blocked | Execution boundary. |
| AI request/response | runtime request/response/result | Permanently blocked | Execution/data boundary. |
| Runtime guards | guard `blockReason` methods | Backend-only | Decision authority. |
| Execution routing/orchestration | route, enablement, rollback, activation | Backend-only | Execution authority. |
| Safety/moderation ownership | moderation/crisis/escalation capabilities | Host/backend-only | No package ownership. |
| Observability/telemetry | runtime observation, audit trace, telemetry active | Backend-only/host-only | No proof without backend. |

## Boundary Conclusions

- Package-safe: no current runtime/provider execution concepts.
- Metadata-only possible: provider issue reports and fallback observations after
  detox.
- Redesign-needed: runtime capability labels and public diagnostic labels.
- Backend-only: governance, permissions, execution guards, provider trust.
- Host-only: UI/runtime display of externally supplied states.
- Permanently blocked: adapters, execution APIs, retry/recovery guarantees,
  emergency/moderation ownership guarantees.
