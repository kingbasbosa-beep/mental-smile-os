# EX-36 Combined Export Verification

Phase: EX-36 - Combined Post-Move Verification

## Barrel Reviewed

Reviewed barrel:

- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

## Audit Exports

The barrel contains eight explicit audit exports:

- `src/audit/audit_actor_type.dart`
- `src/audit/audit_event_type.dart`
- `src/audit/audit_hash_placeholder.dart`
- `src/audit/audit_redaction.dart`
- `src/audit/audit_reference.dart`
- `src/audit/audit_retention_policy.dart`
- `src/audit/audit_severity.dart`
- `src/audit/audit_visibility_scope.dart`

## Human Review Exports

The barrel contains seven explicit human review exports:

- `src/human_review/escalation_audit_link.dart`
- `src/human_review/escalation_level.dart`
- `src/human_review/escalation_policy_reference.dart`
- `src/human_review/escalation_reason.dart`
- `src/human_review/escalation_state.dart`
- `src/human_review/review_priority.dart`
- `src/human_review/review_visibility_scope.dart`

## Export Exclusions Confirmed

The barrel does not export:

- audit runtime markers
- audit event/trace/snapshot runtime-coupled files
- safety observability contracts
- escalation queue files
- escalation boundary marker files
- escalation assignment/request/resolution/review files
- Firestore-coupled surfaces
- directory-level exports
- wildcard exports

## Export Finding

The combined export posture remains explicit file-by-file only and does not expose excluded runtime, queue, boundary, observability, or Firestore-coupled files.

