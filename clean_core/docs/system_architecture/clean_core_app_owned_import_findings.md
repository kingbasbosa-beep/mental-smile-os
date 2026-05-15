# Clean Core App-Owned Import Findings

Draft app-owned import findings from manual scan.

## App-Owned Import Categories Found

### Firebase Runtime

Found in:

- `lib/main.dart`
- `lib/firebase_options.dart`
- `lib/core/auth/account_access_service.dart`
- Several `lib/core/*` persistence-like models using `cloud_firestore`.

Classification:

- App-owned or adapter-only later.
- Not Stage 1 pure contract export.

### Flutter UI / App Shell

Found in:

- `lib/app/**`
- `lib/features/**/presentation/**`
- `lib/shared/ui_kit/**`
- `lib/l10n/app_localizations.dart`

Classification:

- App-owned exclude.

### Routing / Navigator / BuildContext

Found in:

- `lib/app/router/**`
- `lib/shared/ui_kit/app_shell_actions.dart`
- UI feature pages.

Classification:

- App-owned exclude; route-intent adapter only later.

### Generated Localization

Found in:

- `lib/l10n/**`
- app and feature UI files using `AppLocalizations`.

Classification:

- App-owned exclude; text adapter only later.

### Assets

Found in:

- `assets/**`
- UI kit and feature UI.
- `pubspec.yaml` asset declarations.

Classification:

- App-owned exclude; asset-intent adapter only later.

### Legacy Package Identity

Found in:

- App and feature imports using `package:flutterprojects/...`.
- Test imports using `package:flutterprojects/...`.

Classification:

- Needs manual review or blocked until future package identity is defined.

## No Runtime Activation Confirmation

The scan did not identify implemented provider SDK execution or live AI provider calls in Stage 1 candidate directories. Provider names such as `open_ai` and `gemini` appear as blocked/restricted provider identifiers in governance contracts, not SDK integrations.

## App-Owned Conclusion

App shell, Firebase setup, routing, localization generation, assets, UI, generated files, and current integration tests should remain host-app owned for extraction Stage 1.
