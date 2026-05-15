# Clean Core Extraction Import Scan Results

Manual import/dependency scan for future clean_core extraction. No package extraction, file movement, import rewrite, runtime activation, Flutter validation command, Firebase setup, or provider execution was performed.

## Scan Scope

Target: `clean_core`

The scan reviewed imports and dependency indicators for:

- Parent-path imports.
- `../lib` imports.
- Legacy package imports.
- Flutter UI imports.
- `BuildContext`, Navigator, router imports.
- Firebase imports/options/config.
- Generated localization/config/router/assets imports.
- Provider SDK imports.
- Networking imports.
- Runtime activation/execution indicators.
- Cloud Functions/runtime coupling.
- App-owned UI/platform coupling.

## Summary Findings

- The repository contains a large pure-Dart contract surface under `lib/core/*` that is suitable for Stage 1 consideration after targeted review.
- Several contract-looking files are blocked from Stage 1 because they import `cloud_firestore`.
- App shell files, feature UI pages, generated localization, assets, Firebase options, router, and platform/runtime files are app-owned exclusions.
- Existing tests use `package:flutterprojects/...` and `package:flutter_test/...`, so they are not clean extracted-package tests yet.
- No broad parent-path import escaping clean_core was identified in core source during this scan, but tests include relative fixture imports that should be reviewed before extraction.

## Concrete Import Findings

### Firebase/Firestore Coupling

Files with direct `cloud_firestore` imports:

- `lib/core/ai_safety/ai_safety_event.dart`
- `lib/core/ai_safety/ai_safety_incident.dart`
- `lib/core/ai_safety/ai_safety_policy_snapshot.dart`
- `lib/core/ai_safety/ai_safety_trace.dart`
- `lib/core/audit/audit_event.dart`
- `lib/core/audit/audit_snapshot.dart`
- `lib/core/audit/audit_trace.dart`
- `lib/core/human_review/escalation_assignment.dart`
- `lib/core/human_review/escalation_request.dart`
- `lib/core/human_review/escalation_resolution.dart`
- `lib/core/human_review/escalation_review.dart`
- `lib/core/legal/legal_consent_record.dart`
- `lib/core/legal/legal_consent_service.dart`

These should be blocked from Stage 1 pure-contract extraction until Firestore timestamp/reference types are abstracted or classified as adapter-bound.

### Firebase/Auth/App Coupling

Blocked file:

- `lib/core/auth/account_access_service.dart`

Reasons:

- Imports `cloud_firestore`.
- Imports `firebase_auth`.
- Imports Flutter foundation.
- Imports `package:flutterprojects/shared/contracts/role_names.dart`.

### Firebase Options/App Startup Coupling

Blocked files:

- `lib/main.dart`
- `lib/firebase_options.dart`

Reasons:

- Firebase initialization.
- Generated Firebase options.
- Flutter app startup.

### Routing/App Shell Coupling

Blocked files:

- `lib/app/app.dart`
- `lib/app/router/app_router.dart`
- `lib/app/router/routes.dart`
- `lib/app/locale_provider.dart`

Reasons:

- Flutter app shell.
- Router/navigation.
- Generated localization usage.
- Feature page imports.
- Firebase Auth in router.

### Localization/Generated Coupling

Blocked or app-owned files:

- `lib/l10n/app_localizations.dart`
- `lib/l10n/app_localizations_ar.dart`
- `lib/l10n/app_localizations_en.dart`
- `lib/l10n/app_ar.arb`
- `lib/l10n/app_en.arb`
- `l10n.yaml`

Reasons:

- Generated localization output and app localization ownership.

### Asset/UI Coupling

Blocked or app-owned areas:

- `assets/**`
- `lib/shared/ui_kit/**`
- `lib/features/**/presentation/**`

Reasons:

- Flutter UI.
- Asset paths.
- BuildContext/UI rendering.
- Navigation and app-shell assumptions.

### Test Package Coupling

Needs review:

- `test/contracts/legal_consent_contract_test.dart`
- `test/contracts/backend_boundary_contract_test.dart`
- `test/contracts/ai_safety_contract_test.dart`
- `test/emulator/mock_trusted_operation.dart`

Reasons:

- Use `package:flutterprojects/...` imports.
- Use Flutter test package.
- Some tests use relative fixture imports.

## Status

Final extraction should not begin until Stage 1 candidates are manually confirmed to contain only Dart SDK and sibling clean_core contract imports.
