# FINAL_ACTIVATION_WARNING_REGISTRY_V1

## Purpose

Consolidate all remaining activation warnings.

## Firebase Warnings

- GitHub Actions may deploy from `ai-lab` when configured events run.
- `firebase.json` project mapping still references `mental-smile-app-clean`.
- `.firebaserc` default project is `mental-smile-app-clean`.
- Firestore has duplicate `isMonitoringOperator()` helper.
- Storage clinician/center helpers still include Firestore role-document fallback.
- Functions write `analytics_summaries`.
- Approved collection naming alignment remains incomplete.
- Deny-all fallback rules exist and must remain.

## Runtime Warnings

- `flutterprojects` package name remains.
- 74 files contain `package:flutterprojects` imports.
- `mental_smile_clean_core` dependency remains.
- Android namespace remains `com.mentalkey.app.flutterprojects`.
- Workbench owner route requires final owner claim validation.
- `mental-smile-os-runtime/signal-routing` is untracked doctrine/planning output.
- Runtime smoke validation not yet executed.
- Route smoke validation not yet executed.
- Owner route validation not yet executed.
- Monitoring route validation not yet executed.

## YAML Warnings

- Asset declarations are broad.
- Old asset paths may remain.
- Duplicate asset paths may remain.
- Localization residue requires final scan.
- Session, booking, admin semantic residue requires final scan.
- `pubspec.yaml` identity remains `flutterprojects`.
- Font and theme references require final validation.

## Release Warnings

- Git status is not clean.
- `.firebase` cache is untracked and should not be released accidentally.
- Forensic audit docs need include/exclude decision.
- Signal-routing docs need include/exclude decision.
- GitHub release branch decision remains.
- Tag decision remains.
- Hosting deploy confirmation remains required.
- Google Play publish remains forbidden unless explicitly authorized.
