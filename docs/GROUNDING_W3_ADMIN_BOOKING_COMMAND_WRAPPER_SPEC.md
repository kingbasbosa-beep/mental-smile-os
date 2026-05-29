# GROUNDING-W3 AdminBookingDecisionAdapter Command Wrapper Specification

Mental Smile - Grounding Era

Source documents:

- `docs/GROUNDING_W1_RUNTIME_INVENTORY_AUTHORITY_MAP.md`
- `docs/GROUNDING_W2_LEGACY_FREEZER_REGISTRY.md`

Status: specification-only. No production code, routes, Firebase rules, custom claims, backend functions, command runtime, audit runtime, or booking lifecycle behavior were changed.

## 1. Executive Summary

`AdminBookingDecisionAdapter` is currently a direct admin mutation adapter. It writes booking lifecycle truth into `booking_requests` through `updateRequestEverywhere` and `updatePrimaryCenterRequest`.

GROUNDING-W2 froze this adapter as `COMMAND_REQUIRED_FUTURE` because it has the largest operational blast radius in the current admin surface. It controls or influences booking status, workflow stage, admin approval/rejection, clinician assignment, center request progression, payment status, accounting status, payout status, session status, review status, and archive readiness.

This adapter must not be expanded. Future treatment is command wrapper + audit + backend validation. The old adapter must remain available for compatibility until command runtime exists and has been verified.

This document is a specification only. It does not implement the wrapper.

## 2. Current Adapter Method Inventory

