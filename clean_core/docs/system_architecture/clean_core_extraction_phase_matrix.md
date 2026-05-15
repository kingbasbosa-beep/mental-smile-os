# Clean Core Extraction Phase Matrix

Draft extraction matrix for future planning.

| Phase | Scope | Status Before Start | Exit Criteria | Risk |
| --- | --- | --- | --- | --- |
| 0 | Verification | Audits complete | Import graph and export candidates verified | Medium |
| 1 | Pure contracts | Export-safe files identified | Pure Dart package surface compiles independently | Low |
| 2 | Governance contracts | Phase 1 stable | Runtime/provider governance exported as inert contracts | Medium |
| 3 | Adapter contracts | Boundaries approved | Adapter interfaces exist without implementations | Medium |
| 4 | Host reconnect | Package available | Host app reconnects through adapters | High |
| Deferred | Runtime implementations | Later approval required | Backend-governed activation approved | High |

## Phase 1 Candidates

- Legal contracts.
- Safety contracts.
- Audit contracts.
- Policy contracts.
- Governance references and stable enums.
- Backend-boundary contracts that are pure Dart.

## Phase 2 Candidates

- Runtime environment and execution boundary contracts.
- Runtime activation, enablement, wiring, routing, rollback, observability, isolation, release, and bootstrap governance contracts.
- Provider governance and onboarding contracts.
- Human review/escalation contracts.

## Phase 3 Candidates

- Firebase/Auth adapter contracts.
- Routing adapter contracts.
- Localization adapter contracts.
- Environment/config adapter contracts.
- Observability adapter contracts.
- Provider adapter contracts.

## Deferred Systems

- Firebase runtime.
- Routing implementation.
- Flutter UI.
- Assets.
- Localization generation.
- Generated files.
- Provider SDKs.
- Runtime execution.
- Cloud Functions orchestration.
- Deployment/store release.

## Sequencing Rules

- Do not extract Phase 2 before Phase 1 is stable.
- Do not reconnect host app before adapter contracts are defined.
- Do not export runtime implementations during package extraction.
- Do not remove legacy/app-owned files during initial extraction.
