# BOOKING_LEGACY_INVENTORY

هذا التقرير تحليل فقط.

لم يتم تعديل Runtime code.
لم يتم تعديل Firestore rules.
لم يتم تعديل routes.
لم يتم حذف ملفات.
لم يتم عمل refactor.
لم يتم عمل rename.
لم يتم عمل migration.

المرجعيات الحاكمة:

* `docs/MENTAL_SMILE_DOMAIN_OWNERSHIP_CONSTITUTION.md`
* `docs/MENTAL_SMILE_FREEZE_AND_CLASSIFICATION_MAP.md`
* `docs/NAVIGATION_VISIBILITY_AUDIT.md`
* `docs/SAFE_VISIBILITY_CONTAINMENT_PLAN.md`

الحكم الدستوري:

```text
booking_requests = Frozen + Quarantined + Legacy Candidate
```

---

# 1. Collection Inventory

## 1.1 `booking_requests`

`booking_requests` هي collection مركزية legacy تحمل أكثر من دومين في نفس الوثيقة. هذا هو سبب تصنيفها كـ `Frozen + Quarantined + Legacy Candidate`.

| field / field family | field purpose | status | domain owner | consumers | producers |
|---|---|---|---|---|---|
| `requestKind` | يفرق بين clinician request وcenter request | Active legacy | Legacy Booking Requests Domain | client, center, admin, archive | booking request pages |
| `requestGroupId` | grouping/copy flow للطلبات المتكررة أو center request copies | Active legacy | Legacy Booking Requests Domain | client booking list, reports | `MyBookingsPage`, center request copy flow |
| `clientId`, `clientName`, `clientEmail` | تعريف العميل صاحب الطلب | Active legacy | Client Support / Legacy bridge | client, admin, center/clinician views | booking request pages |
| `clinicianId`, `clinicianName` | provider target في clinician booking flow | Active legacy | Marketplace bridge + Legacy Booking | client, clinician, admin | specialist booking flow |
| `assignedClinicianId`, `assignedClinicianName` | clinician assignment بعد admin/flow decision | Active legacy | Legacy Booking + Control | clinician operations, admin queue, reports | admin queue/adapters |
| `clinicianUid` | fallback/legacy clinician pointer | Legacy / mostly disabled | Legacy compatibility | old clinician inbox if enabled | older flows / compatibility |
| `centerId`, `centerName`, `selectedCenterType`, `centerHasDetoxUnit` | center request target/context | Active legacy | Center Enablement bridge + Legacy Booking | center dashboard/inbox, client booking list, admin | center details/request flow |
| `selectedAccommodationKey`, `selectedAccommodationLabelAr`, `selectedAccommodationPrice`, `selectedAccommodationPricingUnit`, `selectedAccommodationPricingSnapshot` | residency/accommodation pricing snapshot | Active legacy | Center Module candidate | client booking list, center residencies, accounting/archive | center request flow |
| `contractDraft` / contract-like nested data | legacy draft of center service terms | Active legacy | Optional Booking/Accounting candidate | client/admin/center flows | center request copy/create flow |
| `note`, `clientNote`, `adminNote`, decision notes | free-text context and admin/provider notes | Active legacy | Mixed support/control | admin, provider, support/archive | client/provider/admin actions |
| `status` | central lifecycle state | Critical active legacy | Legacy Booking Requests Domain | almost every consumer | client/provider/admin/adapters |
| `workflowStage` | secondary lifecycle marker | Active legacy | Legacy Booking Requests Domain | admin/booking pages | booking flow producers |
| `createdAt`, `updatedAt` | ordering and audit timestamps | Active | Shared audit | all list/report consumers | all producers |
| `adminApproved`, `adminRejected`, `adminForwarded` | admin decision flags | Active legacy | Control | admin queue, reports | admin adapters/wrappers |
| `adminDecisionType`, `adminDecisionBy`, `adminDecisionAt`, `adminAssignedBy`, `adminAssignedAt` | admin decision audit | Active legacy | Control | admin, archive, reports | admin queue/adapters |
| `clinicianAccepted`, `clinicianRejected`, `clinicianCompleted`, `clinicianRespondedAt` | clinician lifecycle flags | Active legacy | Professional Enablement bridge | clinician operations, admin sessions | clinician pages |
| `approvedSlot` | clinician suggested/approved timing | Active legacy | Optional Booking Module candidate | client, clinician, admin | clinician inbox/operations |
| `paymentStatus`, `payment_confirmed`, `paymentConfirmed` | payment gate/status | Quarantined financial | Legacy Financial Cycle | client payment proof, admin payments, admin booking queue, archive | client payment proof/admin payment adapter |
| `paymentReceiptFileName`, `paymentClientNote`, `paymentSubmittedAt`, `paymentApprovedAt`, payment proof fields | payment proof metadata | Quarantined financial | Legacy Financial Cycle | client payment proof, admin payments, archive/accounting | client payment proof page/admin adapters |
| `paymentBreakdownText`, price/quote fields | payment quote display | Quarantined financial | Legacy Financial Cycle | client payment proof, booking list, archive | booking/admin/center flows |
| `payoutStatus`, `payoutTransferredAt`, payout fields | provider/center payout state | Quarantined financial | Legacy Financial Cycle | admin booking queue, archive assistant/accounting | admin booking queue/adapters |
| `sessionStatus`, `sessionDateText`, `sessionCode`, `sessionLink`, session fields | session/link/scheduling visibility | Legacy session coordination | Optional Booking Module candidate | client sessions, clinician sessions, admin sessions, center residencies | admin session adapter/provider updates |
| `reviewStatus`, `finalReviewPercentage`, review fields | review completion state | Mixed Trust + Legacy Booking | Trust & Transparency target owner | session review, admin reports, archive | review page/admin reports |
| `threadId`, `escalationId`, chat linkage fields | support/chat linkage | Mixed support + legacy | Client Support target owner | admin support, chat, archive | booking legacy chat adapter/chat services |
| `bookingLinked`, `bookingRequestId` in related chat docs | cross-link from chat to request | Quarantined compatibility | Support + Legacy bridge | chat pages, clinician chat inbox | booking legacy chat adapter/chat firestore service |
| `archived`, `archiveSection`, `archivedAt` | archive routing and archive sections | Active legacy archive | Control archive | admin archive pages, assistant | admin archive/session/payment/report flows |
| type/status labels and denormalized names | UI display and fallback fields | Active legacy | Mixed | all UI consumers | all producers |

