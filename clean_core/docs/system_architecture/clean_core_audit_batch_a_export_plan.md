# clean_core Audit Batch A Export Plan

This plan defines future export guidance for Audit Lane Candidate Batch A. No exports were changed in EX-27.

## Future Public Export Candidates

If a future movement phase is approved, these files may be added to the package root barrel explicitly:

- `src/audit/audit_actor_type.dart`
- `src/audit/audit_event_type.dart`
- `src/audit/audit_hash_placeholder.dart`
- `src/audit/audit_redaction.dart`
- `src/audit/audit_reference.dart`
- `src/audit/audit_retention_policy.dart`
- `src/audit/audit_severity.dart`
- `src/audit/audit_visibility_scope.dart`

## Export Rules

- Export file-by-file only.
- Do not export `src/audit/` broadly.
- Do not export Firestore-coupled files.
- Do not export runtime marker or observability bridge files in Batch A.
- Document event/actor/visibility labels as declarative contract vocabulary only.

## Deferred Export Areas

Deferred:

- runtime marker export
- safety observability contract export
- event/trace/snapshot models with Firestore mapping
- audit persistence adapters
- backend audit runtime

## Export Plan Verdict

Batch A is export-safe as declarative vocabulary and redaction/reference contracts only.
