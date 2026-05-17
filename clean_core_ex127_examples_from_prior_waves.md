# EX-127 Examples From Prior Waves

## Scope

Docs/rubric only. These examples show how EX-99 through EX-126 findings map to
the EX-127 scoring rubric and approval taxonomy.

## Current Audit Package Surface

Example:

- `audit_event.dart`
- `audit_reference.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`

Observed doctrine:

- package contracts may describe passive audit events, references, snapshots,
  traces, visibility, severity, retention, processing context, redaction, and
  placeholder hash semantics
- audit package contracts must not prove backend enforcement, persistence
  success, trace validity, privacy compliance, or Firestore write behavior

Likely taxonomy for a similar future candidate:

- `EXPORT_ELIGIBLE` only if passive, pure Dart, mapper-free, compatible, and
  separately approved for export
- `MAPPER_ELIGIBLE` only for host-side Firestore mapper review

## Current Human Review Package Surface

Example:

- `escalation_request.dart`
- `escalation_review.dart`
- `escalation_resolution.dart`
- `escalation_assignment.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`

Observed doctrine:

- may describe passive requests, reviews, resolutions, assignments, reasons,
  levels, policy references, audit links, priority, state, and visibility
- must not imply queue admission, reviewer/team ownership, moderation
  ownership, emergency response, backend enforcement, or client outcome write
  authority

Likely taxonomy for a similar future candidate:

- `PACKAGE_INTERNAL_UNEXPORTED` during isolation
- `EXPORT_ELIGIBLE` only after explicit export gate
- `MIGRATION_ELIGIBLE` only after export approval and explicit consumer
  migration approval

## PassiveReviewSignal Narrow Public Surface

Example:

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

Observed doctrine:

- public passive labels must not be commands, permissions, workflow states,
  enforcement signals, routing/admission decisions, audit verification, policy
  compliance proof, backend governance proof, emergency handling, write
  authority, provider/runtime causality, or fallback recovery

Likely taxonomy:

- narrow labels with caveats may become `EXPORT_ELIGIBLE`
- labels without caveats downgrade to `PACKAGE_INTERNAL_UNEXPORTED` or
  `BLOCKED`

## Internal Passive Vocabulary Holdbacks

Example:

- `queue_passive_label.dart`
- `boundary_passive_label.dart`
- `emergency_posture_label.dart`
- `provider_issue_label.dart`
- `fallback_observation_label.dart`

Observed doctrine:

- remain unexported, rollback-local, and unconsumed
- future exposure requires doctrine review

Likely taxonomy:

- `PACKAGE_INTERNAL_UNEXPORTED` if isolated and passive
- `BLOCKED` for public export unless doctrine reopens the concept

## Queue/Boundary Blockers

Example:

- `EscalationQueue.accepts`
- `safetyConcernObserved`
- `reviewStatePending`
- `reviewBoundaryObserved`

Observed doctrine:

- queue and boundary concepts are not package-safe in their original form
- blocked risks include routing/admission, workflow execution, team ownership,
  emergency guarantees, backend enforcement, and write authority

Likely taxonomy:

- `BLOCKED`
- at most `DOCS_ONLY` for future doctrine review

## Runtime/Provider Holdbacks

Example:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

Observed doctrine:

- runtime/provider diagnostics and orchestration remain held back
- blocked risks include provider causality, provider trust, adapter execution,
  runtime execution, fallback recovery, backend availability, telemetry/privacy
  proof, and enforcement proof

Likely taxonomy:

- `BLOCKED`
- `BACKEND_ONLY` or `HOST_ONLY` only if a later wave explicitly scopes that
  review and excludes package exposure

## Host-Side Firestore Mappers

Example:

- `AuditEventFirestoreMapper`
- `AuditSnapshotFirestoreMapper`
- `AuditTraceFirestoreMapper`
- `EscalationAssignmentFirestoreMapper`
- `EscalationRequestFirestoreMapper`
- `EscalationResolutionFirestoreMapper`
- `EscalationReviewFirestoreMapper`

Observed doctrine:

- Firestore mapping remains host-side
- Firestore/Firebase/Timestamp/FieldValue behavior must not leak into package
  contracts or barrel exports

Likely taxonomy:

- `HOST_ONLY`
- `MAPPER_ELIGIBLE` only for future host mapper review
- `BLOCKED` for package mapper or package export

## Docs-Only Governance Waves

Example:

- EX-124 doctrine registry and package surface verification
- EX-125 decision matrix and approval gates
- EX-126 candidate intake template and checklists

Observed doctrine:

- docs/review/template/rubric waves may consolidate governance without source
  changes

Likely taxonomy:

- `DOCS_ONLY`

## Example Verdict

Pass. Prior waves demonstrate that safe package work starts with docs/review,
then internal isolation, then explicit export review, then mapper or migration
review only when separately approved.
