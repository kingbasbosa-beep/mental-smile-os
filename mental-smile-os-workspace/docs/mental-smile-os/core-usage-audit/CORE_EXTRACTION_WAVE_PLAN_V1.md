# CORE_EXTRACTION_WAVE_PLAN_V1

## Purpose

Define the safest extraction wave plan for `mental_smile_clean_core`.

## Wave 1 - Test Import Replacement

Scope:

- Replace `test/mental_smile_clean_core_import_test.dart` with an OS-owned test.
- Do not remove dependency yet if Owner wants a two-step validation.

Validation:

```powershell
flutter pub get
flutter analyze
flutter build apk --debug
flutter build web
```

## Wave 2 - Dependency Removal

Scope:

- Remove `mental_smile_clean_core` from `pubspec.yaml`.
- Run `flutter pub get` to update `pubspec.lock`.
- Confirm no `package:mental_smile_clean_core` imports remain.

Validation:

```powershell
flutter pub get
flutter analyze
flutter build apk --debug
flutter build web
```

## Wave 3 - Source Repository Reference Decision

Scope:

- Decide whether Construction Workbench should keep the local source path.
- If archive policy is approved, retarget source link before moving or archiving folder.

Forbidden in Wave 1 and Wave 2:

- No folder deletion.
- No archive movement.
- No Firebase edit.
- No deploy.
- No push.
- No commit without Owner approval.

## Recommended Next Wave

Attempt Wave 1 extraction safely by replacing the proof test with an OS-owned test.