### Collection verdict

`booking_requests` ليست collection دومين واحد. هي legacy container يجمع:

* request intake
* booking coordination
* provider assignment
* payment proof
* payment confirmation
* payout
* session/scheduling
* support/chat linkage
* review status
* archive/report metadata

هذا يخالف doctrine:

```text
No collection may own multiple domains.
```

## 1.2 `bookingRequests`

`bookingRequests` هي collection compatibility قديمة.

| field / behavior | purpose | status | owner | consumers | producers |
|---|---|---|---|---|---|
| mirrored booking request fields | old camelCase compatibility | Legacy | Legacy compatibility | old fallback logic only | disabled/guarded legacy paths |
| reads/writes in rules | denied in current rules | Burial Candidate | Control / Legacy | none intended | none intended |
| fallback references | rollback compatibility | Frozen | Legacy compatibility | clinician inbox/adapters guarded by flags | disabled by local flags |

### Collection verdict

`bookingRequests` هي `Burial Candidate`.

مسموح فقط:

* audit
* compatibility awareness
* migration inventory

ممنوع:

* إعادة تفعيل writes
* استخدامها كfallback runtime أساسي
* بناء features جديدة عليها

---

# 2. Route Inventory

| route | purpose | current usage | target classification |
|---|---|---|---|
| `/booking` | legacy clinician booking listing page | direct/router-only plus internal booking page | Quarantined / Optional Booking Module Candidate |
| `/booking/request` | create clinician booking request | specialist details CTA and booking page | Optional Booking Module Candidate |
| `/booking/center-request` | create center request | center details CTA | Optional Booking Module Candidate |
| `/booking/my` | client legacy request list | client dashboard/booking page | Legacy viewer / Optional Booking Module Candidate |
| `/client/payment-proof` | client payment proof upload | direct route, formerly dashboard card | Quarantined financial / Remove Later |
| `/client/sessions` | client session/link visibility | client dashboard | Legacy coordination / Optional Booking Module Candidate |
| `/clinician/inbox` | old clinician booking inbox | router-only/legacy compatibility | Quarantined legacy |
| `/clinician/sessions` | clinician session/coordination page | clinician operations | Optional Booking Module Candidate |
| `/center/inbox` | center request inbox | center dashboard | Optional Booking Module Candidate |
| `/center/residencies` | center residency/service activity records | center dashboard | Optional Center/Booking Module Candidate |
| `/admin/booking-queue` | admin queue over `booking_requests` | admin operations and section map | Quarantined / Control containment |
| `/admin/payments` | payment proof/confirmation admin surface | admin operations/hub/accounting | Quarantined financial |
| `/admin/accounting` | accounting workspace | admin hub | Optional Accounting Module Candidate |
| `/admin/sessions` | admin session/coordination control | admin operations/hub | Optional Booking Module Candidate |
| `/admin/session-report` | report around session/payment/request lifecycle | admin payments and route map | Legacy report |
| `/admin/archive/sessions` | archived session/service coordination records | admin archive/accounting workspace | Legacy archive |
| `/admin/archive/payments` | archived payment records | admin archive/accounting workspace | Quarantined financial archive |
| `/admin/archive/accounting` | archived accounting records | admin archive/accounting workspace | Quarantined financial archive |
| `/admin/archive/reports` | reports archive reading request/review data | admin archive | Legacy reports / Trust bridge |
| `/admin/archive/clinicians` | clinician archive; can read request history | admin archive/accounting workspace | Legacy archive |
| `/admin/archive/centers` | center archive; can read request history | admin archive | Legacy archive |
| `/admin/archive/support` | support archive; can include request-linked support | admin archive | Support archive / Legacy bridge |
| `/session/review` | review page tied to requestId/session | client/provider review flow | Trust target with legacy request bridge |
| `/chat/clinician/inbox` | legacy alias for clinician chat inbox | old deep links | Legacy alias |
| `/chat/escalations` | escalations, sometimes request-linked | admin/clinician support flow | Control + Support, not booking-owned |
| `/chat/escalation/report` | reports for escalated chat cases | escalation flow | Control + Support |

