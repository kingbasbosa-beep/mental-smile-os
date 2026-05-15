# Clean Core Stage 1 Export Surface Plan

Draft Stage 1 export plan. No export barrel was created.

## Stage 1 Public Export Groups

Prioritize:

- `backend_boundaries`
- `policy_runtime`
- `safety_decision`
- `trusted_backend`
- `trusted_pipeline`
- `governance_*` directories after file-level import review
- `provider_governance` after semantic review
- `provider_onboarding` after semantic review
- `runtime_*` governance contract directories after semantic review
- `architecture_manifest` after internal/public decision
- `system_topology` after internal/public decision

## Stage 1 Export Rules

- Curated exports only.
- No folder-wide export without review.
- Export stable enums/models/contracts first.
- Export guards/policies/fallbacks only if semantics are stable.
- Keep lock/seal/internal markers private unless explicitly approved.
- No Firebase-coupled files.
- No Flutter UI files.
- No generated files.
- No app-owned imports.

## Internal-Only Groups

Likely internal during Stage 1:

- Unstable lock/seal markers.
- Topology internals.
- Freeze/readiness internals.
- Runtime activation coordination internals.
- Release/bootstrap internals unless public API need is proven.

## Adapter-Only Groups

Keep as contract plans only:

- Firebase bridge.
- Auth/session bridge.
- Routing bridge.
- Localization bridge.
- Environment/config bridge.
- Provider bridge.
- Backend bridge.
- Observability bridge.
- Emulator/test bridge.

## Runtime-Deferred Groups

Do not export active APIs for:

- Runtime execution.
- Provider execution.
- AI execution.
- Networking.
- Cloud Functions orchestration.
- Telemetry/analytics runtime.
- Deployment/release activation.

## Explicit Non-Action

No Stage 1 exports were implemented.
