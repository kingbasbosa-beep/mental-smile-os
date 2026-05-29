# GROUNDING-W4 Booking Command Audit Artifact Specification

Mental Smile - Grounding Era

Source documents:

- `docs/GROUNDING_W1_RUNTIME_INVENTORY_AUTHORITY_MAP.md`
- `docs/GROUNDING_W2_LEGACY_FREEZER_REGISTRY.md`
- `docs/GROUNDING_W3_ADMIN_BOOKING_COMMAND_WRAPPER_SPEC.md`

Status: specification-only. No audit runtime, Firestore collections, Firebase rules, production code, `AdminBookingDecisionAdapter` changes, backend functions, custom claims, booking lifecycle changes, validation enforcement, or route changes were implemented.

## 1. Executive Summary

GROUNDING-W4 defines future audit artifacts for booking command wrappers. It does not create audit collections, append audit events, modify runtime behavior, or enforce append-only audit.

Audit is the future institutional memory of the booking command runtime. The current runtime does not yet enforce append-only audit; admin booking mutations still happen through direct Firestore updates in `AdminBookingDecisionAdapter`.

W4 prepares future command wrappers by defining:

- Audit artifact candidates.
- Universal audit event fields.
- Immutable field rules.
- Event names and severity levels.
- Shadow-mode audit posture.
- Sovereign audit boundaries.
- Verification gates before append-only enforcement.

This specification must be treated as preparation. It is not permission to implement audit runtime or block booking flows.

## 2. Audit Artifact Model

| Artifact / Future Collection | Purpose | Risk Scope | Writer Candidate | Read Audience | Runtime Status |
| ---------------------------- | ------- | ---------- | ---------------- | ------------- | -------------- |
| `booking_command_audit` | Records command request, validation, execution, and result metadata for booking command wrappers. | High to Critical booking lifecycle commands. | Future `BookingAuditAppender` or backend audit writer. | Control observability, Owner governance, scoped audit readers. | FUTURE_APPEND_ONLY |
| `booking_lifecycle_audit` | Records lifecycle state transitions such as assignment, rejection, return, center approval, and intake opening. | Booking and center request lifecycle. | Future backend command executor or compatibility wrapper in shadow stage. | Control Room case/observability, scoped tenant support summaries. | FUTURE_APPEND_ONLY |
| `booking_financial_audit` | Records payment evidence decisions, accounting review, payout confirmation, and financial correction trails. | Sovereign finance, payout, accounting. | Future sovereign backend/audit writer only. | Sovereign Finance/Legal, restricted Owner oversight, redacted Control summaries. | SOVEREIGN_REQUIRED |
| `booking_archive_audit` | Records archive staging/finalization for session and financial archives. | Archive finality, legal/financial traceability. | Future archive command executor or audit writer. | Control archive visibility, Sovereign readers for financial archive. | FUTURE_APPEND_ONLY |
| `booking_shadow_command_logs` | Non-authoritative shadow previews of command envelopes, validation warnings, and audit readiness. | Dry-run/pre-enforcement diagnostics. | Future shadow wrapper logger; may remain non-production. | Engineering/Owner readiness, Control observability summaries. | SHADOW_CANDIDATE |

## 3. Universal Audit Event Schema

