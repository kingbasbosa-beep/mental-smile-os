# GROUNDING-WAVE-4 / W4-1 Session Authority & Coupling Map

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Status: documentation/inventory only. No code was modified, no wrappers were created, no command runtime was added, no audit runtime was added, no collections were created, no Firebase rules or claims were changed, and no backend behavior was changed.

## 1. Executive Summary

Session lifecycle cannot be wrapped blindly because session state is highly coupled to multiple operational and sovereign-adjacent domains inside `booking_requests`.

Session actions may depend on or mutate:

- Payment approval.
- Payout readiness.
- Accounting review.
- Review completion.
- Archive readiness.
- Booking `status`.
- Booking `workflowStage`.

This makes session lifecycle riskier than the booking/center/chat shadow clusters already completed. A session wrapper that appears harmless can accidentally observe or normalize state that is financially or operationally final.

W4-1 therefore maps authority and coupling before any implementation.

## 2. Session Authority Matrix

| Actor | Current Session Powers | Collection(s) Mutated | Scope | Risk | Future Target |
| ----- | ---------------------- | --------------------- | ----- | ---- | ------------- |
| admin | Schedule sessions, schedule center residency, mark in progress, mark completed, move to reschedule, archive session, indirectly affect review/payout readiness. | `booking_requests` | Broad admin/direct operational authority. | Critical | Trusted session command wrapper with audit; no sovereign side effects. |
| client | Confirm/check in, submit payment proof/session-adjacent evidence, submit review. | `booking_requests`, `sessionRatings` | Own booking/session scope. | High | Tenant-scoped session evidence command/audit. |
| clinician | Respond to assigned workflow, update/complete session-adjacent state, submit review/profile/support artifacts. | `booking_requests`, `sessionRatings`, support/profile artifacts | Assigned clinician scope. | High | Professional-scoped session command/audit. |
| center | Respond to center/residency workflow, update center availability/session-adjacent state. | `booking_requests`, center profile/change artifacts | Center-scoped workflow. | Medium/High | Tenant/center-scoped command wrapper. |
| backend/system | No active trusted session lifecycle executor identified; health/status writers exist separately. | `system_domains` and trusted tooling implied, not session executor. | Planned/future only. | Medium | Backend command executor + audit appender. |
| future trusted command | Not implemented. Would validate state, scope, actor, previous state, audit readiness, and rollback posture. | Future command/audit artifacts plus controlled writes to `booking_requests`. | Scoped, policy-aware, backend-governed. | Future mitigation | Trusted Backend Command. |

Authority conclusion:

Admin is still the broadest session authority. Client/clinician/center actors have scoped session-adjacent mutation powers, but the runtime does not yet separate evidence submission, lifecycle transition, review completion, payout readiness, and archive finality.

## 3. Session State Transition Map

| Transition | Current Method / Surface | From State | To State | Actor | Coupled Fields | Risk |
| ---------- | ------------------------ | ---------- | -------- | ----- | -------------- | ---- |
| Schedule session | `AdminSessionDecisionAdapter.scheduleSession` / admin sessions page | `not_created` / setup state | `scheduled` | admin | `sessionStatus`, `status`, `workflowStage`, session date/time fields, payment setup context | Critical |
| Schedule center residency | `AdminSessionDecisionAdapter.scheduleCenterResidency` | center setup/residency state | scheduled/residency state | admin | `sessionStatus`, residency fields, center request state, payment context | Critical |
| Mark in progress | `AdminSessionDecisionAdapter.markInProgress` | `scheduled` | `in_progress` | admin | `sessionStatus`, `status`/`workflowStage` if present, timestamps | High |
| Mark completed | `AdminSessionDecisionAdapter.markCompleted` | `in_progress` / scheduled | `completed` | admin | `sessionStatus`, `reviewStatus`, `status`, `workflowStage`, payout readiness | Critical |
| Move to reschedule | `AdminSessionDecisionAdapter.moveToReschedule` | scheduled/in progress/exception | `reschedule_pending` | admin | `sessionStatus`, `status`, `workflowStage`, schedule fields | High |
| Client check-in | `client_sessions_page.dart` flow | scheduled/residency scheduled | check-in confirmed / residency started | client | `clientCheckInConfirmedAt`, `residencyStartedAt`, `sessionStatus`, `updatedAt` | High |
| Clinician completion/update | `clinician_operations_page.dart` flow | assigned/in progress | completed or clinician response state | clinician | `sessionStatus`, `completedAt`, clinician response fields, workflow state | High |
| Review submission | `session_review_page.dart` | completed/session review pending | review submitted / review completed markers | client/clinician | `sessionRatings`, `clientReviewSubmittedAt`, `clinicianReviewSubmittedAt`, `reviewStatus` | Medium/High |
| Session archive | `sendToSessionArchive` in admin adapters/pages | terminal/completed | `archived = true`, `archiveSection = sessions`, `archiveReady = true` | admin | archive fields, completion/review/payment/payout context | High |