| Method | Current Operation | Collection / Doc | Fields Mutated | Caller(s) | Runtime Meaning | Risk |
| ------ | ----------------- | ---------------- | -------------- | --------- | --------------- | ---- |
| `readPrimaryBookingRequest` | Reads booking document | `booking_requests/{requestId}` | None | `assignClinician`, `updatePrimaryCenterRequest`, admin queue setup | Loads source truth before mutation | Medium |
| `updateRequestEverywhere` | Generic update helper | `booking_requests/{requestId}` | Arbitrary patch plus `updatedAt`; canonicalizes `workflowStage` from `status` | Internal adapter methods | Direct write gateway for most booking mutations | Critical |
| `updatePrimaryCenterRequest` | Center-specific update helper | `booking_requests/{requestId}` | Arbitrary patch plus `updatedAt`; refreshes auth callback and logs traces | Center request methods, `rejectRequest` for center requests | Direct write gateway for center request lifecycle | Critical |
| `rejectRequest` | Updates status to `rejected_admin` and blocks payment/session/review/payout | `booking_requests/{requestId}` | `status`, `workflowStage`, `adminApproved`, `adminRejected`, `adminForwarded`, `adminDecisionType`, `adminDecisionBy`, `adminDecisionAt`, `adminAssignedBy`, `adminAssignedAt`, `paymentStatus`, `payment_confirmed`, `sessionStatus`, `reviewStatus`, `payoutStatus` | `admin_booking_queue_page.dart` `_rejectRequest` | Admin rejects booking request | Critical |
| `returnToPending` | Resets request to pending admin state | `booking_requests/{requestId}` | `status`, `workflowStage`, admin flags, assignment fields, clinician fields, payment/session/review/payout status | `admin_booking_queue_page.dart` `_returnToPending` | Admin reopens request after prior decision | Critical |
| `moveCenterToFollowUp` | Moves center request to follow-up state | `booking_requests/{requestId}` | `status`, `workflowStage`, admin flags, `centerAdminHandledBy`, `centerAdminHandledAt` | No direct caller found in current `rg` output | Center follow-up transition | High |
| `openCenterIntakeStep` | Opens center intake step | `booking_requests/{requestId}` | `status`, `workflowStage`, `adminDecisionType`, `adminDecisionBy`, `adminDecisionAt` | `admin_booking_queue_page.dart` `_openCenterIntakeStep` | Admin opens intake for center request | High |
| `approveCenterRequest` | Approves center request and sets payment/session setup status | `booking_requests/{requestId}` | `status`, `workflowStage`, admin flags, payment/session/review/payout status, clinician assignment fields | `admin_booking_queue_page.dart` `_approveCenterRequest` | Admin approves center request into setup/payment flow | Critical |
| `returnCenterRequestToClient` | Returns center request to client for update | `booking_requests/{requestId}` | `status`, `workflowStage`, center feedback snapshot fields, `adminCanApproveWithoutCenterRecheck`, admin decision fields | `admin_booking_queue_page.dart` `_returnCenterRequestToClient` | Admin sends center request back to client | High |
| `confirmCenterAccountingReview` | Confirms accounting review and computes commission/net | `booking_requests/{requestId}` | `status`, `accountingReviewStatus`, `grossClientPaidAmount`, `appCommissionPercent`, `appCommissionAmount`, `netAmountDueToCenter`, `accountingReviewNotes`, `accountingConfirmedBy`, `accountingConfirmedAt` | `admin_booking_queue_page.dart` `_confirmCenterAccountingReview` | Admin confirms center accounting numbers | Critical |
| `confirmCenterPayout` | Marks center payout complete and request complete | `booking_requests/{requestId}` | `status`, `workflowStage`, `sessionStatus`, `reviewStatus`, `payoutStatus`, `payoutTransferredAt` | `admin_booking_queue_page.dart` `_confirmCenterPayout` | Admin confirms center payout and completion | Critical |
| `approvePayment` | Deprecated payment approval path | `booking_requests/{requestId}` | `status`, `workflowStage`, `paymentStatus`, `payment_confirmed`, `paymentApprovedAt`, `sessionStatus` | Deprecated; payment authority moved to `AdminPaymentDecisionAdapter` | Legacy payment approval | Critical |
| `rejectPayment` | Deprecated payment rejection path | `booking_requests/{requestId}` | `status`, `workflowStage`, `paymentStatus`, `payment_confirmed`, `paymentRejectedAt` | Deprecated; payment authority moved to `AdminPaymentDecisionAdapter` | Legacy payment rejection | Critical |
| `confirmClinicianPayout` | Marks clinician payout complete and request complete | `booking_requests/{requestId}` | `status`, `workflowStage`, `sessionStatus`, `reviewStatus`, `payoutStatus`, `payoutTransferredAt` | `admin_booking_queue_page.dart` `_confirmClinicianPayout` | Admin confirms clinician payout and completion | Critical |
| `sendToSessionArchive` | Marks request archived in session archive | `booking_requests/{requestId}` | `archived`, `archivedAt`, `archiveSection`, `archiveReady` | `admin_booking_queue_page.dart` `_sendToSessionArchive` | Admin archives session-side record | High |
| `sendToFinancialArchive` | Marks request archived in payment archive | `booking_requests/{requestId}` | `archived`, `archivedAt`, `archiveSection`, `archiveReady` | `admin_booking_queue_page.dart` `_sendToFinancialArchive` | Admin archives finance-side record | High |
| `assignClinician` | Reads request, validates requested clinician fields, assigns clinician | `booking_requests/{requestId}` | `status`, `workflowStage`, admin flags, assigned clinician fields, payment/session/review/payout status | `admin_booking_queue_page.dart` assignment action | Admin assigns requested clinician and moves request forward | Critical |

## 3. Command Mapping

