# EX-38 Tests Reconnect Stop Conditions

Phase: EX-38 - Tests-Only Scoped Reconnect Authorization

## Mandatory Stop Conditions

Future tests-only reconnect must stop if it would:

- modify host app feature files
- modify Firebase/provider/runtime files
- modify package exports
- modify moved package source files
- move files
- add dependencies
- run pub commands
- run analyze
- activate runtime
- create adapters
- touch observability files
- touch queue files
- touch runtime-sensitive files
- import from `lib/src`
- perform broad migration
- change non-Wave-2 test imports without separate approval

## Import Stop Conditions

Stop if a proposed test reconnect uses anything other than:

```dart
import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';
```

## Scope Stop Conditions

Stop if reconnect would include:

- backend-boundary tests from earlier phases without explicit approval
- emulator/runtime tests outside the moved audit/human-review contract scope
- host integration tests
- Firebase emulator tests
- provider/runtime tests

## Stop Condition Verdict

Because no affected tests were found, EX-38 should remain a no-op authorization phase.

