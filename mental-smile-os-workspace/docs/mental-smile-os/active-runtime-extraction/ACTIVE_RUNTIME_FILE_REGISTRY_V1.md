# ACTIVE_RUNTIME_FILE_REGISTRY_V1

## Purpose

Register the major active runtime file families discovered in the host repository.

## File Registry

| Path | Runtime Role | Classification | Risk |
| --- | --- | --- | --- |
| `lib/main.dart` | Flutter startup and Firebase initialization | KEEP | MEDIUM |
| `lib/app/app.dart` | Material app shell | KEEP | LOW |
| `lib/app/router/routes.dart` | Route constants | KEEP_WITH_REVIEW | MEDIUM |
| `lib/app/router/app_router.dart` | Route binding and role gate | KEEP_WITH_REVIEW | HIGH |
| `lib/firebase_options.dart` | Firebase project config | KEEP_WITH_REVIEW | HIGH |
| `lib/l10n/app_ar.arb` | Arabic localization source | KEEP | MEDIUM |
| `lib/l10n/app_en.arb` | English localization source | KEEP | MEDIUM |
| `lib/l10n/app_localizations*.dart` | Generated localization | KEEP_GENERATED | LOW |
| `pubspec.yaml` | Package, dependencies, assets | KEEP_WITH_REVIEW | HIGH |
| `firebase.json` | Firebase hosting, rules, functions map | KEEP_WITH_REVIEW | HIGH |
| `.firebaserc` | Firebase project alias | KEEP_WITH_REVIEW | HIGH |
| `firestore.rules` | Firestore authority rules | KEEP_WITH_REVIEW | HIGH |
| `storage.rules` | Storage authority rules | KEEP_WITH_REVIEW | MEDIUM |
| `firestore.indexes.json` | Firestore indexes | KEEP_WITH_REVIEW | MEDIUM |
| `functions/index.js` | Cloud Functions analytics summary | MIGRATE_WITH_REVIEW | HIGH |
| `android/` | Android runtime host | KEEP_WITH_REVIEW | HIGH |
| `web/` | Web runtime shell metadata | KEEP | MEDIUM |
| `assets/` | Visual runtime assets | MIGRATE_WITH_PURIFICATION | HIGH |
| `mental_smile_clean_core/` | Local package dependency | ARCHIVE_OR_SOURCE_REFERENCE | HIGH |
| `test/` | Tests and fixtures | MIGRATE_WITH_REVIEW | MEDIUM |
| `docs/` | Legacy/core docs | ARCHIVE_OR_SOURCE_REFERENCE | MEDIUM |
| `mental-smile-os-workspace/` | OS documentation root | KEEP_AS_OS_DOCS | LOW |
| `mental-smile-os-runtime/` | Signal routing bootstrap docs | KEEP_AS_OS_RUNTIME_PLANNING | MEDIUM |
| `build/` | Generated build output | REMOVE_AFTER_ARCHIVE_OR_IGNORE | LOW |
| `.dart_tool/` | Generated Flutter tooling | REMOVE_AFTER_ARCHIVE_OR_IGNORE | LOW |
| `.firebase/` | Firebase generated cache | REMOVE_AFTER_ARCHIVE_OR_IGNORE | MEDIUM |
| `node_modules/` | Dependency output | REMOVE_AFTER_ARCHIVE_OR_IGNORE | LOW |
| `_archive/` | Historical archive | ARCHIVE | LOW |

## Note

This registry is a major-family extraction registry, not a line-by-line file manifest.
