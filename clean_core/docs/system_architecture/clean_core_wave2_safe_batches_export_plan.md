# clean_core Wave 2 Safe Batches Export Plan

This document simulates future root barrel additions. No barrel was modified.

## Audit Safe Batch Exports

```dart
export 'src/audit/audit_actor_type.dart';
export 'src/audit/audit_event_type.dart';
export 'src/audit/audit_hash_placeholder.dart';
export 'src/audit/audit_redaction.dart';
export 'src/audit/audit_reference.dart';
export 'src/audit/audit_retention_policy.dart';
export 'src/audit/audit_severity.dart';
export 'src/audit/audit_visibility_scope.dart';
```

## Human Review Safe Batch Exports

```dart
export 'src/human_review/escalation_audit_link.dart';
export 'src/human_review/escalation_level.dart';
export 'src/human_review/escalation_policy_reference.dart';
export 'src/human_review/escalation_reason.dart';
export 'src/human_review/escalation_state.dart';
export 'src/human_review/review_priority.dart';
export 'src/human_review/review_visibility_scope.dart';
```

## Export Rules

- Explicit file-by-file exports only.
- No directory-wide exports.
- No wildcard exports.
- No Firestore-coupled exports.
- No runtime marker exports.
- No queue/boundary marker exports.
- No adapter-boundary exports.

## Export Plan Verdict

Exports should be added in two groups, immediately after each movement batch and before the next movement batch.