| Field | Required In Shadow? | Required In Enforcement? | Mutable Later? | Why |
| ----- | ------------------- | ------------------------ | -------------- | --- |
| `auditId` | Yes | Yes | No | Unique audit event identity. |
| `eventName` | Yes | Yes | No | Defines what happened or what was requested. |
| `eventVersion` | Yes | Yes | No | Allows schema evolution without rewriting history. |
| `commandId` | Yes | Yes | No | Links audit event to command envelope. |
| `commandName` | Yes | Yes | No | Identifies requested command. |
| `commandVersion` | Yes | Yes | No | Preserves command schema context. |
| `correlationId` | Yes | Yes | No | Connects UI action, command, audit, logs, and execution. |
| `idempotencyKey` | Yes | Yes | No | Helps identify duplicate execution attempts. |
| `riskTier` | Yes | Yes | No | Drives severity, visibility, and rollout behavior. |
| `severity` | Yes | Yes | No | States audit importance and response posture. |
| `actorUid` | Yes | Yes | No | Records who initiated the command. |
| `actorRole` | Yes | Yes | No | Captures compatibility role context. |
| `actorClaimSnapshot` | Best effort | Yes | No | Freezes authority context at request time. |
| `sourceRoute` | Yes | Yes | No | Identifies UI source, usually `/admin/booking-queue`. |
| `sourceAdapter` | Yes | Yes | No | Identifies legacy source, usually `AdminBookingDecisionAdapter`. |
| `targetCollection` | Yes | Yes | No | Source truth collection, currently `booking_requests`. |
| `targetDocId` | Yes | Yes | No | Booking request ID. |
| `targetTenantId` | If available | Yes when tenancy exists | No | Prevents cross-tenant ambiguity. |
| `targetClientId` | If available | Yes when present in booking | No | Links affected client. |
| `targetClinicianId` | If applicable | Yes for clinician commands | No | Links assigned/paid clinician. |
| `targetCenterId` | If applicable | Yes for center commands | No | Links center request/accounting/payout. |
| `previousState` | Best effort | Yes | No | Needed for traceability, validation, diff, rollback analysis. |
| `newState` | After execution if available | Yes for completed commands | No | Records resulting state. |
| `changedFields` | Best effort | Yes | No | Minimal diff of fields changed by command. |
| `requestedPatch` | Yes | Yes | No | Exact intended mutation payload. |
| `validationWarnings` | Optional | Yes when warnings exist | No | Shadow and readiness evidence. |
| `validationErrors` | Optional | Yes when failed | No | Failure traceability. |
| `reason` | Required when command needs reason | Required for rejection/return/archive/failure | No | Governance explanation. |
| `caseId` | Optional | Required for case-linked commands | No | Links Control Room/case workflow. |
| `dryRun` | Yes | Yes | No | Distinguishes simulation from real enforcement. |
| `shadowMode` | Yes | Yes | No | Distinguishes non-authoritative audit previews. |
| `resultStatus` | Yes | Yes | No | Requested, completed, failed, skipped, or shadow-only. |
| `failureStage` | If failed | If failed | No | Identifies envelope, validation, audit, or execution failure. |
| `errorCode` | If failed | If failed | No | Machine-readable failure category. |
| `errorMessage` | If failed | If failed | No | Human-readable failure summary, redacted as needed. |
| `createdAt` | Yes | Yes | No | Client/wrapper event creation time. |
| `serverCreatedAt` | If persisted | Yes | No | Server-authoritative append time. |

## 4. Immutable Field Rules

These fields must never be changed after append:

- `auditId`
- `eventName`
- `eventVersion`
- `commandId`
- `commandName`
- `correlationId`
- `actorUid`
- `actorClaimSnapshot`
- `targetDocId`
- `previousState`
- `requestedPatch`
- `createdAt`
- `serverCreatedAt`

Audit correction must be additive, not mutation-based.

If an audit event is incomplete, wrong, duplicated, or overexposed, the future system must append a correction event. It must not edit the historical event in place. Correction events should reference the original `auditId`, describe the correction reason, and include redaction/correction metadata without erasing the original chain.

## 5. Event Name Registry

| Command | Requested Event | Success Event | Failure Event | Severity | Artifact |
| ------- | --------------- | ------------- | ------------- | -------- | -------- |
| `booking.assign_clinician` | `booking.command.requested` | `booking.clinician_assigned` | `booking.command.failed` | CRITICAL | `booking_lifecycle_audit` |
| `booking.reject_request` | `booking.command.requested` | `booking.request_rejected` | `booking.command.failed` | CRITICAL | `booking_lifecycle_audit` |
| `booking.return_to_pending` | `booking.command.requested` | `booking.returned_to_pending` | `booking.command.failed` | CRITICAL | `booking_lifecycle_audit` |
| `center_request.move_to_follow_up` | `booking.command.requested` | `center_request.follow_up_started` | `booking.command.failed` | HIGH_RISK | `booking_lifecycle_audit` |
| `center_request.open_intake_step` | `booking.command.requested` | `center_request.intake_opened` | `booking.command.failed` | HIGH_RISK | `booking_lifecycle_audit` |
| `center_request.approve` | `booking.command.requested` | `center_request.approved` | `booking.command.failed` | CRITICAL | `booking_lifecycle_audit` |
| `center_request.return_to_client` | `booking.command.requested` | `center_request.returned_to_client` | `booking.command.failed` | HIGH_RISK | `booking_lifecycle_audit` |
| `accounting.confirm_center_review` | `booking.command.requested` | `accounting.center_review_confirmed` | `booking.command.failed` | SOVEREIGN_CRITICAL | `booking_financial_audit` |
| `payment.approve_evidence` | `booking.command.requested` | `payment.evidence_approved` | `booking.command.failed` | SOVEREIGN_CRITICAL | `booking_financial_audit` |
| `payment.reject_evidence` | `booking.command.requested` | `payment.evidence_rejected` | `booking.command.failed` | SOVEREIGN_CRITICAL | `booking_financial_audit` |
| `payout.confirm_center` | `booking.command.requested` | `payout.center_confirmed` | `booking.command.failed` | SOVEREIGN_CRITICAL | `booking_financial_audit` |
| `payout.confirm_clinician` | `booking.command.requested` | `payout.clinician_confirmed` | `booking.command.failed` | SOVEREIGN_CRITICAL | `booking_financial_audit` |
| `archive.send_to_session_archive` | `booking.command.requested` | `archive.session_sent` | `booking.command.failed` | HIGH_RISK | `booking_archive_audit` |
| `archive.send_to_financial_archive` | `booking.command.requested` | `archive.financial_sent` | `booking.command.failed` | SOVEREIGN_CRITICAL | `booking_archive_audit` |

