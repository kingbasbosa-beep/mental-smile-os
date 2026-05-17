# EX-111 Barrel Export Verification

## Barrel Inspected

`mental_smile_clean_core/lib/mental_smile_clean_core.dart`

## Export Finding

The barrel contains one explicit passive vocabulary export:

```dart
export 'src/human_review/passive_review_signal.dart';
```

## No Wildcard/Directory Export

No wildcard or directory export was added for human-review passive vocabulary.

## Not Exported

The following files are not directly exported:

- `src/human_review/queue_passive_label.dart`
- `src/human_review/boundary_passive_label.dart`
- `src/human_review/emergency_posture_label.dart`
- `src/human_review/provider_issue_label.dart`
- `src/human_review/fallback_observation_label.dart`

## Reference Findings

Reference search found:

- `PassiveReviewSignal` in the exported file.
- `passive_review_signal.dart` in the package barrel.
- internal passive enum declarations in their own files.

No consumer references were introduced.

## Barrel Verdict

Pass. The export is narrow, explicit, and limited to `passive_review_signal.dart`.
