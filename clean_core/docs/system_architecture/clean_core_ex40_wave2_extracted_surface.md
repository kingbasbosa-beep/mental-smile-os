# EX-40 Wave 2 Extracted Surface

Phase: EX-40 - Wave 2 Safe Extraction Milestone Report

## Audit Safe Batch A1

Moved to `mental_smile_clean_core/lib/src/audit/`:

- `audit_actor_type.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_severity.dart`
- `audit_visibility_scope.dart`

## Human Review Safe Batch A2

Moved to `mental_smile_clean_core/lib/src/human_review/`:

- `escalation_audit_link.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

## Extracted Surface Classification

The extracted Wave 2 files are:

- pure Dart
- declarative-only
- non-executing
- label/reference oriented
- explicit-export only
- not Firebase-coupled
- not provider-coupled
- not runtime-coupled

## Public Export Status

The moved files are exposed only through explicit file-by-file exports in the root package barrel.

No hidden adjacent files were exported.

