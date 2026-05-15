# Clean Core Extraction Blocked Files

Draft blocked file inventory from manual scan. No files were moved or modified.

## Blocked From Stage 1: Firebase/Firestore Coupled

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

Reason: direct `cloud_firestore` import.

## Blocked From Stage 1: Auth/Firebase/App Package Coupled

- `lib/core/auth/account_access_service.dart`

Reason: direct `cloud_firestore`, `firebase_auth`, Flutter foundation, and `package:flutterprojects/...` import.

## Blocked From Stage 1: App Startup/Firebase Options

- `lib/main.dart`
- `lib/firebase_options.dart`

Reason: app startup and generated Firebase config.

## Blocked From Stage 1: App Shell/Router

- `lib/app/app.dart`
- `lib/app/router/app_router.dart`
- `lib/app/router/routes.dart`
- `lib/app/locale_provider.dart`

Reason: Flutter app shell, routing/navigation, generated localization, app package imports, and Firebase Auth coupling.

## Blocked From Stage 1: Localization/Generated

- `lib/l10n/**`
- `l10n.yaml`

Reason: generated localization and app-owned localization setup.

## Blocked From Stage 1: UI/Assets/Features

- `lib/features/**/presentation/**`
- `lib/shared/ui_kit/**`
- `assets/**`

Reason: Flutter UI, BuildContext/rendering, asset paths, and app-owned feature behavior.

## Blocked From Stage 1: Current Tests

- `test/contracts/**`
- `test/emulator/**`

Reason: current tests import `package:flutterprojects/...`, use Flutter test tooling, and are not yet extracted-package import clean.

## Stop Condition

If any blocked file is included in Stage 1 extraction without adapter abstraction or explicit host ownership, extraction should stop for review.
