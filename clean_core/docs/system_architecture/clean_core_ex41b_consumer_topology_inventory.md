# EX-41B Consumer Topology Inventory

Phase: EX-41B - Consumer Dependency Topology Audit

## Scope

This inventory maps dependency topology around:

- `clean_core/lib/core/audit/`
- `clean_core/lib/core/human_review/`

No files were moved, imports were modified, exports were changed, dependencies were added, or runtime systems were activated.

## Audit Folder Inventory

Audit files:

- `audit_actor_type.dart`
- `audit_event.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_runtime_marker.dart`
- `audit_severity.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`
- `audit_visibility_scope.dart`
- `safety_observability_contract.dart`

## Human Review Folder Inventory

Human review files:

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

## Topology Finding

Wave 2 safe-batch candidates were not isolated leaf nodes. They are foundational contracts consumed by adjacent excluded files through sibling imports.

Future extraction must become consumer-first:

- identify dependents before movement
- classify dependency clusters
- split runtime/Firestore mappers before moving pure contracts
- avoid moving provider contracts ahead of consumer strategy

