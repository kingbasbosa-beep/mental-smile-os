# DART_IMPORT_RENAME_MAP_V1

## Purpose

Map Dart import replacement required after package rename.

## Replacement

From:

`package:flutterprojects/`

To:

`package:mental_smile_os/`

## Scope

74 Dart files were identified in STEP 047 as containing `package:flutterprojects`.

## Execution Method

Use a controlled text replacement over active Dart source and tests only.

Exclude:

- `_archive/`
- generated build output
- `.dart_tool/`
- `.firebase/`
- `node_modules/`
- historical docs unless explicitly needed

## Validation

After replacement:

```powershell
flutter pub get
flutter analyze
flutter test
flutter build web
```

## Risk

Primary risk is partial import rename causing analyzer failures.