| Current Method | Future Command Name | Command Type | Risk Tier | Future Owner |
| -------------- | ------------------- | ------------ | --------- | ------------ |
| `updateRequestEverywhere` | `booking.internal.apply_patch` | Internal compatibility command | Critical | Trusted Backend Command |
| `updatePrimaryCenterRequest` | `center_request.internal.apply_patch` | Internal compatibility command | Critical | Trusted Backend Command |
| `rejectRequest` | `booking.reject_request` | Lifecycle command | Critical | Trusted Backend Command |
| `returnToPending` | `booking.return_to_pending` | Lifecycle command | Critical | Trusted Backend Command |
| `moveCenterToFollowUp` | `center_request.move_to_follow_up` | Center lifecycle command | High | Control Case Command |
| `openCenterIntakeStep` | `center_request.open_intake_step` | Center lifecycle command | High | Trusted Backend Command |
| `approveCenterRequest` | `center_request.approve` | Center lifecycle command | Critical | Trusted Backend Command |
| `returnCenterRequestToClient` | `center_request.return_to_client` | Center lifecycle command | High | Control Case Command |
| `confirmCenterAccountingReview` | `accounting.confirm_center_review` | Accounting command | Critical | Sovereign Finance Command |
| `confirmCenterPayout` | `payout.confirm_center` | Payout command | Critical | Sovereign Finance Command |
| `approvePayment` | `payment.approve_evidence` | Deprecated payment command | Critical | Sovereign Finance Command |
| `rejectPayment` | `payment.reject_evidence` | Deprecated payment command | Critical | Sovereign Finance Command |
| `confirmClinicianPayout` | `payout.confirm_clinician` | Payout command | Critical | Sovereign Finance Command |
| `sendToSessionArchive` | `archive.send_to_session_archive` | Archive command | High | Audit Archive Command |
| `sendToFinancialArchive` | `archive.send_to_financial_archive` | Financial archive command | High | Audit Archive Command |
| `assignClinician` | `booking.assign_clinician` | Lifecycle assignment command | Critical | Trusted Backend Command |

## 4. Command Envelope Specification

Future wrapper objects should create a command envelope before any mutation. In early shadow mode, the envelope may exist only in memory/log output. Later it can become persisted command input for backend execution.

| Field | Required? | Why Needed | Notes |
| ----- | --------- | ---------- | ----- |
| `commandId` | Future-required | Unique command identity for audit and idempotency. | Can be generated client-side in shadow mode; backend should own final IDs later. |
| `commandName` | Required | Defines the constitutional action being requested. | Example: `booking.assign_clinician`. |
| `commandVersion` | Required | Prevents schema drift and allows future command migrations. | Start with `v1` in spec. |
| `riskTier` | Required | Drives validation, audit severity, and rollout stage. | `High` or `Critical` for this adapter. |
| `requestedByUid` | Required | Actor identity. | Current adapter methods already receive `adminUid` for several methods; missing methods must later resolve actor safely. |
| `requestedByRole` | Required | Compatibility role snapshot. | Current role is expected to be `admin`; future claim family may differ. |
| `requestedByClaimSnapshot` | Future-required | Freezes runtime authority context at request time. | Must not trust mutable UI state alone. |
| `targetCollection` | Required | Identifies source truth collection. | Always `booking_requests` for current adapter. |
| `targetDocId` | Required | Booking request document ID. | Current `requestId`. |
| `targetTenantId` | Future-required | Prevents cross-tenant mismatch. | May be absent in current schema; wrapper should reserve field. |
| `targetClientId` | Future-required | Links command to affected client. | Read from previous state snapshot. |
| `targetClinicianId` | Future-required when applicable | Links clinician assignment/session/payout effects. | Required for `booking.assign_clinician` and clinician payout. |
| `targetCenterId` | Future-required when applicable | Links center request/accounting/payout effects. | Required for center commands and center payout. |
| `previousStateSnapshot` | Future-required | Enables validation, audit diff, rollback analysis. | Should be read before mutation. |
| `requestedPatch` | Required | Describes exact intended mutation. | Should match current adapter payload during compatibility phase. |
| `reason` | Required for rejection/return/archive; optional otherwise | Human-readable governance reason. | Current methods often lack reason; future wrapper should introduce it without breaking old signatures initially. |
| `caseId` | Optional now; future-required for case-linked commands | Links Control Room/case workflow. | Needed for returns, rejections, escalations, anomalies. |
| `correlationId` | Required | Connects command, audit, logs, UI action, and backend execution. | Can be generated by wrapper. |
| `idempotencyKey` | Required | Prevents duplicate execution from repeated taps/retries. | Should combine command name, request ID, actor, and stable action payload hash. |
| `sourceRoute` | Required | Identifies UI source. | Usually `/admin/booking-queue` in current scope. |
| `sourceAdapter` | Required | Identifies legacy adapter surface. | `AdminBookingDecisionAdapter`. |
| `createdAt` | Required | Command request time. | In backend runtime this should be server time. |
| `dryRun` | Required | Indicates shadow/non-mutating mode. | Must be true for initial introduction. |

