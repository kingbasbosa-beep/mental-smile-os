# clean_core Batch 5 Capability and Federation Export Decision

## Export Strategy

Batch 5 may move as complete directories, but root barrel exports should remain conservative and file-by-file.

## Governance Capability Export-Safe Candidates

Export-safe after movement:

- `governance_capability_audit_link.dart`
- `governance_capability_block_reason.dart`
- `governance_capability_fallback.dart`
- `governance_capability_reference.dart`
- `governance_capability_requirement.dart`
- `governance_capability_review_marker.dart`
- `governance_capability_runtime_marker.dart`
- `governance_capability_scope.dart`
- `governance_capability_state.dart`
- `governance_capability_visibility_scope.dart`

Keep hidden or review-required:

- `governance_capability.dart`
- `governance_capability_guard.dart`
- `governance_capability_policy.dart`

Reason:

- The main capability object and guard/policy surfaces can be misread as local permissioning or authority.
- They require later semantic export approval.

## Governance Federation Export-Safe Candidates

Export-safe after movement:

- `governance_federation_audit_link.dart`
- `governance_federation_block_reason.dart`
- `governance_federation_fallback.dart`
- `governance_federation_reference.dart`
- `governance_federation_requirement.dart`
- `governance_federation_review_marker.dart`
- `governance_federation_runtime_marker.dart`
- `governance_federation_scope.dart`
- `governance_federation_state.dart`
- `governance_federation_visibility_scope.dart`

Keep hidden or review-required:

- `governance_federation.dart`
- `governance_federation_guard.dart`
- `governance_federation_lock.dart`
- `governance_federation_policy.dart`

Reason:

- The main federation object, guard, lock, and policy surfaces can be misread as distributed authority or orchestration control.
- They require later semantic export approval.

## Broad Export Risk

Do not export capability or federation directories broadly.

Required future barrel rule:

- add explicit file-by-file exports only
- keep authority-like main objects hidden by default
- keep guard/policy/lock files hidden by default
- do not expose federation or capability surfaces as runtime authority

## Export Decision Verdict

Move-ready as directories. Public-export-ready only for declarative references, markers, states, scopes, block reasons, fallbacks, and requirements. Authority-adjacent surfaces require later semantic export approval.
