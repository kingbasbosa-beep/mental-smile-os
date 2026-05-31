# GROUNDING-WAVE-4 / W4-0 Session Lifecycle Runtime Inventory

Mental Smile - Grounding Era

Commands Executed By Codex:
None

Status: inventory only. No code was modified, no wrappers were created, no command runtime was added, no audit runtime was added, no collections were created, no Firebase rules or claims were changed, and no backend behavior was changed.

Note: This inventory is based on prior Grounding inspection context from W1-W3 and known session-related files/surfaces. No repository commands were executed during W4-0.

## 1. Session Runtime Overview

Session lifecycle is currently implemented primarily as fields on booking request documents rather than as a separate first-class session collection.

Primary runtime collection:

```text
booking_requests
```

Known session-related fields include:

- `sessionStatus`
- `status`
- `workflowStage`
- `sessionCreatedAt`
- `sessionDate`
- `sessionTime`
- `sessionMode`
- `residencyStartedAt`
- `clientCheckInConfirmedAt`
- `completedAt`
- review fields such as `reviewStatus`, `clientReviewSubmittedAt`, `clinicianReviewSubmittedAt`
- archive fields such as `archived`, `archivedAt`, `archiveSection`, `archiveReady`

Session lifecycle authority is distributed across:

- Admin session adapter and admin session pages.
- Admin booking/payment/archive flows.
- Client session pages.
- Clinician operations/session flows.
- Center residency/session-related surfaces.
- Review submission page.

Current runtime remains legacy/hybrid:

```text
UI / service adapter
 -> direct Firestore update
 -> booking_requests
```

There is no dedicated trusted backend session command executor, no session audit runtime, and no session command collection.

## 2. Session Authority Map

| Actor | Creates Sessions | Updates Sessions | Completes Sessions | Archives Sessions | Overrides Session State | Actual Authority |
| ----- | ---------------- | ---------------- | ------------------ | ---------------- | ----------------------- | ---------------- |
| Admin | Yes, through admin session/booking adapters | Yes | Yes | Yes, through archive actions | Yes | Broad admin UI + Firestore admin claim + adapter writes |
| Clinician | No formal session creation authority identified; can affect lifecycle through clinician operations | Yes, for assigned workflow/session actions | Yes, through clinician operations completion flow | No direct archive authority identified | Limited workflow mutation | Clinician-scoped rules/ownership plus page/service logic |
| Center | No formal session creation authority identified; can affect residency/availability/session-adjacent state | Yes, center/residency-related updates | Possibly through residency lifecycle, not final archive | No direct archive authority identified | Limited center-scoped workflow mutation | Center-scoped rules/ownership plus center pages/services |
| Client | No session creation authority | Yes, check-in/payment proof/review-related updates | No direct completion authority; can confirm/check in/review | No archive authority | No formal override | Client-scoped rules/ownership plus client pages |
| Backend | No active trusted backend session executor identified | Trusted tooling implied only for some system artifacts | No active backend session lifecycle executor identified | No active backend archive executor identified | Not implemented | Planned future only |

Authority conclusion:

Admin currently has the broadest session lifecycle authority. Clinician, center, and client flows mutate session-adjacent fields, but final lifecycle and archive authority remains heavily admin-centric.

## 3. Session Collections

| Collection | Purpose | Primary Writers | Primary Readers |
| ---------- | ------- | --------------- | --------------- |
| `booking_requests` | Primary operational truth for booking, payment, session, review, payout, and archive lifecycle. | Admin adapters/pages, client pages, clinician pages, center services/pages. | Admin, related client, related clinician, related center. |
| `bookingRequests` | Legacy fallback booking collection referenced by some code paths; Firestore rules deny access. | Legacy/fallback code paths may attempt updates. | Legacy fallback readers in code. |
| `sessionRatings` | Session review/rating artifacts. | Client/clinician review page. | Admin and related users. |
| `chat_threads` | Chat/support continuity around booking/session context. | Chat service, booking legacy chat adapter, chat page. | Participants/admins. |
| `system_domains` | Domain health/status including booking/session-adjacent health emissions. | App health services/admin/system services. | Admin. |

No dedicated `sessions` collection was confirmed in prior Grounding inventory. Session truth appears embedded in `booking_requests`.

## 4. Session Mutation Inventory