## 5. Validation Requirements

| Command | Required Validation | Failure Behavior | Risk |
| ------- | ------------------- | ---------------- | ---- |
| `booking.assign_clinician` | Actor has compatible authority; booking exists; status transition to `assigned_clinician` is allowed; clinician fields exist; target clinician exists and is approved/active; no cross-tenant mismatch; idempotency key not used. | Shadow: warn and preserve current behavior. Enforcement: reject command before mutation. | Critical |
| `booking.reject_request` | Actor authority; booking exists; rejection allowed from current state; reason required; payment/session/payout not already finalized; no cross-tenant mismatch. | Shadow: warn if reason missing or state risky. Enforcement: reject without mutation. | Critical |
| `booking.return_to_pending` | Actor authority; booking exists; current state is returnable; no completed payout/session finality; reason required if returning from rejected/approved state; idempotency. | Shadow warning; future blocking for completed/paid states. | Critical |
| `center_request.move_to_follow_up` | Actor authority; booking exists; request is center request; center exists and active/approved; transition to `center_follow_up` allowed. | Shadow warning; future reject for non-center request. | High |
| `center_request.open_intake_step` | Actor authority; booking exists; request is center request; prior center feedback or admin eligibility exists; transition allowed. | Shadow warning; future reject if prerequisites missing. | High |
| `center_request.approve` | Actor authority; booking exists; request is center request; target center exists and approved/active; client update no longer required; transition to setup/payment allowed. | Shadow warning; future reject if feedback/client-update state invalid. | Critical |
| `center_request.return_to_client` | Actor authority; booking exists; request is center request; center feedback exists; reason/feedback snapshot exists; revision number valid. | Shadow warning; future reject if feedback absent. | High |
| `accounting.confirm_center_review` | Actor authority; booking exists; center request; payment evidence/payment approval exists; gross amount valid; commission percent valid; note/reason present; no previous accounting finalization conflict. | Shadow warning only until sovereign design; future sovereign rejection. | Critical |
| `payout.confirm_center` | Sovereign authority; booking exists; center accounting confirmed; session/review prerequisites met; payout not already paid; rollback limitations acknowledged; idempotency. | Documentation-only until sovereign design; future hard reject if prerequisites missing. | Critical |
| `payment.approve_evidence` | Sovereign/payment authority; booking exists; payment evidence exists; payment not already approved/rejected final; transition allowed. | Deprecated path should warn; future route through payment adapter/sovereign command. | Critical |
| `payment.reject_evidence` | Sovereign/payment authority; booking exists; payment evidence exists or rejection reason provided; payment not finalized; reason required. | Deprecated path should warn; future route through payment adapter/sovereign command. | Critical |
| `payout.confirm_clinician` | Sovereign authority; booking exists; clinician assignment/session/review prerequisites met; payout not already paid; rollback limitations acknowledged. | Documentation-only until sovereign design; future hard reject. | Critical |
| `archive.send_to_session_archive` | Actor authority; booking exists; lifecycle completion/terminal state exists; archive reason present; no unresolved payment/session contradiction. | Shadow warning; future reject if not terminal. | High |
| `archive.send_to_financial_archive` | Sovereign/archive authority; booking exists; financial lifecycle terminal; payout/payment state resolved; archive reason present. | Shadow warning only until sovereign archive design. | High |

## 6. Audit Event Requirements

Every future command should emit `booking.command.requested` first and either a specific success event or `booking.command.failed`.

Required audit fields for all events:

`auditId`, `eventName`, `commandId`, `actorUid`, `actorRole`, `targetDocId`, `targetCollection`, `previousState`, `newState`, `changedFields`, `reason`, `riskTier`, `sourceRoute`, `sourceAdapter`, `createdAt`, `correlationId`.

| Command | Audit Event | Severity | Required Audit Fields |
| ------- | ----------- | -------- | --------------------- |
| `booking.assign_clinician` | `booking.clinician_assigned` | HIGH_RISK | Required common fields plus `targetClinicianId`, `assignedClinicianName`, prior status/workflow stage. |
| `booking.reject_request` | `booking.request_rejected` | CRITICAL | Required common fields plus rejection reason, blocked lifecycle fields, prior payment/session state. |
| `booking.return_to_pending` | `booking.returned_to_pending` | HIGH_RISK | Required common fields plus reset fields and prior assigned clinician/payment/session state. |
| `center_request.move_to_follow_up` | `center_request.follow_up_started` | HIGH_RISK | Required common fields plus `targetCenterId`, center feedback status if available. |
| `center_request.open_intake_step` | `center_request.intake_opened` | HIGH_RISK | Required common fields plus center request markers and prior stage. |
| `center_request.approve` | `center_request.approved` | CRITICAL | Required common fields plus `targetCenterId`, payment/session setup fields. |
| `center_request.return_to_client` | `center_request.returned_to_client` | HIGH_RISK | Required common fields plus feedback snapshot, revision number, reason. |
| `accounting.confirm_center_review` | `accounting.center_review_confirmed` | CRITICAL | Required common fields plus gross, commission percent, commission amount, net amount, note. |
| `payout.confirm_center` | `payout.center_confirmed` | CRITICAL | Required common fields plus payout status, payout timestamp, rollback limitation flag. |
| `payment.approve_evidence` | `payment.evidence_approved` | CRITICAL | Required common fields plus evidence reference, prior payment status, resulting session status. |
| `payment.reject_evidence` | `payment.evidence_rejected` | CRITICAL | Required common fields plus reason, prior payment status. |
| `payout.confirm_clinician` | `payout.clinician_confirmed` | CRITICAL | Required common fields plus target clinician, payout status, rollback limitation flag. |
| `archive.send_to_session_archive` | `archive.session_sent` | HIGH_RISK | Required common fields plus archive section, archive readiness, terminal lifecycle evidence. |
| `archive.send_to_financial_archive` | `archive.financial_sent` | CRITICAL | Required common fields plus archive section, payment/payout terminal evidence. |
| Any command failure | `booking.command.failed` | Matches command risk tier | Required common fields plus validation errors, exception class, failure stage. |

## 7. Compatibility Wrapper Design

Future class names, not implemented in W3:

```text
BookingCommandEnvelope
BookingCommandResult
BookingCommandValidator
BookingAuditAppender
AdminBookingCommandWrapper
```

Compatibility principles:

- The first implementation should preserve current adapter public method signatures where possible.
- `AdminBookingCommandWrapper` should initially sit beside the old adapter, not replace it globally.
- The wrapper can generate `BookingCommandEnvelope` and run dry-run validation before calling the existing adapter internally.
- The initial wrapper must not change request payloads, statuses, or field names.
- The old adapter should not be deleted, renamed, or moved in W3.
- Deprecated payment methods in `AdminBookingDecisionAdapter` should remain deprecated and frozen; new wrapper work should prefer documenting their sovereign replacement path rather than reviving them.

Possible first compatibility shape:

```text
AdminBookingCommandWrapper.assignClinician(...)
  -> build BookingCommandEnvelope(commandName: booking.assign_clinician)
  -> dry-run BookingCommandValidator
  -> optional non-blocking audit planning
  -> call existing AdminBookingDecisionAdapter.assignClinician(...)
  -> return existing AdminAssignClinicianResult
```

## 8. Dry-Run / Shadow Mode Plan

Stage 0 - Documentation only:

- Current W3 state.
- No code implementation.
- No runtime behavior change.

Stage 1 - Generate command envelope in memory/log only:

- Build envelope from current method inputs and previous snapshot.
- No persisted command collection.
- No blocking.
- Existing adapter still performs mutation.

Stage 2 - Append non-blocking audit events:

- Append audit events after envelope generation and/or after legacy adapter returns.
- Audit append failure must not break the user-facing flow during this stage.
- Audit events must be clearly marked as shadow/compatibility.

Stage 3 - Enable soft validation warnings:

- Validators compute warnings.
- Warnings are visible to observability/admin diagnostics.
- No blocking yet.

Stage 4 - Enable blocking only for low-risk commands after QA:

- Archive readiness or duplicate/idempotency guards may be candidates.
- Do not start with payout, payment, or broad lifecycle rejection.

Stage 5 - Move high-risk finance/payout commands to sovereign backend later:

- `payment.*`, `accounting.*`, and `payout.*` must wait for sovereign command/audit design.
- Backend execution and immutable audit must be proven before enforcement.

## 9. Rollback & Failure Posture

Command envelope generation failure:

- Shadow stage: log warning and allow current adapter behavior to continue.
- Enforcement stage: fail closed only after QA and only for commands authorized for enforcement.

Audit append failure:

- Shadow stage: do not block user-facing booking flow.
- Later enforcement: command completion should require audit append for selected low/medium-risk commands.
- Critical finance/payout commands must not become enforceable until audit append is reliable and immutable.

Validation failure in shadow mode:

- Record warning with command name, request ID, actor, failed validation, and risk tier.
- Do not prevent current adapter mutation.

Duplicate command detected:

- Shadow stage: warn and continue only if current adapter would have continued.
- Enforcement stage: return idempotent result if prior successful command exists, otherwise reject duplicate execution.

Compatibility rule:

No user-facing booking flow should break during shadow introduction.

Current adapter behavior that must remain compatible:

- Existing statuses and workflow stages.
- Existing result objects: `AdminAssignClinicianResult`, `AdminApprovePaymentResult`.
- Existing thrown exceptions for missing booking or missing requested clinician.
- Existing admin queue caller flows and snackbars.
- Existing `refreshAuthContextForFirestore` and `logFirestore` hooks.

Rollback posture:

- Most booking lifecycle commands can use compensating commands rather than raw rollback.
- Payout and accounting commands have limited rollback ability and require sovereign correction flow.
- Archive commands require audit correction rather than silent unarchive.
- `previousStateSnapshot` is mandatory before future enforcement to support rollback analysis.

## 10. Out Of Scope For W3

W3 does not include:

- Code implementation.
- Backend functions.
- Firestore rules.
- Custom claims.
- Payout enforcement.
- Payment enforcement.
- Deleting old adapter.
- Renaming old adapter.
- Room migration.
- Route migration.
- Audit collection creation.
- Registry runtime creation.
- Command collection creation.
- Lifecycle behavior changes.

## 11. W3 Final Recommendations

First safe implementation target after this spec:

- A shadow-only `AdminBookingCommandWrapper` around `assignClinician`, preserving the existing method result and calling the existing adapter internally.

Safest method to wrap first:

- `assignClinician`, because it already reads the booking first, has explicit missing-target validation, has a clear idempotent-ish already-assigned branch, and returns a typed result. It is still Critical, but structurally easier to envelope than payout/payment/financial archive commands.

Methods that must remain documentation-only until sovereign design:

- `approvePayment`
- `rejectPayment`
- `confirmCenterAccountingReview`
- `confirmCenterPayout`
- `confirmClinicianPayout`
- `sendToFinancialArchive`

Recommended W4 audit artifact spec:

- Define `booking_command_audit` and `booking_lifecycle_audit` event schemas.
- Include previous/new state, changed fields, actor snapshot, source route, source adapter, correlation ID, idempotency key, risk tier, validation warnings, and command result.
- Keep W4 as audit artifact specification only unless separately authorized.

