# TECHNICAL_IDENTITY_AUDIT_V1

## Purpose

Audit every visible technical identity still connected to legacy runtime naming.

## Identity Matrix

| Identity | Exact Locations | Classification | Notes |
| --- | --- | --- | --- |
| `flutterprojects` | `pubspec.yaml`, 74 Dart import files, Windows project files | RENAME | Active package namespace. |
| `mental_smile_clean_core` | `pubspec.yaml`, `test/mental_smile_clean_core_import_test.dart`, folder `mental_smile_clean_core/` | REPLACE | Active local dependency. |
| `com.mentalkey.app.flutterprojects` | `android/app/build.gradle.kts`, `MainActivity.kt` path/package | RENAME | Active Android namespace/applicationId. |
| `com.mentalkey.app` | `windows/runner/Runner.rc` | RENAME | Windows metadata residue. |
| `Mental Smile Core Source Repository` | OS runtime shell and construction workbench docs | KEEP | Acceptable source repository reference only. |
| `mental-smile-app-clean2` | OS workbench paths and active host declarations | KEEP_TEMPORARY_TECHNICAL_PATH | Host repository path; not product identity. |
| `legacy` comments/keys | Selected runtime comments and keys | KEEP_WITH_REVIEW | Some are intentional compatibility labels. |
| `clean2` in signal bootstrap report | `mental-smile-os-runtime/signal-routing/...` | KEEP_AS_AUDIT_LANGUAGE | States no clean2 import occurred. |

## Summary

The active runtime still carries legacy technical identity in package name, imports, Android namespace, and Windows metadata.

Product branding is mostly Mental Smile, but technical identity is not clean.
