# EX-123 Current Package Surface

## Scope

Docs/handoff only. This document records the currently visible package barrel
surface for handoff purposes.

## Current Barrel

The package barrel inspected was:

- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

It currently exports these surface groups:

- `src/audit/*`
- `src/backend_boundaries/*`
- `src/governance/capability/*`
- `src/governance/compliance/*`
- `src/governance/federation/*`
- `src/governance/kernel/*`
- `src/governance/lifecycle/*`
- `src/human_review/*`
- `src/policy_runtime/*`
- `src/safety_decision/*`
- `src/trusted_backend/*`
- `src/trusted_pipeline/*`

## Current Audit Surface

Public audit exports include:

- `audit_actor_type.dart`
- `audit_event.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_processing_context.dart`
- `audit_reference.dart`
- `audit_redaction.dart`
- `audit_retention_policy.dart`
- `audit_severity.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`
- `audit_visibility_scope.dart`

These are package contracts. Firestore persistence remains host-owned.

## Current Human Review Surface

Public human-review exports include:

- `escalation_assignment.dart`
- `escalation_audit_link.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`
- `escalation_state.dart`
- `passive_review_signal.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

`PassiveReviewSignal` exposes only:

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

## Internal Human Review Holdback Files

The following package files exist under `src/human_review/` but are not barrel
exports:

- `queue_passive_label.dart`
- `boundary_passive_label.dart`
- `emergency_posture_label.dart`
- `provider_issue_label.dart`
- `fallback_observation_label.dart`

These remain internal and rollback-local unless a future wave explicitly
approves exposure.

## Host-Side Mapper Surface

Audit Firestore mappers remain host-side:

- `AuditEventFirestoreMapper`
- `AuditSnapshotFirestoreMapper`
- `AuditTraceFirestoreMapper`

Human Review Firestore mappers remain host-side:

- `EscalationAssignmentFirestoreMapper`
- `EscalationRequestFirestoreMapper`
- `EscalationResolutionFirestoreMapper`
- `EscalationReviewFirestoreMapper`

## Runtime/Provider Surface Note

The package contains older policy-runtime and governance runtime-marker exports.
The Runtime/Provider Doctrine wave did not add runtime/provider diagnostic
contracts, runtime/provider mappers, or runtime/provider diagnostic exports.