### Route verdict

Routes لا يجب حذفها الآن. بعضها visible navigation، وبعضها deep-link/router-only. الهدف المستقبلي: تقليل visibility، ثم module extraction أو burial حسب قرار المالك.

---

# 3. Service Inventory

## Booking services / adapters / wrappers / controllers

| file | purpose | read responsibilities | write responsibilities | dependencies | risk |
|---|---|---|---|---|---|
| `lib/features/booking/data/services/booking_health_service.dart` | health snapshot for booking domain | counts `booking_requests` by status such as awaiting payment/payment review | writes `system_domains/booking` status | Firestore, `system_domains`, `booking_requests` | Medium |
| `lib/features/booking/data/services/center_inbox_service.dart` | center inbox service for center requests | reads center-related `booking_requests` | likely updates request state | Firestore, center request docs | High |
| `lib/features/booking/data/services/center_request_inbox_service.dart` | center request inbox workflow | reads request data | likely status/action writes | Firestore, `booking_requests` | High |
| `lib/features/booking/data/services/booking_legacy_chat_adapter.dart` | bridge booking requests into chat threads | reads reusable chat threads / booking links | writes `chat_threads`, messages, booking link metadata | `chat_threads`, `booking_requests` | Critical |
| `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | admin booking decisions | reads `booking_requests` | updates admin decision/status/payment/session/payout-related fields | Firestore, booking requests | Critical |
| `lib/features/admin_surface/data/services/admin_payment_decision_adapter.dart` | admin payment confirmation/rejection | reads `booking_requests` | updates payment fields | Firestore, booking requests | Critical |
| `lib/features/admin_surface/data/services/admin_session_decision_adapter.dart` | admin session lifecycle decisions | reads `booking_requests` | updates session fields | Firestore, booking requests | High |
| `lib/features/admin_surface/data/commands/admin_booking_command_wrapper.dart` | audit/shadow wrapper for admin booking commands | reads target request before command | writes command audit and delegates updates | Firestore, booking_requests, command metadata | High |
| `lib/features/chat/data/services/chat_firestore_service.dart` | chat threads and escalations | reads chat threads/escalations, booking-linked metadata | writes chat messages, links booking to thread | `chat_threads`, `chat_escalations`, booking link fields | Medium |
| `lib/features/chat/controller/chat_controller.dart` | chat runtime controller | filters booking follow-up threads | archives/starts threads | chat firestore service, booking-linked flags | Medium |

## Booking pages acting as producers/consumers

| file | purpose | read responsibilities | write responsibilities | dependencies | risk |
|---|---|---|---|---|---|
| `lib/features/booking/presentation/pages/booking_page.dart` | legacy booking entry/list specialists | reads `clinicians` | opens `/booking/request` | clinicians, router | Medium |
| `lib/features/booking/presentation/pages/booking_request_page.dart` | create clinician booking request | reads args/provider context | creates `booking_requests` and chat follow-up | Firestore, booking legacy chat adapter | Critical |
| `lib/features/booking/presentation/pages/center_booking_request_page.dart` | create center request | reads center/admin context | creates `booking_requests`, may notify/open admin chat | centers, admins, booking_requests | Critical |
| `lib/features/booking/presentation/pages/my_bookings_page.dart` | client list and actions | reads `booking_requests` by `clientId` | can create copied center requests; may update/cancel/review flow | booking_requests, session review route | Critical |
| `lib/features/booking/presentation/pages/clinician_inbox_page.dart` | legacy clinician inbox | reads assigned `booking_requests` | updates clinician decisions/status/payment/session init flags | booking_requests, optional `bookingRequests` fallback disabled | High |
| `lib/features/booking/presentation/pages/center_inbox_page.dart` | center inbox | reads center-related requests | updates center responses/status | booking_requests | High |
| `lib/features/client/presentation/pages/client_payment_proof_page.dart` | client proof submission | reads awaiting payment requests | writes payment proof fields | booking_requests | Critical |
| `lib/features/client/presentation/pages/client_sessions_page.dart` | client coordination/session visibility | reads session fields from requests | likely no major writes | booking_requests | High |
| `lib/features/clinician/presentation/pages/clinician_sessions_page.dart` | clinician coordination/session visibility | reads assigned requests/session fields | action writes may exist | booking_requests | High |
| `lib/features/centers/presentation/pages/center_residencies_page.dart` | center activity/residency records | reads center request/session data | may open review/updates | booking_requests, session review | High |
| `lib/features/admin_surface/pages/admin_booking_queue_page.dart` | admin request queue | reads booking requests | writes admin decisions, payout, assignment, handoff | booking_requests, chat_threads, adapters | Critical |
| `lib/features/admin_surface/pages/admin_payments_page.dart` | admin payment surface | reads payment review requests | writes payment approval/rejection | booking_requests, payment adapter | Critical |
| `lib/features/admin_surface/pages/admin_sessions_page.dart` | admin session/coordination surface | reads session-related requests | writes session decision fields | booking_requests, session adapter | High |
| `lib/features/admin_surface/pages/admin_archive_*` | archive pages | reads archived request data by section/context | mostly read/archive support | booking_requests, sessionRatings | Medium/High |
| `lib/features/reviews/presentation/pages/session_review_page.dart` | review completion | reads request from booking collection | writes `sessionRatings`, updates review/session close status | booking_requests, sessionRatings | High |

### Service verdict

No service should be expanded. All booking/payment/session services should be considered freeze-contained until a module extraction plan exists.

---

# 4. UI Dependency Map

## Consumers by actor

```text
Client
  -> ClientDashboardPage
  -> MyBookingsPage
  -> BookingPage / BookingRequestPage
  -> CenterBookingRequestPage
  -> ClientPaymentProofPage
  -> ClientSessionsPage
  -> SessionReviewPage

