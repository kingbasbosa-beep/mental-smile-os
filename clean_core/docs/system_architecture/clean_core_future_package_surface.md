# Clean Core Future Package Surface

Draft future package surface proposal. No package extraction or pubspec change was performed.

## Likely Future Exported Areas

Candidate package surface after import verification:

- `lib/core/legal/*`
- `lib/core/ai_safety/*`
- `lib/core/backend_boundaries/*`
- `lib/core/audit/*`
- `lib/core/policy_runtime/*`
- `lib/core/human_review/*`
- `lib/core/runtime_environment/*`
- `lib/core/provider_governance/*`
- `lib/core/provider_onboarding/*`
- `lib/core/safety_decision/*`
- `lib/core/conversation_session/*`
- `lib/core/response_composition/*`
- `lib/core/safety_memory/*`
- `lib/core/runtime_execution/*`
- `lib/core/governance_*/*`
- `lib/core/safety_registry/*`
- `lib/core/trusted_backend/*`
- `lib/core/trusted_pipeline/*`
- `lib/core/secure_runtime_envelope/*`
- `lib/core/runtime_readiness/*`
- `lib/core/system_topology/*`
- `lib/core/architecture_manifest/*`
- `lib/core/runtime_activation/*`
- `lib/core/runtime_wiring/*`
- `lib/core/runtime_enablement/*`
- `lib/core/execution_routing/*`
- `lib/core/environment_activation/*`
- `lib/core/runtime_rollback/*`
- `lib/core/runtime_observability/*`
- `lib/core/runtime_isolation/*`
- `lib/core/runtime_release/*`
- `lib/core/runtime_bootstrap/*`

## Likely Non-Exported Areas

Keep app-owned unless a later UI/package strategy is approved:

- Feature UI pages.
- Firebase runtime and initialization.
- Firestore-backed UI flows.
- Routing and app shell.
- Generated files.
- Firebase options.
- Localization generation.
- Assets and asset manifests.
- Platform-specific setup.
- Deferred admin, full chat, payment proof, AI runtime, legal UI, crisis UX runtime, and provider execution flows.

## Package Import Discipline

Future extracted package should:

- Avoid parent-path imports.
- Avoid legacy app package identity coupling.
- Avoid direct imports of app generated files.
- Avoid direct Firebase setup imports.
- Use adapters for all app/runtime integrations.
- Keep governance-first, fail-closed defaults.
- Keep runtime and provider execution disabled unless a future backend-governed activation path is approved.

## Public Surface Shape

Prefer curated exports:

- Stable enum/model/contract exports.
- Versioned policy and audit references.
- Legal consent and disclaimer contracts.
- Runtime/provider governance contracts.
- Backend-boundary contracts.

Avoid broad exports:

- Internal markers.
- Temporary topology objects.
- Placeholder orchestration internals.
- App-owned UI/runtime files.

## Explicit Non-Action

No package surface was created. No barrel exports were added. No pubspec, import, route, Firebase, provider, or runtime behavior was changed.
