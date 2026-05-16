# clean_core Adapter Security Review

This review identifies security risks for future adapter/bridge work.

## Risks

| Risk | Severity | Control |
| --- | --- | --- |
| Accidental authority leakage | High | Keep backend authority external and signed. |
| Adapter privilege escalation | High | Deny privileged client writes. |
| Runtime bypass | High | Require governance gate before execution. |
| Firebase misuse | High | Keep Firebase SDK out of clean_core. |
| Distributed execution expansion | High | Prevent federation/capability contracts from acting as orchestration. |
| Orchestration creep | High | Separate bridge contracts from startup/runtime logic. |
| Hidden runtime activation | High | Treat activation as separate governed phase. |
| Provider leakage | High | Block provider SDKs in clean_core. |
| Report/export data leak | Medium-high | Require privacy/visibility checks before export. |
| Telemetry overreach | Medium | Sanitize and consent-gate observations. |

## Review Requirements

Before adapter implementation:

- authority review
- security review
- privacy review
- failure-mode review
- rollback review
- package-boundary review

## Security Verdict

Adapters are high-risk only when they cross from contracts into execution. Keep implementations host/backend-owned and fail-closed.