Clinician
  -> ClinicianOperationsPage
  -> ClinicianInboxPage
  -> ClinicianSessionsPage
  -> ClinicianChatInboxPage (booking-linked labels only)

Center
  -> CenterDashboardPage
  -> CenterInboxPage
  -> CenterResidenciesPage
  -> CenterDetailsPage creates center request from client side

Admin
  -> AdminHubPage
  -> AdminOperationsPage
  -> AdminBookingQueuePage
  -> AdminPaymentsPage
  -> AccountingWorkspacePage
  -> AdminSessionsPage
  -> AdminArchivePage
  -> AdminArchivePaymentsPage
  -> AdminArchiveAccountingPage
  -> AdminArchiveSessionsPage
  -> AdminArchiveReportsPage

Reports / Analytics
  -> Admin archive pages
  -> ArchiveAssistantEngine
  -> Analytics summaries / functions
  -> sessionRatings bridge

Support
  -> ChatPage
  -> ChatFirestoreService
  -> ChatEscalationsPage
  -> SupportIssueSelectorPage
  -> AdminSupportChatPage
```

## Text dependency map

```text
booking_requests
  -> client request history
  -> payment proof workflow
  -> clinician assignment workflow
  -> center request workflow
  -> admin queue workflow
  -> session coordination workflow
  -> review closure workflow
  -> archive/report workflow
  -> chat/support follow-up bridge
