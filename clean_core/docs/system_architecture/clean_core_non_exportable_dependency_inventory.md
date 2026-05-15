# Clean Core Non-Exportable Dependency Inventory

Draft inventory of dependencies that should not be part of the initial clean_core export surface.

## Never First Export

- Firebase initialization and options.
- Firestore runtime.
- Firebase Auth runtime.
- Cloud Functions runtime.
- Flutter UI pages.
- App shell.
- Router and navigation implementation.
- Generated localization.
- Generated Firebase/plugin/config files.
- Assets and asset manifests.
- Platform setup.
- Deployment/store configuration.
- Analytics and telemetry runtime.
- Provider SDKs and runtime clients.
- Environment runtime loading.

## Export Only Through Contracts Later

- Firebase access.
- Auth identity/session access.
- Routing intents.
- Localization/text resolution.
- Environment/config access.
- Observability bridge.
- Analytics bridge.
- Provider bridge.
- Backend bridge.
- Deployment/release bridge.
- Emulator/test bridge.

## Runtime Leakage Indicators

Treat as a blocker if found in export candidates:

- Direct SDK initialization.
- API keys or secrets.
- Network client construction.
- Firebase app initialization.
- Generated config imports.
- Platform channel assumptions.
- Route table imports.
- UI page imports.
- Runtime activation calls.

## Explicit Non-Action

This inventory does not remove or change dependencies.
