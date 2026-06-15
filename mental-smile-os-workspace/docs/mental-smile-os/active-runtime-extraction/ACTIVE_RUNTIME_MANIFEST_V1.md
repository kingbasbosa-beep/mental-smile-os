# ACTIVE_RUNTIME_MANIFEST_V1

## Purpose

Identify the real runtime that survives into Generation 1 active production.

## Reality Finding

The current executable runtime host is the Flutter project at:

`C:/mental_smile_workspace/app/mental-smile-app-clean2`

The current active runtime is not yet a separate pure OS runtime root. The current runtime remains the legacy host repository with active Flutter execution, Firebase references, web hosting configuration, Android configuration, assets, localization, routes, and feature modules.

## Runtime Counts

| Area | Reality |
| --- | --- |
| Flutter Dart files under `lib/` | 181 |
| Declared route constants | 81 |
| Asset files under `assets/` | 193 |
| Files under `mental_smile_clean_core/` | 165 |

## Runtime Classification Summary

| Runtime Area | Classification | Notes |
| --- | --- | --- |
| Flutter runtime root | KEEP | Current executable host; remains active until pure runtime extraction exists. |
| `lib/main.dart` and `lib/app/` | KEEP | Active startup, app shell, router, localization provider. |
| `lib/app/router/` | KEEP_WITH_REVIEW | Active route registry and route protection; not pure OS yet. |
| `lib/l10n/` and `l10n.yaml` | KEEP | Active generated localization source and output. |
| `web/` | KEEP | Active web metadata and manifest. |
| `android/` | KEEP_WITH_REVIEW | Active Android runtime; package identity remains legacy technical identity. |
| `firebase.json`, `.firebaserc`, rules files | KEEP_WITH_REVIEW | Active Firebase surface; no deploy performed. |
| `assets/branding/` and approved brand assets | MIGRATE | Active visual assets require card-based migration to pure runtime. |
| `assets/c5`, `assets/c6_library`, `assets/c7_branding` | MIGRATE_WITH_PURIFICATION | Useful asset families but not fully purity-certified as active OS runtime assets. |
| `assets/images`, `assets/icons`, `assets/animations` | UNKNOWN | Must be asset-card audited before migration. |
| `mental_smile_clean_core/` | ARCHIVE_OR_SOURCE_REFERENCE | Active dependency today; must not survive as hidden dependency in pure runtime. |
| `functions/` | MIGRATE_WITH_REVIEW | Active Firebase Functions source exists; analytics summary function requires authority review. |
| `build/`, `.dart_tool/`, `.firebase/`, `node_modules/` | REMOVE_AFTER_ARCHIVE_OR_IGNORE | Generated or dependency output; not source runtime. |
| `_archive/` | ARCHIVE | Historical evidence only. |

## Survival Rule

Generation 1 production may only survive from this runtime after every surviving file is classified as KEEP or MIGRATE and every migration target is carded, owned, and validated.