## 4. Coupled Field Map

| Domain | Fields in / around `booking_requests` | Notes |
| ------ | ------------------------------------ | ----- |
| session domain | `sessionStatus`, `sessionCreatedAt`, `sessionDate`, `sessionTime`, `sessionMode`, `clientCheckInConfirmedAt`, `residencyStartedAt`, `completedAt` | Core session lifecycle and evidence fields. |
| payment domain | `paymentStatus`, `payment_confirmed`, `paymentSubmittedAt`, `paymentApprovedAt`, `paymentRejectedAt`, payment proof/evidence metadata | Session scheduling and progression can depend on payment state. |
| payout domain | `payoutStatus`, `payoutTransferredAt`, `netAmountDueToCenter` | Completion and archive can become payout-coupled. |
| accounting domain | `accountingReviewStatus`, `grossClientPaidAmount`, `appCommissionPercent`, `appCommissionAmount`, `accountingReviewNotes`, `accountingConfirmedBy`, `accountingConfirmedAt` | Center flow completion can depend on accounting review. |
| review domain | `reviewStatus`, `clientReviewSubmittedAt`, `clinicianReviewSubmittedAt`, review artifacts in `sessionRatings` | Completion can trigger or depend on review state. |
| archive domain | `archived`, `archivedAt`, `archiveSection`, `archiveReady` | Archive finality should become audit-backed. |
| booking workflow domain | `status`, `workflowStage`, `updatedAt` | Session transitions often mirror or drive booking workflow state. |

## 5. Dangerous Couplings

| Coupling | Why Dangerous | Risk |
| -------- | ------------- | ---- |
| Session completion -> payout readiness | Completion may imply payout eligibility or downstream financial finality. | Critical |
| Session completion -> review completion | Completion and reviews are interdependent; premature completion can distort service history. | High |
| Session archive -> financial archive confusion | Shared archive fields can blur session archive and payment/financial archive meaning. | Critical |
| Session schedule -> payment approval | Scheduling before/after payment state can affect service entitlement. | High |
| Reschedule/cancel -> payment/payout state | Reschedule exceptions can require refund, payment recheck, or payout blocking. | Critical |
| Client check-in -> session truth | Client evidence mutates operational truth and may influence completion/review/payout. | High |
| Clinician completion -> operational finality | Clinician-side completion can affect service record and review/payout readiness. | High |
| Admin override -> workflow stage | Admin direct writes can jump workflow state without command/audit guard. | Critical |

Highest-risk coupling:

```text
session completion / archive
<-> payout readiness / accounting / financial archive
```

This is the coupling most likely to cross from operational session management into sovereign finance/legal territory.

## 6. Candidate Shadow Commands

Command names only. Do not implement.