```

### UI verdict

`booking_requests` is still a runtime backbone for legacy UI. Visibility can be reduced, but removal would break multiple role journeys.

---

# 5. Firestore Dependency Map

## Direct collections

```text
booking_requests
bookingRequests
sessionRatings
chat_threads
chat_threads/{threadId}/messages
chat_escalations
chat_escalations/{escalationId}/reports
clinicians
centers
admins
system_domains
analytics_summaries
```

## References / joins / lookups

| dependency | direction | purpose | risk |
|---|---|---|---|
| `booking_requests.clientId -> clients/auth uid` | implicit | client ownership and list filtering | Critical |
| `booking_requests.clinicianId / assignedClinicianId -> clinicians` | direct/implicit | provider assignment/display | High |
| `booking_requests.centerId -> centers` | direct/implicit | center request and dashboard display | High |
| `booking_requests.requestId -> sessionRatings.requestId` | direct | review linkage | High |
| `chat_threads.bookingRequestId -> booking_requests/{id}` | indirect | booking follow-up chat | High |
| `chat_escalations.bookingRequestId -> booking_requests/{id}` | indirect | escalated support link | Medium |
| `booking_requests.threadId -> chat_threads/{id}` | indirect | support thread lookup | Medium |
| `booking_requests.archiveSection -> admin archive filters` | direct field classification | archive section routing | High |
| `system_domains/booking` | aggregate health target | booking health status | Medium |
| `analytics_summaries` | aggregate reporting | operational summaries | Medium |

## Aggregate flows

```text
booking_requests by status
  -> admin hub counters
  -> booking health service
  -> admin operations signals

booking_requests by paymentStatus
  -> admin payment review
  -> accounting workspace
  -> financial archive

booking_requests by sessionStatus/status
  -> client sessions
  -> clinician sessions
  -> admin sessions
  -> center residencies

booking_requests archived=true + archiveSection
  -> admin archive pages
  -> archive assistant
  -> reports archive
