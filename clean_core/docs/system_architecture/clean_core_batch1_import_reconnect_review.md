# clean_core Batch 1 Import Reconnect Review

## Reviewed Reconnect Files

- `clean_core/test/contracts/backend_boundary_contract_test.dart`
- `clean_core/test/emulator/mock_trusted_operation.dart`

## Reconnect Status

The limited reconnect changed only the affected test imports that referenced the old Batch 1 app package paths.

Current reconnect import:

```dart
import '../../../mental_smile_clean_core/lib/mental_smile_clean_core.dart';
```

## Scope Finding

Confirmed:

- no broad test migration occurred
- no app feature code was migrated
- no app-owned runtime files were touched
- no Firebase/runtime/provider code was introduced
- no Batch 2 imports were changed

## Temporary Import Note

The current relative import is acceptable only as a short-term reconnect because the extracted shell does not yet have a standalone `pubspec.yaml`.

Later, after package identity is created and approved, these should become package imports, likely:

```dart
import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';
```

That future change should be done in a controlled reconnect phase, not as a broad rewrite.

## Old Path Review

No remaining code references were found in the reviewed scope to:

- `package:flutterprojects/core/backend_boundaries/...`
- `package:flutterprojects/core/safety_decision/...`
- old `core/backend_boundaries` imports
- old `core/safety_decision` imports

Remaining path mentions are documentation references or the intended new package shell references.

## Reconnect Finding

Reconnect is scoped and acceptable for Batch 1 checkpoint purposes. It remains transitional until the package receives a real pubspec/package identity.