| Candidate Command | Real Method / Surface Basis | Notes |
| ----------------- | --------------------------- | ----- |
| `session.schedule` | `AdminSessionDecisionAdapter.scheduleSession` | High value, but scheduling may depend on payment/setup prerequisites. |
| `session.center_residency.schedule` | `AdminSessionDecisionAdapter.scheduleCenterResidency` | Center-specific setup; more coupled to center workflow. |
| `session.mark_in_progress` | `AdminSessionDecisionAdapter.markInProgress` | Lowest-risk admin session lifecycle candidate. |
| `session.mark_completed` | `AdminSessionDecisionAdapter.markCompleted` | High-risk finality candidate. |
| `session.move_to_reschedule` | `AdminSessionDecisionAdapter.moveToReschedule` | Exception path; payment/refund implications possible. |
| `session.client_check_in` | `client_sessions_page.dart` | Client evidence command candidate. |
| `session.clinician_complete` | `clinician_operations_page.dart` | Professional-scoped completion candidate. |
| `session.review.submit` | `session_review_page.dart` | Review artifact command candidate. |
| `session.archive` | `sendToSessionArchive` | Archive finality; audit needed first. |

## 7. Safe vs Unsafe Candidates

| Candidate Command | Safe for Shadow Now? | Why | Required Preconditions |
| ----------------- | -------------------- | --- | ---------------------- |
| `session.mark_in_progress` | safe now | Non-sovereign, non-final relative to completion/archive; likely admin-session scoped. | Confirm exact method signature and caller; passive only; no audit writes. |
| `session.schedule` | needs more inventory | Scheduling may depend on payment/setup/availability state. | Map payment prerequisites and schedule fields. |
| `session.center_residency.schedule` | needs more inventory | Center residency may couple center lifecycle and payment status. | Map center-specific state and fields. |
| `session.move_to_reschedule` | needs more inventory | Reschedule may imply cancellation/payment/refund implications. | Map exception states and payment coupling. |
| `session.client_check_in` | needs more inventory | Client evidence is scoped but can affect truth and residency start. | Map client-side write fields and ownership rules. |
| `session.clinician_complete` | needs more inventory | Professional completion can imply finality. | Map clinician completion fields and review/payout coupling. |
| `session.review.submit` | needs more inventory | Writes `sessionRatings` and updates booking review markers. | Map review artifacts and duplication/idempotency. |
| `session.mark_completed` | unsafe until audit design | Completion is finality-adjacent and payout/review coupled. | Audit event spec and rollback posture required. |
| `session.archive` | unsafe until sovereign/audit design | Archive finality needs immutable audit and payment/archive separation. | Audit archive spec and clear session vs financial boundary. |

## 8. Recommended W4-2

Recommendation:

```text
Option D - Create session command/audit spec before wrapping
```

Why:

- Session lifecycle is highly coupled to payment, payout, accounting, review, and archive readiness.
- Even the safest candidate, `session.mark_in_progress`, should have a minimal command/audit field contract first.
- A spec can define what must be logged, what must be excluded, and how to avoid financial/archive implications.
- This keeps Wave-4 disciplined and avoids turning session shadowing into accidental lifecycle enforcement.

W4-2 should define:

- Session command envelope fields.
- Session audit event candidates.
- Non-sovereign vs sovereign-adjacent boundaries.
- Minimal warning taxonomy for `session.mark_in_progress`.
- Rollback and no-enforcement posture.

W4-2 should not implement wrappers.

## 9. Frozen Boundaries

Must remain frozen:

- Payment.
- Payout.
- Accounting.
- Financial archive.
- Irreversible archive finalization.
- Session completion enforcement.
- Backend enforcement.
- Firestore rule changes.
- Custom claim changes.
- Audit runtime creation.
- Command runtime creation.
- Any action that implies financial/legal finality.

## Final Result

Session lifecycle is a valid future shadow domain, but it needs a session command/audit specification before implementation. The safest eventual wrapper candidate is `session.mark_in_progress`, but W4-2 should be a spec, not code.

Commands Executed By Codex:
None

