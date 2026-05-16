# clean_core Batch 4 Governance Export Decision

## Export Strategy

Batch 4 may move as complete directories, but root barrel exports should be conservative and file-by-file.

## Governance Kernel Export-Safe Candidates

Export-safe after movement:

- `governance_kernel_audit_link.dart`
- `governance_kernel_block_reason.dart`
- `governance_kernel_fallback.dart`
- `governance_kernel_reference.dart`
- `governance_kernel_request.dart`
- `governance_kernel_review_marker.dart`
- `governance_kernel_runtime_marker.dart`
- `governance_kernel_scope.dart`
- `governance_kernel_state.dart`
- `governance_kernel_visibility_scope.dart`

Keep hidden or review-required:

- `governance_kernel.dart`
- `governance_kernel_boundary.dart`
- `governance_kernel_guard.dart`
- `governance_kernel_policy.dart`

## Governance Lifecycle Export-Safe Candidates

Export-safe after movement:

- `governance_lifecycle_audit_link.dart`
- `governance_lifecycle_block_reason.dart`
- `governance_lifecycle_fallback.dart`
- `governance_lifecycle_review_marker.dart`
- `governance_lifecycle_runtime_marker.dart`
- `governance_lifecycle_scope.dart`
- `governance_lifecycle_state.dart`
- `governance_lifecycle_transition.dart`
- `governance_lifecycle_visibility_scope.dart`

Keep hidden or review-required:

- `governance_lifecycle.dart`
- `governance_lifecycle_guard.dart`
- `governance_lifecycle_lock.dart`
- `governance_lifecycle_policy.dart`

## Governance Compliance Export-Safe Candidates

Export-safe after movement:

- `governance_compliance_audit_link.dart`
- `governance_compliance_block_reason.dart`
- `governance_compliance_fallback.dart`
- `governance_compliance_marker.dart`
- `governance_compliance_reference.dart`
- `governance_compliance_requirement.dart`
- `governance_compliance_review_marker.dart`
- `governance_compliance_scope.dart`
- `governance_compliance_state.dart`
- `governance_compliance_visibility_scope.dart`

Keep hidden or review-required:

- `governance_compliance_guard.dart`
- `governance_compliance_policy.dart`
- `governance_compliance_profile.dart`

## Broad Export Risk

Do not export governance directories broadly.

Required future barrel rule:

- add explicit file-by-file exports only
- keep evaluation/policy/guard/boundary/lock/profile files hidden by default
- do not expose any governance check as runtime authority

## Export Decision Verdict

Move-ready as directories. Public-export-ready only for declarative governance contracts. Evaluation and authority-adjacent surfaces require later semantic export approval.
