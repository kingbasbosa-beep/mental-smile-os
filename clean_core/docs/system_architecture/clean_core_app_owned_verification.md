# Clean Core App-Owned Verification

Draft app-owned exclusion verification.

## App-Owned / Exclude

Must remain host-app owned:

- Firebase initialization.
- Firebase options/config.
- Firestore runtime.
- Auth runtime.
- Cloud Functions runtime.
- Storage runtime.
- Analytics/telemetry runtime.
- Routing/navigation.
- Flutter UI.
- App shell.
- Generated localization.
- Generated config/plugin/router files.
- Assets and asset manifests.
- Platform setup.
- Deployment/store configuration.
- Provider SDK runtime.
- Environment runtime loading.

## Verification Questions

- Does the file render UI?
- Does it import Flutter widgets, `BuildContext`, Navigator, or router?
- Does it initialize Firebase or import generated options?
- Does it depend on generated localization or assets?
- Does it own platform setup or deployment behavior?
- Does it perform provider/runtime execution?

If yes, classify as app-owned or adapter-required, not export-safe.

## Explicit Non-Action

No app-owned file was moved, rewritten, or deleted.
