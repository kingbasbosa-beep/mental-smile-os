# ANDROID_NAMESPACE_EXECUTION_SEQUENCE_V1

## Purpose

Define exact Android namespace migration sequence.

## Target Namespace

Current: `com.mentalkey.app.flutterprojects`.

Target: `com.mentalsmile.os`.

## Execution Sequence

1. Confirm package rename sequence is validated or explicitly deferred.
2. Edit `android/app/build.gradle.kts`.
3. Replace:
   - `namespace = "com.mentalkey.app.flutterprojects"`
   - with `namespace = "com.mentalsmile.os"`
4. Do not change `applicationId` unless Owner explicitly chooses `CHANGE_TO_COM_MENTALSMILE_OS`.
5. Move Kotlin file path:
   - From `android/app/src/main/kotlin/com/mentalkey/app/flutterprojects/`
   - To `android/app/src/main/kotlin/com/mentalsmile/os/`
6. Edit `MainActivity.kt`.
7. Replace:
   - `package com.mentalkey.app.flutterprojects`
   - with `package com.mentalsmile.os`
8. Run `flutter pub get`.
9. Run `flutter analyze`.
10. Run `flutter build apk --debug`.
11. Review diff.

## Application ID Guardrail

Recommended decision remains:

`DEFER_UNTIL_STORE_READY`.

## Validation Points

- Android namespace is `com.mentalsmile.os`.
- Kotlin package is `com.mentalsmile.os`.
- Debug APK builds.
- `applicationId` remains unchanged unless Owner explicitly approved change.

## Stop Condition

Stop before commit, push, deploy, or Play Store action.