| Method / Flow | File Location | Collection(s) Touched | Authority Level | Risk Level |
| ------------- | ------------- | --------------------- | --------------- | ---------- |
| `AdminSessionDecisionAdapter.updateRequestEverywhere` | `lib/features/admin_surface/data/services/admin_session_decision_adapter.dart` | `booking_requests` | Admin direct | Critical |
| `AdminSessionDecisionAdapter.scheduleSession` | `admin_session_decision_adapter.dart` | `booking_requests` | Admin direct | Critical |
| `AdminSessionDecisionAdapter.scheduleCenterResidency` | `admin_session_decision_adapter.dart` | `booking_requests` | Admin direct | Critical |
| `AdminSessionDecisionAdapter.markInProgress` | `admin_session_decision_adapter.dart` | `booking_requests` | Admin direct | High |
| `AdminSessionDecisionAdapter.markCompleted` | `admin_session_decision_adapter.dart` | `booking_requests` | Admin direct | Critical |
| `AdminSessionDecisionAdapter.moveToReschedule` | `admin_session_decision_adapter.dart` | `booking_requests` | Admin direct | High |
| Admin booking adapter `confirmCenterPayout` / `confirmClinicianPayout` side effects | `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | `booking_requests` | Admin direct / sovereign-adjacent | Critical |
| Admin archive session action `sendToSessionArchive` | `admin_booking_decision_adapter.dart`, payment/session archive surfaces | `booking_requests` | Admin direct | High |
| Admin payments/session archive variants | `admin_payment_decision_adapter.dart` and admin payment/session pages | `booking_requests` | Admin direct / finance-adjacent | High/Critical |
| Client check-in/session update flow | `lib/features/client/presentation/pages/client_sessions_page.dart` | `booking_requests` | Client scoped | High |
| Client review submission updates | `lib/features/reviews/presentation/pages/session_review_page.dart` | `sessionRatings`, `booking_requests` | Client/clinician scoped | Medium |
| Clinician operations request update/completion | `lib/features/clinician/presentation/pages/clinician_operations_page.dart` | `booking_requests`, `sessionRatings`, support/profile artifacts | Clinician scoped | High |
| Clinician sessions view/fallback reads | `lib/features/clinician/presentation/pages/clinician_sessions_page.dart` | `booking_requests`, `bookingRequests` | Clinician scoped read/fallback | Medium |
| Center residency/session-adjacent view | `lib/features/centers/presentation/pages/center_residencies_page.dart` | `booking_requests` | Center scoped | Medium |
| Center request/session-adjacent services | `center_inbox_service.dart`, `center_request_inbox_service.dart` | `booking_requests`, legacy fallback in some paths | Center scoped | High |
| Booking health emission | `lib/features/booking/data/services/booking_health_service.dart` | `system_domains` | System/app-side writer | Medium/High |

Highest-risk session mutation paths:

- Admin session scheduling.
- Admin session completion.
- Admin reschedule exceptions.
- Admin session archive.
- Client/clinician session state changes that alter lifecycle truth.
- Any session action coupled to payment, payout, or accounting status.

## 5. Lifecycle State Map

Known lifecycle/status fields are spread across `status`, `workflowStage`, `sessionStatus`, `reviewStatus`, `payoutStatus`, and archive fields.

Observed or previously inventoried states include:

| Field | Known States / Values | Notes |
| ----- | --------------------- | ----- |
| `sessionStatus` | `not_created`, `scheduled`, `in_progress`, `completed`, `cancelled` | Main session lifecycle marker. |
| `status` / `workflowStage` | `session_setup_pending`, `session_scheduled`, `reschedule_pending`, `cancellation_pending`, `completed_success`, `payout_pending`, `rejected_admin`, `awaiting_payment`, `payment_review` | Booking-level state often drives session posture. |
| `reviewStatus` | `not_started`, `blocked`, `completed` | Review lifecycle coupled to session completion. |
| `payoutStatus` | `blocked`, `paid_to_center`, `paid_to_clinician` | Sovereign/financial coupling. |
| Archive fields | `archived`, `archiveReady`, `archiveSection = sessions/payments` | Archive finality sits on booking request docs. |

Lifecycle shape:

```text
not_created
 -> scheduled
 -> in_progress
 -> completed
 -> review/completion/archive readiness
```

Exception paths:

```text
scheduled/in_progress
 -> reschedule_pending
 -> scheduled
```

```text
pending/session states
 -> cancellation_pending / cancelled
```

Financially coupled path:

```text
completed
 -> review completed
 -> payout pending/confirmed
 -> completed_success
 -> archiveReady
