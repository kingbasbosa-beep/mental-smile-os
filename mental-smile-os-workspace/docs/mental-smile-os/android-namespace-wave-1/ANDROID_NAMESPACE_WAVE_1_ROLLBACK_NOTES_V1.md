# ANDROID_NAMESPACE_WAVE_1_ROLLBACK_NOTES_V1

## Purpose

Document how to roll back Android Namespace Migration Wave 1 if manual validation fails.

## Rollback Scope

Rollback only covers:

- Android namespace in `android/app/build.gradle.kts`
- Kotlin package declaration in `MainActivity.kt`
- Manifest activity reference in `AndroidManifest.xml`

Rollback does not cover applicationId, Firebase, `google-services.json`, package name, or `mental_smile_clean_core`, because Wave 1 did not change them.

## Rollback Order

1. Revert manifest activity reference:

```xml
android:name="com.mentalsmile.os.MainActivity"
```

Back to:

```xml
android:name=".MainActivity"
```

2. Revert Kotlin package declaration:

```kotlin
package com.mentalsmile.os
```

Back to:

```kotlin
package com.mentalkey.app.flutterprojects
```

3. Revert Gradle namespace:

```kotlin
namespace = "com.mentalsmile.os"
```

Back to:

```kotlin
namespace = "com.mentalkey.app.flutterprojects"
```

4. Run owner-side validation:

```powershell
flutter pub get
flutter analyze
flutter build apk --debug
```

## Recommended Rollback Method

Use a reviewed reverse patch.

Do not use destructive repository reset unless Owner explicitly approves it.

## Rollback Safety Rules

- Do not change `applicationId`.
- Do not edit Firebase config.
- Do not edit `google-services.json`.
- Do not remove `mental_smile_clean_core`.
- Do not deploy.
- Do not push.
- Do not delete files.

## Rollback Decision

Rollback is only needed if manual Android validation shows namespace migration causes a blocking build failure that cannot be fixed within Wave 1 scope.

