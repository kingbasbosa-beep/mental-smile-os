# EX-99 Extraction Wave Milestone

## Scope

This milestone consolidates the completed extraction wave across the audit and human review lanes.

## Wave Objectives

- Extract package-safe contracts into `mental_smile_clean_core`.
- Preserve host compatibility paths.
- Avoid reconnect and import migration.
- Keep runtime/provider/Firebase behavior out of the package.
- Keep Firestore persistence host-owned.
- Establish additive split doctrine for mapper-bound records.
- Keep rollback local and explicit.

## Completed Audit Package Contracts

- `AuditEvent`
- `AuditTrace`
- `AuditReference`
- `AuditProcessingContext`

Additional audit vocabulary and metadata contracts are also present in the package surface.

## Completed Human Review Package Contracts

- `EscalationLevel`
- `EscalationReason`
- `EscalationState`
- `ReviewPriority`
- `ReviewVisibilityScope`
- `EscalationAuditLink`
- `EscalationPolicyReference`
- `EscalationAssignment`
- `EscalationReview`
- `EscalationResolution`
- `EscalationRequest`

## Milestone Finding

The extraction wave produced a package-visible declarative contract layer while preserving host ownership of persistence, queues, boundary markers, runtime, provider behavior, and orchestration semantics.