```

## 6. Archive Inventory

Session archive is currently represented by fields on `booking_requests`, not a confirmed dedicated archive collection.

Known archive fields:

- `archived`
- `archivedAt`
- `archiveSection`
- `archiveReady`

Known session archive method:

```text
sendToSessionArchive
```

Known related locations:

- `AdminBookingDecisionAdapter.sendToSessionArchive`
- `AdminPaymentDecisionAdapter.sendToSessionArchive`
- Admin archive/session pages
- Admin archive sessions page

Archive authority:

- Currently admin direct.
- No trusted backend archive executor identified.
- No append-only audit archive confirmed.

Archive risk:

- High for session archive.
- Critical when archive overlaps with financial archive or payout/accounting finality.

## 7. Payment Coupling Analysis

Coupling level:

```text
HIGH
```

Reason:

Session lifecycle is materially coupled to:

- Payment approval/rejection.
- Payment proof/evidence.
- Session scheduling after payment or center approval.
- Review completion.
- Payout readiness.
- Payout confirmation.
- Financial/session archive status.

Examples:

- `approvePayment` can move requests into `session_scheduled` or `session_setup_pending`.
- `confirmCenterPayout` and `confirmClinicianPayout` set `sessionStatus = completed`, `reviewStatus = completed`, and payout status.
- `sendToFinancialArchive` and `sendToSessionArchive` share archive flags and can be confused if not command/audit separated.

Conclusion:

Session shadow work must avoid payment, payout, accounting, and financial archive methods until sovereign audit/command design exists.

## 8. Candidate Shadow Commands

Candidate names only. Do not implement.

| Current Flow | Candidate Shadow Command | Notes |
| ------------ | ------------------------ | ----- |
| Schedule session | `session.schedule` | Admin session lifecycle. |
| Schedule center residency | `session.center_residency.schedule` | Center/residency-specific session setup. |
| Mark in progress | `session.mark_in_progress` | Non-final but lifecycle-significant. |
| Mark completed | `session.complete` | High-risk finality candidate. |
| Move to reschedule | `session.reschedule.request` | Exception path candidate. |
| Client check-in | `session.client_check_in.confirm` | Client-scoped lifecycle evidence. |
| Submit review | `session.review.submit` | Review artifact and booking marker. |
| Send to session archive | `session.archive.send` | Archive finality candidate. |

Excluded for now:

- `payout.confirm_*`
- `payment.approve_*`
- `payment.reject_*`
- `accounting.confirm_*`
- `archive.send_to_financial_archive`

## 9. Frozen Areas

Remain frozen for Wave-4 first implementation decisions:

- Payment approval/rejection.
- Payout confirmation.
- Accounting review.
- Financial archive.
- Any method that sets payout status.
- Any method that computes commission/net amounts.
- Any method that makes legal/financial finality claims.
- Firebase rules and claims.
- Backend enforcement.
- Audit runtime.
- Command runtime.
- Broad session adapter refactor.

## 10. Safest First Candidate

Safest first candidate:

```text
session.mark_in_progress
```

Likely current method:

```text
AdminSessionDecisionAdapter.markInProgress
```

Why this is the lowest-risk candidate:

- It is session lifecycle related but does not appear to create the session from scratch.
- It is less final than `session.complete`.
- It is less financially coupled than payout/accounting/archive flows.
- It can be passively shadowed with envelope + warnings + delegation.
- Rollback remains local if wired through admin session UI only.

Why not start with `session.complete`:

- Completion can trigger review, payout readiness, archive readiness, and operational finality.

Why not start with `session.archive.send`:

- Archive finality needs audit posture first.

Why not start with `session.schedule`:

- Scheduling may depend on payment, client/clinician/center availability, and setup prerequisites.

## 11. W4-1 Recommendation

Recommended next step:

```text
Option B - Authority mapping follow-up
```

Reason:

- Session lifecycle is highly coupled to payment/payout/accounting/archive.
- The safest command candidate appears to be `session.mark_in_progress`, but exact UI caller and method signature should be confirmed in a narrow follow-up before wiring.
- Session state is distributed across admin, clinician, client, center, and review surfaces.
- A single method wrapper before confirming caller/signature/state boundaries could accidentally shadow the wrong authority layer.

W4-1 should inspect only:

- `AdminSessionDecisionAdapter`
- admin sessions page caller for `markInProgress`
- related session status state fields

W4-1 should not implement yet unless the method signature and caller are clear and non-sovereign.

## Final Inventory Result

Session lifecycle is a valid future shadow command domain, but it is riskier than chat escalation because it is tightly coupled to payment, payout, review, completion, and archive state.

The lowest-risk implementation candidate appears to be:

```text
session.mark_in_progress
```

But the recommended immediate next step is a narrow authority mapping follow-up before any wrapper.

Commands Executed By Codex:
None

