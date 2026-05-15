# Clean Core Contract Export Decision Matrix

Draft matrix for export decisions.

| Contract Area | Decision | Rationale |
| --- | --- | --- |
| Legal contracts | Export now candidate | Pure consent/disclaimer contracts are stable candidates. |
| Safety contracts | Export now candidate | Deterministic, non-diagnostic, runtime-disabled contracts. |
| Audit contracts | Export now candidate | Privacy-first references and sanitized audit shapes. |
| Backend boundaries | Export now candidate | Server-owned/protected-field contracts clarify authority. |
| Policy runtime | Export now candidate | Fail-closed policy modes and profile contracts. |
| Safety decision | Export now candidate | Deterministic decision contracts without live AI. |
| Review/escalation | Export after import verification | Needs authority/visibility verification. |
| Trusted backend | Export after import verification | Contracts only; no backend runtime. |
| Trusted pipeline | Export after import verification | Contracts only; no orchestration runtime. |
| Runtime environment | Export after import verification | Useful boundary contracts, but config ownership must be verified. |
| Conversation session | Export after import verification | Export sanitized references only. |
| Response composition | Export after import verification | Static support/fallback contracts can be public later. |
| Safety memory | Export after import verification | Privacy-first boundaries require import and semantics review. |
| Provider governance | Export after semantic review | Capability and trust semantics need stability. |
| Provider onboarding | Export after semantic review | Approval and readiness semantics need review. |
| Runtime governance | Export after semantic review | Large contract family; curate stable subset only. |
| Governance kernel/lifecycle/compliance | Export after semantic review | Public semantics should be settled first. |
| Architecture manifests | Export after semantic review | Stable manifest entries may export; freeze internals should not. |
| Topology/readiness/federation | Internal-only | Likely unstable and integration-planning oriented. |
| Lock/seal markers | Internal-only | Implementation detail unless explicitly stabilized. |
| Adapter contracts | Adapter-contract only | Contracts may export later; implementations remain app/backend-owned. |
| Flutter UI | App-owned / never first export | Host app concern. |
| Firebase setup/options | App-owned / never first export | Host app concern. |
| Routing/navigation | App-owned / never first export | Host app concern. |
| Generated files | App-owned / never first export | Build-system concern. |
| Runtime execution | Deferred until runtime phase | No active runtime exports. |
| Provider SDKs | Deferred until runtime phase | No SDK/API calls in clean_core export. |

## Decision Rules

- If a contract has app-owned imports, it cannot be exported yet.
- If a contract encodes authority or lifecycle decisions, it needs semantic review.
- If a contract only supports future runtime execution, defer it unless public planning API is required.
- If a contract is pure, stable, and fail-closed, it can be a first export candidate.

## Explicit Non-Action

No export decisions were implemented in code.
