# ANDROID_NAMESPACE_WAVE_1_SAFETY_CHECKPOINT_V1

## Purpose

Create a safety checkpoint before Android namespace migration Wave 1.

## Allowed Scope

- Change Android `namespace` from `com.mentalkey.app.flutterprojects` to `com.mentalsmile.os`.
- Keep `applicationId` unchanged.
- Update Kotlin package declaration only for namespace consistency.
- Update manifest activity reference only if required to keep `MainActivity` resolvable.
- Run validation commands.

## Forbidden Scope

- No Android `applicationId` change.
- No Firebase edit.
- No `google-services.json` edit.
- No deploy.
- No push.
- No commit.
- No deletion.
- No archive movement.
- No `mental_smile_clean_core` removal.
- No Google Play action.

## Pre-Change Android Reality

`android/app/build.gradle.kts`:

```kotlin
namespace = "com.mentalkey.app.flutterprojects"
applicationId = "com.mentalkey.app.flutterprojects"
```

`MainActivity.kt`:

```kotlin
package com.mentalkey.app.flutterprojects
```

`AndroidManifest.xml`:

```xml
android:name=".MainActivity"
```

## Intended Change

Namespace target:

```text
com.mentalsmile.os
```

Application ID must remain:

```text
com.mentalkey.app.flutterprojects
```

## Safety Status

Checkpoint Status: CREATED

Rollback Required If Failure: YES

