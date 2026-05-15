# Clean Core App-Owned Dependency Map

Draft dependency ownership map for future extraction. No extraction, file movement, import rewrite, package change, runtime activation, Firebase setup, provider integration, or command scan was performed.

## App-Owned Dependencies

The following systems must remain owned by the host application unless a future extraction phase explicitly introduces adapter contracts and separate implementation ownership:

- Firebase initialization.
- Firebase options and generated config.
- Firestore runtime.
- Auth runtime and active session handling.
- Cloud Functions runtime.
- Routing and navigation.
- Flutter UI rendering.
- App shell and app lifecycle bootstrapping.
- Localization generation.
- Generated files.
- Assets and asset manifests.
- Android, iOS, macOS, web, and desktop platform setup.
- Deployment and store configuration.
- Analytics runtime.
- Telemetry runtime.
- Provider SDK runtime.
- Environment runtime loading.

## Clean Core Ownership

clean_core should own:

- Pure contracts.
- Governance policies and guards.
- Legal consent contracts.
- Audit/review references.
- Backend-boundary definitions.
- Provider governance contracts.
- Runtime governance placeholders.
- Documentation and extraction planning artifacts.

## Authority Boundary

clean_core exports contracts, not runtime authority. Runtime authority belongs to the backend and host app:

- Backend owns governance-sensitive enforcement.
- Host app owns runtime SDK setup.
- Host app owns UI and platform bootstrapping.
- Adapters isolate external systems.
- Sensitive workflows remain fail-closed by default.

## Leakage Risks

Accidental app-owned leakage may occur through:

- Firebase imports in core contracts.
- Router imports in reusable models.
- Generated localization imports in pure Dart contracts.
- Asset path assumptions.
- Parent-path imports to legacy app files.
- Provider SDK imports.
- Platform-specific imports.

## Explicit Non-Action

This map documents ownership only. No runtime ownership was changed.
