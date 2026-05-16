# clean_core Reconnect Rollback Checkpoint

This checkpoint records rollback expectations for the EX-23 scoped import reconnect.

## Rollback Scope

Rollback is limited to two import lines:

- `clean_core/test/contracts/backend_boundary_contract_test.dart`
- `clean_core/test/emulator/mock_trusted_operation.dart`

## Rollback Action

To return to the pre-EX-23 state, restore the temporary relative import:

```dart
import '../../../mental_smile_clean_core/lib/mental_smile_clean_core.dart';
```

## No Additional Restoration Required

No other restoration is required because EX-23 did not change:

- host feature files
- package source files
- package barrel
- host runtime wiring
- Firebase/routing/localization/assets
- adapter/runtime/provider systems

## Checkpoint Verdict

Rollback remains trivial and isolated. The reconnect does not increase runtime or provider activation risk.
