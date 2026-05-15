# Clean Core Future Pubspec Strategy

Draft pubspec strategy for future extraction. No pubspec was created or changed.

## Stage 1 Dependency Principle

The initial extracted package should avoid runtime dependencies and remain pure Dart where possible.

## Preferred Stage 1 Dependencies

Prefer:

- Dart SDK only.
- `lints` or similar dev-only lint package if needed later.
- Pure Dart test dependencies only after package tests are created.

Avoid:

- Flutter SDK dependency.
- Firebase dependencies.
- Provider SDKs.
- HTTP/networking libraries.
- Generated localization tooling.
- Asset generation tooling.
- Platform-specific dependencies.

## Package Metadata Later

Future pubspec should define:

- Package name.
- Description.
- SDK constraints.
- Dev dependencies for pure tests.
- No assets in Stage 1.
- No Flutter plugin configuration.

## Current Dependency Cautions

Current clean_core contains app-level dependencies and assets in its existing `pubspec.yaml`. That file should not be copied directly into the Stage 1 extracted package without pruning.

Blocked from Stage 1 pubspec:

- `firebase_core`
- `cloud_firestore`
- `firebase_auth`
- Flutter UI dependencies.
- Asset declarations.
- Generated localization setup.
- Provider SDKs.
- Networking libraries.

## Explicit Non-Action

No package identity or pubspec was changed.
