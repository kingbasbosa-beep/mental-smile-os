# EX-124 Package Surface Verification

## Scope

Docs/review only. Inspected package surface after EX-123 without running
`pub get`, `analyze`, provider setup, Firebase setup, or runtime activation.

## Commands Used

- `Get-Content -Path mental_smile_clean_core/lib/mental_smile_clean_core.dart`
- `Get-ChildItem -Path mental_smile_clean_core/lib/src/audit -Recurse -File`
- `Get-ChildItem -Path mental_smile_clean_core/lib/src/human_review -Recurse -File`
- `Select-String -Path mental_smile_clean_core/lib/mental_smile_clean_core.dart -Pattern "^export"`
- `Select-String -Path mental_smile_clean_core/lib/mental_smile_clean_core.dart -Pattern "^export" | Measure-Object`
- `rg "package:mental_smile_clean_core|mental_smile_clean_core.dart" clean_core/lib test mental_smile_app lib`

## Current Public Package Surface

The package barrel inspected was:

- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

It currently contains 126 explicit file exports. Current exported surface
groups are:

- `src/audit/`
- `src/backend_boundaries/`
- `src/governance/capability/`
- `src/governance/compliance/`
- `src/governance/federation/`
- `src/governance/kernel/`
- `src/governance/lifecycle/`
- `src/human_review/`
- `src/policy_runtime/`
- `src/safety_decision/`
- `src/trusted_backend/`
- `src/trusted_pipeline/`

## Current Audit Public Surface

Public audit exports are:

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

Finding: audit package contracts remain passive package models. Firestore
mapping responsibility remains outside this package surface.

## Current Human Review Public Surface

Public human-review exports are:

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

Finding: `PassiveReviewSignal` remains narrow. It exposes only:

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

## Consumer Reconnect Check

The reconnect search found no current `package:mental_smile_clean_core` import
or `mental_smile_clean_core.dart` consumer reference under the inspected host
consumer paths. EX-124 did not reconnect or migrate consumers.

## Package Surface Verdict

Pass. The current surface matches EX-123: existing public package groups remain
visible, audit and human-review surfaces remain explicit, and no new package
contracts were created by EX-124.
