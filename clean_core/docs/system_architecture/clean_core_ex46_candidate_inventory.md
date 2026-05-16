# EX-46 Candidate Inventory

Phase: EX-46 - Next True Leaf Discovery

## Scope

This discovery reviewed likely declarative candidates in:

- `clean_core/lib/core/audit/`
- `clean_core/lib/core/human_review/`
- `clean_core/lib/core/governance_capability/`
- `clean_core/lib/core/governance_federation/`

No files were moved, imports were modified, exports were changed, dependencies were added, or runtime systems were activated.

## Audit Candidates Reviewed

Remaining audit files:

- `audit_actor_type.dart`
- `audit_event.dart`
- `audit_event_type.dart`
- `audit_reference.dart`
- `audit_runtime_marker.dart`
- `audit_severity.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`
- `audit_visibility_scope.dart`
- `safety_observability_contract.dart`

Previously extracted true leaves:

- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_retention_policy.dart`

## Human Review Candidates Reviewed

Remaining human review files:

- `escalation_assignment.dart`
- `escalation_audit_link.dart`
- `escalation_boundary_marker.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_queue.dart`
- `escalation_reason.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

## Governance Capability/Federation Areas

The requested `clean_core/lib/core/governance_capability/` and `clean_core/lib/core/governance_federation/` folders are no longer present in `clean_core`.

Their corresponding extracted package areas exist under:

- `mental_smile_clean_core/lib/src/governance/capability/`
- `mental_smile_clean_core/lib/src/governance/federation/`

Therefore, no remaining clean_core true leaf candidates were discovered in those two governance areas.

## Inventory Finding

After EX-44, the strongest true leaf candidates have already been extracted. Remaining candidates are mostly consumer-bound, runtime-sensitive, Firestore-coupled, queue-sensitive, or backend-authority-sensitive.

