# clean_core Human Review Safe Batch Export Plan

This plan defines future export guidance for the Human Review Safe Batch. No exports were changed in EX-30.

## Future Public Export Candidates

If a future movement phase is approved, these files may be added to the package root barrel explicitly:

- `src/human_review/escalation_audit_link.dart`
- `src/human_review/escalation_level.dart`
- `src/human_review/escalation_policy_reference.dart`
- `src/human_review/escalation_reason.dart`
- `src/human_review/escalation_state.dart`
- `src/human_review/review_priority.dart`
- `src/human_review/review_visibility_scope.dart`

## Export Rules

- Export file-by-file only.
- Do not export `src/human_review/` broadly.
- Do not export Firestore-coupled files.
- Do not export `escalation_queue.dart`.
- Do not export `escalation_boundary_marker.dart` in this batch.
- Document escalation/provider/backend terms as declarative labels only.

## Deferred Export Areas

Deferred:

- boundary marker export
- queue/evaluation export
- assignment/review/resolution/request persistence models
- human-review runtime bridges
- notification/messaging integrations

## Export Plan Verdict

The safe batch is export-safe as declarative escalation/review vocabulary and references only.
