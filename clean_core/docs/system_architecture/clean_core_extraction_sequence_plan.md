# Clean Core Extraction Sequence Plan

Draft future extraction plan. No extraction, package move, import rewrite, pubspec change, Firebase setup, runtime activation, provider integration, or deployment work was performed.

## Extraction Principles

- Export-safe-first.
- Contracts before runtime.
- Stable before experimental.
- Adapters before integrations.
- Rollback-ready at every phase.
- Preserve fail-closed and deny-by-default posture.
- Keep host app stable during extraction.
- Do not activate runtime AI, provider execution, or backend orchestration during extraction.

## Phase 0: Pre-Extraction Verification

Goals:

- Verify import graph.
- Confirm no parent-path or legacy package imports in export candidates.
- Confirm public API candidates are pure Dart.
- Confirm app-owned systems are clearly excluded.
- Confirm rollback checkpoints and branch strategy.

Exit criteria:

- Export candidates classified.
- Adapter requirements documented.
- No extraction blockers in Phase 1 candidates.

## Phase 1: Pure Contracts

Extract first:

- Pure enums.
- Value objects.
- Immutable-oriented records.
- Legal consent contracts.
- Governance policies and references.
- Safety and audit contracts without Flutter/Firebase/runtime imports.

Keep out:

- UI.
- Firebase.
- Routing.
- Generated files.
- Platform setup.

## Phase 2: Governance Runtime Contracts

Extract after Phase 1 stabilizes:

- Runtime governance contracts.
- Provider governance contracts.
- Audit/review contracts.
- Backend-boundary contracts.
- Human review/escalation contracts.

Rules:

- Contracts remain inert.
- Runtime/provider execution remains disabled.
- Backend authority remains documented.

## Phase 3: Adapter Boundary Contracts

Define and extract only adapter contracts:

- Firebase adapter contracts.
- Auth adapter contracts.
- Routing adapter contracts.
- Localization adapter contracts.
- Environment/config adapter contracts.
- Observability adapter contracts.
- Provider adapter contracts.

Do not extract implementations yet.

## Phase 4: Host App Reconnect

Reconnect host app to extracted package using adapters.

Rules:

- Host app owns Firebase setup.
- Host app owns routing and UI.
- Host app owns generated files, assets, localization, and platform setup.
- Runtime/provider systems remain disabled unless a later backend-governed phase approves activation.

## Deferred

Do not extract until separate readiness review:

- Firebase runtime implementation.
- Cloud Functions/runtime orchestration.
- Provider SDKs and API calls.
- Chat/runtime AI.
- Admin/payment/crisis/legal UI flows.
- Platform setup.
- Generated files.
- Feature UI pages.

## Explicit Non-Action

This plan documents future sequencing only. No package extraction was performed.