## 6. Severity Classification

Severity values:

- `INFO`
- `LOW_RISK`
- `MEDIUM_RISK`
- `HIGH_RISK`
- `CRITICAL`
- `SOVEREIGN_CRITICAL`

| Command / Event Family | Severity | Why |
| ---------------------- | -------- | --- |
| Shadow preview events | INFO | Non-authoritative previews only; must be marked with `shadowMode: true`. |
| Command envelope generated without mutation | LOW_RISK | No runtime truth changed. |
| Validation warning events | MEDIUM_RISK | Indicates future enforcement concern but no blocking yet. |
| `center_request.move_to_follow_up` | HIGH_RISK | Changes center request handling path but does not directly finalize finance/payout. |
| `center_request.open_intake_step` | HIGH_RISK | Opens intake progression and affects client/center workflow. |
| `center_request.return_to_client` | HIGH_RISK | Sends operational workflow back to client and requires reason/feedback traceability. |
| `archive.send_to_session_archive` | HIGH_RISK | Archive readiness affects operational history and reporting. |
| `booking.assign_clinician` | CRITICAL | Assigns professional handling and moves booking lifecycle forward. |
| `booking.reject_request` | CRITICAL | Blocks payment/session/review/payout and ends or interrupts lifecycle. |
| `booking.return_to_pending` | CRITICAL | Resets multiple lifecycle fields and can undo prior decisions. |
| `center_request.approve` | CRITICAL | Moves center request into setup/payment flow. |
| `payment.approve_evidence` | SOVEREIGN_CRITICAL | Payment evidence decision affects financial and operational truth. |
| `payment.reject_evidence` | SOVEREIGN_CRITICAL | Payment rejection can alter service progression and financial record. |
| `accounting.confirm_center_review` | SOVEREIGN_CRITICAL | Computes commission/net amount and confirms accounting review. |
| `payout.confirm_center` | SOVEREIGN_CRITICAL | Marks payout as transferred/paid and completes center flow. |
| `payout.confirm_clinician` | SOVEREIGN_CRITICAL | Marks payout as transferred/paid and completes clinician flow. |
| `archive.send_to_financial_archive` | SOVEREIGN_CRITICAL | Financial archive finality requires sovereign traceability. |

Rules:

- Payout commands are `SOVEREIGN_CRITICAL`.
- Payment and accounting commands are `SOVEREIGN_CRITICAL`.
- Assignment, rejection, return, and center approval are `CRITICAL` or `HIGH_RISK`.
- Archive events are `HIGH_RISK` or `SOVEREIGN_CRITICAL` depending on session vs financial archive.
- Shadow generated events must be clearly marked with `dryRun: true` and `shadowMode: true`.

## 7. Shadow-Mode Audit Posture

Stage 0 - No audit writes:

- W4 current state.
- Specification only.
- No collections, no appenders, no runtime behavior change.

Stage 1 - In-memory/log-only audit preview:

- Generate audit-shaped objects locally or in diagnostic logs.
- Do not write Firestore audit collections.
- Do not block the existing booking flow.

Stage 2 - Optional non-blocking audit append:

- Append to a clearly shadow-labeled artifact only after separate authorization.
- Audit failure must not break user flow.
- Shadow audit must not be treated as authoritative legal/financial memory.

Stage 3 - Soft validation warnings included in audit:

- Validation warnings are attached to audit preview/events.
- No blocking.
- Warnings support readiness scoring and drift detection.

Stage 4 - Audit append required only for low-risk or selected non-sovereign commands after QA:

- Candidate commands should exclude finance/payout/payment.
- Enforcement must be narrow, reversible, and observable.

Stage 5 - Sovereign commands require backend + append-only audit before any enforcement:

- Payment, accounting, payout, and financial archive commands must wait for sovereign backend validation and immutable audit.
- Generic admin must not become the final authority for these events.

## 8. Audit Failure Policy

| Failure | Shadow Behavior | Future Enforcement Behavior |
| ------- | --------------- | --------------------------- |
| Audit append fails | Log warning; do not break user flow. | For enforced commands, fail command before mutation unless explicitly configured as non-blocking. |
| Audit schema invalid | Log schema error and include command context if safe. | Reject command before mutation; append failure event if failure artifact is available. |
| `previousState` missing | Warn; mark audit incomplete. | Reject enforced command except for explicitly approved read-failure recovery paths. |
| `changedFields` cannot be computed | Warn; store requested patch and result status if available. | Reject or mark command incomplete until diff is computable for high/critical commands. |
| `actorClaimSnapshot` unavailable | Warn; use actor UID/role best effort. | Reject enforced command; authority cannot be proven. |
| Duplicate command detected | Warn; preserve current behavior if legacy adapter would continue. | Return idempotent prior result if safe; otherwise reject duplicate execution. |
| Server timestamp unavailable | Use local timestamp only in shadow; mark non-authoritative. | Reject append-only enforcement because server append time is required. |
| Audit write partially succeeds | Record diagnostic warning and correlation ID. | Append correction/failure event; do not mutate audit rows in place. |

## 9. Privacy & Data Minimization

Booking audit should preserve governance truth without collecting unnecessary sensitive data.

Rules:

- Do not store full sensitive chat messages in booking audit.
- Avoid storing unnecessary clinical notes.
- Store IDs and state diffs over full profiles when possible.
- For payment evidence, store evidence reference/metadata, not raw files.
- Store reason text only where governance requires it.
- Never store secrets, tokens, private credentials, raw access keys, or client-only credentials.
- Avoid full profile snapshots unless required for a specific dispute/audit purpose.
- Redact clinical or support content from Control Room-visible audit summaries.
- Use financial redaction for payment/payout artifacts outside Sovereign Finance/Legal visibility.

## 10. Early Audit Candidate

Safest first audit candidate:

```text
booking.assign_clinician
```

Why:

- It reads the booking before mutation.
- It has clear target clinician fields.
- It returns a typed result: `AdminAssignClinicianResult`.
- It has an already-assigned branch that can become an idempotency signal.
- It does not execute payout or payment authority.
- It is suitable for shadow audit first while preserving current adapter behavior.

Expected successful audit sequence:

```text
booking.command.requested
booking.clinician_assigned
```

Expected failure audit sequence:

```text
booking.command.requested
booking.command.failed
```

Initial shadow fields should include command name, actor UID, target request ID, previous status/workflow stage, requested clinician fields, requested patch, validation warnings, `dryRun: true`, and `shadowMode: true`.

## 11. Sovereign Audit Boundary

These commands must remain spec-only until sovereign design exists:

- `payment.approve_evidence`
- `payment.reject_evidence`
- `accounting.confirm_center_review`
- `payout.confirm_center`
- `payout.confirm_clinician`
- `archive.send_to_financial_archive`

Rules:

- No enforcement.
- No client-side final authority.
- No generic admin expansion.
- No silent correction.
- No payout confirmation without immutable audit and backend validation.
- No payment/accounting audit treated as complete unless written by a sovereign-approved backend writer.
- No financial archive finality without sovereign audit visibility and correction posture.

## 12. Verification Checklist

- [ ] W4 created documentation only.
- [ ] No production behavior changed.
- [ ] No Firestore collections created.
- [ ] No rules changed.
- [ ] No claims changed.
- [ ] No adapter modified.
- [ ] Audit fields support W3 command envelope.
- [ ] Sovereign commands marked as spec-only.
- [ ] `assignClinician` marked as first shadow audit candidate.
- [ ] Privacy/data minimization rules included.

## 13. Final Recommendation

Recommended W5 target:

```text
GROUNDING-W5 - Shadow Wrapper Implementation Plan for assignClinician
```

W5 should be another implementation plan/spec by default, not implementation. The system is not ready to create Firestore audit collections or enforce audit append.

Safest next code-level move if implementation is explicitly authorized later:

- Add an isolated, unused shadow wrapper class or passive command/audit model for `booking.assign_clinician`.
- Preserve the existing `AdminBookingDecisionAdapter.assignClinician` signature and behavior.
- Generate audit-shaped objects in memory/log-only mode.
- Do not persist audit.
- Do not block validation.
- Do not route production callers through the wrapper until QA and explicit authorization.

