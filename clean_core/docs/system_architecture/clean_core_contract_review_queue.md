# Clean Core Contract Review Queue

Draft review queue before future public exports.

## Queue 1: Import Verification

Review these for app-owned imports:

- Legal contracts.
- Safety contracts.
- Audit contracts.
- Backend-boundary contracts.
- Policy runtime contracts.
- Safety decision contracts.
- Review/escalation contracts.
- Trusted backend and trusted pipeline contracts.
- Runtime environment contracts.
- Conversation, response, and safety-memory contracts.

Pass criteria:

- No Flutter UI imports in pure contracts.
- No Firebase setup/options imports.
- No generated localization/config imports.
- No router/navigation imports.
- No parent-path or legacy package imports.

## Queue 2: Semantic Review

Review these for stable meaning and authority boundaries:

- Provider governance.
- Provider onboarding.
- Runtime activation.
- Runtime enablement.
- Runtime wiring.
- Execution routing.
- Runtime rollback.
- Runtime observability.
- Runtime isolation.
- Runtime release.
- Runtime bootstrap.
- Governance kernel/lifecycle/compliance.
- Architecture manifest and freeze structures.

Pass criteria:

- Names are stable.
- Default behavior remains fail-closed.
- Client authority is not expanded.
- Backend-governed expectations are documented.
- Runtime/provider execution remains disabled.

## Queue 3: Internal-Only Confirmation

Confirm these stay hidden unless later stabilized:

- Lock/seal/readiness markers.
- Topology internals.
- Federation internals.
- Temporary orchestration placeholders.
- Architecture freeze internals.
- Runtime release/bootstrap internals.

Pass criteria:

- Not exported through first public surface.
- No app code depends on them as public API.
- Documented as internal or unstable.

## Queue 4: Adapter Contract Planning

Plan contracts only for:

- Firebase.
- Auth.
- Routing.
- Localization.
- Environment/config.
- Observability.
- Provider bridge.
- Emulator/test setup.

Pass criteria:

- No implementation included.
- No networking.
- No SDK dependency.
- Host/backend ownership is documented.

## Queue 5: Deferred Runtime Confirmation

Confirm these remain deferred:

- Runtime execution.
- Provider execution.
- Chat AI.
- Crisis/escalation automation.
- Cloud Functions orchestration.
- Telemetry runtime.
- Deployment/release activation.

Pass criteria:

- No active runtime API exported.
- No provider SDK exported.
- No backend orchestration included.

## Explicit Non-Action

This queue is planning-only. No files were moved, exported, renamed, or activated.
