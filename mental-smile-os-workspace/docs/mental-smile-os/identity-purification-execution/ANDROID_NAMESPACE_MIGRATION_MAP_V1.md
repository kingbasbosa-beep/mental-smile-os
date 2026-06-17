# ANDROID_NAMESPACE_MIGRATION_MAP_V1

## Purpose

Map Android namespace cleanup.

## Recommended Target Namespace

`com.mentalsmile.os`

## Namespace Map

| File / Path | Current | Target | Action |
| --- | --- | --- | --- |
| `android/app/build.gradle.kts:33` | `namespace = "com.mentalkey.app.flutterprojects"` | `namespace = "com.mentalsmile.os"` | RENAME |
| `android/app/src/main/kotlin/com/mentalkey/app/flutterprojects/MainActivity.kt:1` | `package com.mentalkey.app.flutterprojects` | `package com.mentalsmile.os` | RENAME |
| Kotlin file path | `android/app/src/main/kotlin/com/mentalkey/app/flutterprojects/` | `android/app/src/main/kotlin/com/mentalsmile/os/` | MOVE_WITH_REVIEW |

## Guardrail

Namespace migration may be done before applicationId migration.

Do not change `applicationId` in the same patch unless Owner explicitly chooses `CHANGE_TO_COM_MENTALSMILE_OS`.

## Validation

```powershell
flutter pub get
flutter analyze
flutter build apk --debug
```

## Risk

Risk Level: MEDIUM_HIGH.