```

---

# 6. Rules Dependency Map

لا يتم تعديل rules في هذا التقرير.

## Known rules touchpoints

| rule match | dependency | complexity | risk |
|---|---|---|---|
| `match /booking_requests/{requestId}` | read/list for admin or own booking, create validation, update by admin or user update | High | Critical |
| `match /bookingRequests/{requestId}` | deny read/write | Low | Low, but resurrection risk |
| `match /sessionRatings/{ratingId}` | requires `requestId` and reviewer ownership | Medium | High due requestId legacy bridge |
| `match /chat_threads/{threadId}` | thread owner/assigned clinician/admin access; messages subcollection | Medium | Medium |
| `match /chat_escalations/{escalationId}` | admin or assigned clinician access; reports subcollection | Medium | Medium |
| `match /support_requests/{requestId}` | structured support independent of booking but can receive booking/payment issue labels | Low/Medium | Medium |

## Rules risk

The `booking_requests` rule is high-risk because it protects a multi-domain document. Any future rules change may accidentally affect:

* client request history
* payment proof writes
* admin decision writes
* clinician updates
* center updates
* session/report/review closure
* archive reads

Rules should not be touched before:

* ownership split
* route classification
* emulator tests
* owner approval

---

# 7. Runtime Risk Classification

| element | classification | reason |
|---|---|---|
| `booking_requests` collection | Critical | central live legacy container |
| `bookingRequests` collection | Dead / Burial Candidate | rules deny, fallback disabled, legacy only |
| `/booking/request` | Critical | creates clinician request |
| `/booking/center-request` | Critical | creates center request |
| `/booking/my` | High | client legacy request visibility |
| `/client/payment-proof` | Critical | financial proof writes |
| `/client/sessions` | High | session visibility from legacy fields |
| `/clinician/inbox` | Medium/High | demoted legacy compatibility |
| `/clinician/sessions` | High | provider coordination |
| `/center/inbox` | High | center request workflow |
| `/center/residencies` | High | center service activity / session-like records |
| `/admin/booking-queue` | Critical | admin control over legacy request state |
| `/admin/payments` | Critical | payment approval/rejection |
| `/admin/accounting` | High | financial visibility surface |
| `/admin/sessions` | High | session coordination control |
| `/admin/archive/payments` | Medium/High | legacy financial archive |
| `/admin/archive/accounting` | Medium/High | legacy accounting archive |
| `AdminBookingDecisionAdapter` | Critical | writes core legacy states |
| `AdminPaymentDecisionAdapter` | Critical | writes financial fields |
| `AdminSessionDecisionAdapter` | High | writes session fields |
| `AdminBookingCommandWrapper` | High | containment/audit around admin commands |
| `BookingLegacyChatAdapter` | Critical | cross-domain chat/request bridge |
| `BookingHealthService` | Medium | aggregate health only |
| `CenterInboxService` / `CenterRequestInboxService` | High | center request workflow |
| `ChatFirestoreService.linkBookingToThread` | Medium/High | cross-link support and legacy booking |
| `SessionReviewPage` | High | bridges booking_requests to sessionRatings |
| archive assistant accounting logic | Medium | reporting only but financial semantics |

---

# 8. Module Survivability Analysis

## Can survive as Optional Booking Module

These can survive only if moved into a tenant/module-scoped boundary:

* request intake for provider contact
* center contact/request coordination
* availability/scheduling visibility
* provider inbox for service requests
* client legacy request viewer
* admin exception board for module-scoped booking
* session coordination metadata, if renamed and bounded as coordination
* booking-linked chat handoff, if owned by support/module bridge policy

Required future module properties:

```text
Optional Booking Module
tenant-scoped
not core dependency
no payment ownership
no payout ownership
no accounting ownership
clear archive behavior
separate support/review/report collections
```

## Should not survive inside Booking Module

These should be removed or moved to separate modules:

* payment proof
* payment confirmation
* payout
* commission
* settlement
* accounting ledger
* financial archive
* trust ratings as lifecycle gates
* support complaints as booking-owned fields

## Should become separate domains/modules

| current data/function | future owner |
|---|---|
| ratings/reviews | Trust & Transparency Domain |
| complaints/support | Client Support Domain |
| payment/accounting | Optional Accounting Module or burial |
| provider profile/price disclosure | Marketplace + Trust |
| content/support education | Education & Library |
| chat escalation | Client Support + Control |

---

# 9. Burial Candidates

لا يتم حذف أي شيء هنا. هذه قائمة ترشيح فقط.

| candidate | reason | risk if removed now | recommendation |
|---|---|---|---|
| `bookingRequests` collection | legacy camelCase, rules deny, fallback disabled | Low/Unknown | Burial after data verification |
| `_legacyBookingRequestsWriteEnabled` guarded mirror writes | disabled compatibility | Low/Medium | keep until formal cleanup |
| `_legacyClinicianUidReadEnabled` guarded read path | disabled legacy clinician pointer | Low/Medium | keep until owner confirms no legacy data |
| `/chat/clinician/inbox` | old deep link alias | Medium | keep as alias until deep-link audit |
| disabled `if (false)` center booking CTA block | dead UI block | Low | burial candidate, no touch now |
| payment proof dashboard entry | already hidden in visibility containment | Low if route remains | keep route, bury later |
| commission/tax wording | forbidden core semantics | Low as copy; high as concept | copy containment now, burial later |
| archive assistant accounting export semantics | legacy reporting and financial wording | Medium | quarantine/report-only |
| `AdminPaymentDecisionAdapter` | direct financial writes | Critical if removed now | freeze, replace after accounting decision |
| payout confirm methods in admin queue | financial closure semantics | Critical if removed now | freeze, no expansion |
| `BookingLegacyChatAdapter` | cross-domain bridge | Critical if removed now | freeze, replace with support-owned bridge later |

---

# 10. Final Verdict

## Is `booking_requests` a Domain?

No.

It is not a valid domain because it owns too many responsibilities:

* booking
* request intake
* payment
* payout
* accounting
* session coordination
* review closure
* support/chat linkage
* archive/report routing

## Is `booking_requests` a Module?

Not yet.

It can become the source inventory for a future Optional Booking Module, but as-is it is not module-scoped, not tenant-bounded, and not cleanly separated from financial/support/trust concerns.

## Is `booking_requests` a Workflow?

Partially.

It currently behaves like a central workflow engine for legacy requests. But that workflow crosses domain boundaries and should not be expanded.

## Is `booking_requests` a Legacy Container?

Yes.

The most accurate technical classification is:

```text
booking_requests = Legacy Container
                 + Frozen Runtime Dependency
                 + Quarantined Cross-Domain Store
                 + Optional Booking Module Source Inventory
                 + Burial Candidate for financial/session overreach
```

Technical explanation:

`booking_requests` is still live enough that deleting or blocking it would break client, provider, center, admin, archive, review, and support flows. But architecturally it is invalid as a future core platform primitive. It must be contained, audited, and split into domain-owned or module-owned surfaces over time.

---

# Output Counts

Approximate inventory counts from current known project surfaces:

| item | count |
|---|---:|
| booking/session/payment/report related routes | 25 |
| booking services / service-like runtime units | 10 |
| explicit adapters | 4 |
| pages directly consuming or producing booking legacy data | 18 |
| rules touchpoints | 6 |
| consumer groups | 7 |

Consumer groups:

1. client
2. clinician
3. center
4. admin
5. reports
6. analytics
7. support

Final constraint reminder:

هذا التقرير لا ينفذ أي تعديل.
هذا التقرير لا يعدل Runtime.
هذا التقرير لا يعدل Firestore rules.
هذا التقرير لا يعدل routes.
هذا التقرير لا يحذف أو يدفن أي عنصر.
هو فقط inventory وتحليل legacy قبل أي تنفيذ لاحق.
