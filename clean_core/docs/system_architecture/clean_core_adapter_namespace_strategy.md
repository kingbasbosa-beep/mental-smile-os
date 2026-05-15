# Clean Core Adapter Namespace Strategy

Draft namespace strategy only. No adapter folders or code were created.

## Namespace Principle

Future adapter namespaces should make ownership obvious and keep implementations outside clean_core unless explicitly approved. clean_core should define contracts; host/backend systems should implement them.

## Candidate Namespaces

- `adapters/firebase`
- `adapters/auth`
- `adapters/routing`
- `adapters/localization`
- `adapters/environment`
- `adapters/observability`
- `adapters/analytics`
- `adapters/provider`
- `adapters/backend`
- `adapters/deployment`
- `adapters/testing`

## Contract Naming Guidance

Use names that reveal boundaries:

- `FirebaseAccessContract`
- `AuthSessionContract`
- `RouteIntentContract`
- `TextResolutionContract`
- `EnvironmentConfigContract`
- `ObservabilityBridgeContract`
- `AnalyticsBridgeContract`
- `ProviderBridgeContract`
- `TrustedBackendBridgeContract`
- `ReleaseDeploymentContract`
- `EmulatorFixtureContract`

These are planning names only.

## Implementation Placement

- clean_core: contracts, request/response shapes, fail-closed defaults.
- Host app: Flutter UI, navigation, Firebase setup, generated localization, assets, platform setup.
- Backend: trusted operations, provider execution, governance enforcement, Cloud Functions/runtime orchestration.
- Test harness: emulator startup and integration fixtures.

## Export Guidance

- Export adapter contracts only after semantic review.
- Do not export implementations from clean_core.
- Keep provider/backend/runtime adapters disabled until future activation phase.
- Avoid namespace names that imply live execution.

## Explicit Non-Action

No namespaces, directories, exports, or adapter code were created.
