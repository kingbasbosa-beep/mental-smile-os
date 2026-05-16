# EX-38 Tests Reconnect Import Plan

Phase: EX-38 - Tests-Only Scoped Reconnect Authorization

## Import Rule

If future tests-only reconnect is ever required for moved Wave 2 safe-batch contracts, tests must import only:

```dart
import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';
```

Tests must not import from:

- `mental_smile_clean_core/lib/src/...`
- old `clean_core/lib/core/audit/...` moved file paths
- old `clean_core/lib/core/human_review/...` moved file paths

## Current Import Plan

No import reconnect is required for Wave 2 moved audit/human-review safe-batch contracts because no current test references those contracts.

## Existing Test Imports

The existing temporary relative imports in backend-boundary tests are outside this Wave 2 tests-only reconnect scope and should not be changed under EX-38.

## Import Plan Verdict

No test import changes are recommended for EX-38.

