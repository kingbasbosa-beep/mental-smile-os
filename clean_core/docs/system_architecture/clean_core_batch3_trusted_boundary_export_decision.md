# clean_core Batch 3 Trusted Boundary Export Decision

## Export Strategy

Trusted backend and trusted pipeline may move as complete directories, but root barrel exports should remain conservative and file-by-file.

## Trusted Backend Export-Safe Candidates

Export-safe after movement:

- `trusted_backend_audit_link.dart`
- `trusted_backend_block_reason.dart`
- `trusted_backend_fallback.dart`
- `trusted_backend_reference.dart`
- `trusted_backend_request.dart`
- `trusted_backend_requirement.dart`
- `trusted_backend_response.dart`
- `trusted_backend_runtime_marker.dart`
- `trusted_backend_state.dart`
- `trusted_backend_visibility_scope.dart`

Reason:

- These files define request/response/reference/state/fallback/marker contracts.
- They do not execute backend calls, provider calls, Firebase writes, networking, or runtime activation.

## Trusted Backend Review-Required Exports

Keep hidden or review-required:

- `trusted_backend_boundary.dart`
- `trusted_backend_guard.dart`
- `trusted_backend_policy.dart`

Reason:

- They define boundary/policy/evaluation semantics.
- Public exposure could be misread as local trusted authority.

## Trusted Pipeline Export-Safe Candidates

Export-safe after movement:

- `trusted_pipeline_audit_link.dart`
- `trusted_pipeline_block_reason.dart`
- `trusted_pipeline_fallback.dart`
- `trusted_pipeline_reference.dart`
- `trusted_pipeline_request.dart`
- `trusted_pipeline_result.dart`
- `trusted_pipeline_review_marker.dart`
- `trusted_pipeline_runtime_marker.dart`
- `trusted_pipeline_stage.dart`
- `trusted_pipeline_state.dart`
- `trusted_pipeline_visibility_scope.dart`

Reason:

- These files define request/result/state/stage/reference/fallback/marker contracts.
- They do not perform orchestration or provider/runtime execution.

## Trusted Pipeline Review-Required Exports

Keep hidden or review-required:

- `trusted_pipeline.dart`
- `trusted_pipeline_guard.dart`
- `trusted_pipeline_policy.dart`

Reason:

- They contain evaluation and policy semantics.
- `TrustedPipeline.check` returns an `allowed` result and should not become public authority until reviewed.

## Broad Export Risk

Do not export either directory broadly.

Required future barrel rule:

- add explicit file-by-file exports only
- keep evaluation/policy/guard/boundary files hidden by default
- do not export runtime-like APIs as public authority

## Export Decision Verdict

Move-ready as directories. Public-export-ready only for stable declarative contracts. Evaluation and policy surfaces require later semantic export approval.
