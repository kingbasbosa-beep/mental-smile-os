# clean_core Batch 1 Host App Impact Report

## Host Ownership Status

The host app still owns:

- Firebase initialization/runtime
- Firestore runtime
- Auth runtime
- Cloud Functions runtime
- routing/navigation
- Flutter UI
- generated localization
- generated config
- assets
- platform setup
- provider SDK runtime
- telemetry/analytics runtime
- deployment/release runtime

## Files Adjusted Outside Package Source

Only affected test reconnect files were adjusted:

- `clean_core/test/contracts/backend_boundary_contract_test.dart`
- `clean_core/test/emulator/mock_trusted_operation.dart`

No app feature files were changed for Batch 1 reconnect.

## Host Code Migration Status

App feature code should not be migrated yet.

No movement or import migration should occur for:

- `lib/app/**`
- `lib/features/**`
- `lib/l10n/**`
- `lib/shared/ui_kit/**`
- `lib/main.dart`
- `lib/firebase_options.dart`
- assets
- app-coupled runtime files

## Unresolved Host Considerations

The extracted shell is not yet a full standalone Dart package because no package `pubspec.yaml` exists.

Implications:

- temporary relative test imports are expected
- future host imports should wait for package identity approval
- package-level validation remains deferred until pubspec creation
- app runtime systems remain attached to the host app

## Impact Finding

Host impact is limited and acceptable for Batch 1. The most important remaining constraint is to avoid pulling host runtime systems into `mental_smile_clean_core` during later reconnect phases.
