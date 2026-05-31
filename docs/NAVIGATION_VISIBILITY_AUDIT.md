# NAVIGATION VISIBILITY AUDIT

هذا التقرير يعتمد على:

1. `docs/MENTAL_SMILE_DOMAIN_OWNERSHIP_CONSTITUTION.md`
2. `docs/MENTAL_SMILE_FREEZE_AND_CLASSIFICATION_MAP.md`

هذا التقرير لا يغير navigation.
هذا التقرير لا يحذف routes.
هذا التقرير لا يعدل runtime.
هو فقط يحصر visibility قبل أي تنفيذ.

---

# 1. Executive Summary

الـ audit وجد إن مسارات Booking / Payment / Accounting / Legacy ما زالت ظاهرة في أكثر من طبقة navigation:

* العميل يرى `Bookings`, `Payment proof`, و`My sessions` مباشرة من `ClientDashboardPage`.
* العميل يقدر يبدأ `Request booking` من صفحة الأخصائي، ويقدر يرسل طلب مركز من صفحة المركز.
* الأدمن يرى `Payment monitoring gate`, `Session readiness signals`, `Accounting`, و`Archive` مباشرة من `AdminHubPage`.
* الأدمن يرى `Requests Queue`, `Payments Review`, و`Sessions & Scheduling` مباشرة من `AdminOperationsPage`.
* الأدمن يرى `Payments Archive` و`Accounting Archive` من `AdminArchivePage`.
* `AccountingWorkspacePage` يعرض مسارات مالية متعددة: payment proofs, approve/reject payment, freeze amount, dues, commission/tax, financial closing, ledgers.
* مقدم الخدمة يرى booking-related inbox/session surfaces: clinician sessions، center inbox، center residencies.
* فيه routes موجودة في router ومحمية role-based حتى لو مفيش CTA واضح لها حاليًا، مثل `/booking`, `/clinician/inbox`, وبعض legacy inboxes.
* فيه labels محتاجة تغيير لاحقًا من Booking/Payment/Sessions إلى Service Request / Legacy / Provider Coordination حسب قرار المالك.

الحكم العام: لا يتم حذف أي route الآن. الأولوية القادمة هي hide/rename لاحقًا للأسطح المالية والـ booking legacy بعد Owner Decision.

---

# 2. Audit Scope

تم فحص الملفات والمساحات التالية قراءة فقط:

* `lib/app/router/routes.dart`
* `lib/app/router/app_router.dart`
* `lib/features/home/presentation/pages/menu_page.dart`
* `lib/features/client/presentation/pages/client_dashboard_page.dart`
* `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
* `lib/features/centers/presentation/pages/center_dashboard_page.dart`
* `lib/features/centers/presentation/pages/center_details_page.dart`
* `lib/features/centers/presentation/pages/center_residencies_page.dart`
* `lib/features/admin_surface/pages/admin_hub_page.dart`
* `lib/features/admin_surface/pages/admin_operations_page.dart`
* `lib/features/admin_surface/pages/admin_archive_page.dart`
* `lib/features/admin_surface/pages/accounting_workspace_page.dart`
* `lib/features/admin_surface/admin_section_map.dart`
* `lib/features/admin_surface/pages/admin_booking_queue_page.dart`
* `lib/features/admin_surface/pages/admin_payments_page.dart`
* `lib/features/booking/presentation/pages/booking_page.dart`
* `lib/features/booking/presentation/pages/my_bookings_page.dart`
* `lib/features/booking/presentation/pages/clinician_inbox_page.dart`
* `lib/features/modules/presentation/pages/support_issue_selector_page.dart`
* `lib/features/specialists/presentation/specialist_details_page.dart`

مصطلح visibility هنا يشمل:

* زر ظاهر.
* كارت menu/dashboard.
* quick stat.
* section entry.
* archive tab/card.
* route constant أو router case موجود بدون CTA واضح.
* support option label يقود المستخدم لفكرة booking/payment حتى لو route نفسه support.

---

# 3. Navigation Inventory Table

| label الظاهر | target route | source file | source page/widget/function | actor/role | current classification | target classification | risk | recommended action |
|---|---|---|---|---|---|---|---|---|
| `Browse specialists and request a booking` / استعرض التخصصات وابدأ طلب الحجز | `/module/specialists` | `lib/features/home/presentation/pages/menu_page.dart` | `MenuPage.cards` | public/client | Core marketplace with booking wording | Core marketplace | Medium | KEEP BUT RELABEL |
| `Request booking` / طلب حجز | `/booking/request` | `lib/features/specialists/presentation/specialist_details_page.dart` | `SpecialistDetailsPage` CTA | client | Legacy booking entry | Optional Booking Module Candidate | High | MODULE ENTRY LATER |
| `Send request` / booking send request | `/booking/request` | `lib/features/booking/presentation/pages/booking_page.dart` | `BookingPage` list CTA | client | Legacy booking entry | Optional Booking Module Candidate | High | QUARANTINE |
| `My requests` icon | `/booking/my` | `lib/features/booking/presentation/pages/booking_page.dart` | `BookingPage.appBar` | client | Legacy booking | Optional Booking Module Candidate | High | HIDE LATER |
| `Bookings` / طلبات الحجز | `/booking/my` | `lib/features/client/presentation/pages/client_dashboard_page.dart` | `ClientDashboardPage.actionButtons` | client | Legacy booking | Optional Booking Module Candidate | High | HIDE LATER |
| `Payment proof` / إثبات التحويل النقدي | `/client/payment-proof` | `lib/features/client/presentation/pages/client_dashboard_page.dart` | `ClientDashboardPage.actionButtons` | client | Quarantined financial | Remove Later / module-scoped | Critical | HIDE LATER |
| `My sessions` / جلساتي | `/client/sessions` | `lib/features/client/presentation/pages/client_dashboard_page.dart` | `ClientDashboardPage.actionButtons` | client | Legacy session surface | Optional Booking Module Candidate | High | KEEP BUT RELABEL |
| `Request via admin` / طلب عبر الإدارة | `/booking/center-request` | `lib/features/centers/presentation/pages/center_details_page.dart` | visible bottom CTA | client | Legacy center booking request | Optional Booking Module Candidate | High | MODULE ENTRY LATER |
| disabled hidden center request CTA | `/booking/center-request` | `lib/features/centers/presentation/pages/center_details_page.dart` | `if (false)` block | client | Hidden legacy code path | Burial Candidate | Medium | BURIAL CANDIDATE |
| `Operations Room` primary shortcut | `/clinician/operations` | `lib/features/home/presentation/pages/menu_page.dart` | `_resolvePrimaryAction` | clinician | Core professional enablement | Core | Low | KEEP |
| `My sessions` | `/clinician/sessions` | `lib/features/clinician/presentation/pages/clinician_operations_page.dart` | `_buildOperationsActions` | clinician | Legacy session/booking surface | Optional Booking Module Candidate | High | KEEP BUT RELABEL |
| `Open cases` | `/clinician/chat-inbox` | `lib/features/clinician/presentation/pages/clinician_operations_page.dart` | `_buildOperationsActions`, `_buildChatCasesSummaryCard` | clinician | Support escalation | Core support / Control | Medium | KEEP |
| `Clinician inbox` route | `/clinician/inbox` | `lib/app/router/app_router.dart` | router-only protected route | clinician | Legacy booking inbox | Quarantined legacy | High | HIDE LATER |
| `Center Dashboard` shortcut | `/center/dashboard` | `lib/features/home/presentation/pages/menu_page.dart` | `_resolvePrimaryAction` | center | Center enablement | Core | Low | KEEP |
| `New requests` | `/center/inbox` | `lib/features/centers/presentation/pages/center_dashboard_page.dart` | `_SectionCard` | center | Legacy center booking inbox | Optional Booking Module Candidate | High | MODULE ENTRY LATER |
| `Active requests` | `/center/inbox` | `lib/features/centers/presentation/pages/center_dashboard_page.dart` | `_SectionCard` | center | Legacy center booking inbox | Optional Booking Module Candidate | High | MODULE ENTRY LATER |
| `Rejected requests` | `/center/inbox` | `lib/features/centers/presentation/pages/center_dashboard_page.dart` | `_SectionCard` | center | Legacy center booking inbox | Optional Booking Module Candidate | High | MODULE ENTRY LATER |
| `Completed requests` | `/center/residencies` | `lib/features/centers/presentation/pages/center_dashboard_page.dart` | `_SectionCard` | center | Legacy residency/session surface | Optional Booking Module Candidate | High | KEEP BUT RELABEL |
| `My sessions` / الإقامات | `/center/residencies` | `lib/features/centers/presentation/pages/center_dashboard_page.dart` | `_SectionCard` | center | Legacy residency/session surface | Optional Booking Module Candidate | High | KEEP BUT RELABEL |
| `Payment monitoring gate` | `/admin/payments` | `lib/features/admin_surface/pages/admin_hub_page.dart` | `compactCounters` | admin | Quarantined financial | Remove Later / module-scoped | Critical | HIDE LATER |
| `Session readiness signals` | `/admin/sessions` | `lib/features/admin_surface/pages/admin_hub_page.dart` | `compactCounters` | admin | Legacy session control | Optional Booking Module Candidate | High | KEEP BUT RELABEL |
| `Requests & Gates` | `/admin/operations` | `lib/features/admin_surface/pages/admin_hub_page.dart` | `mainSectionCards` | admin | Control entry exposing booking/payment/session | Control with quarantined subentries | High | KEEP BUT RELABEL |
| `Accounting` / قسم المحاسبة | `/admin/accounting` | `lib/features/admin_surface/pages/admin_hub_page.dart` | `departmentSectionCards` | admin | Quarantined financial/accounting | Optional Accounting Module | Critical | MODULE ENTRY LATER |
| `Archive` | `/admin/archive` | `lib/features/admin_surface/pages/admin_hub_page.dart` | `departmentSectionCards` | admin | Control archive mixed with financial legacy | Control + Legacy | Medium | KEEP BUT RELABEL |
| `Requests Queue` | `/admin/booking-queue` | `lib/features/admin_surface/pages/admin_operations_page.dart` | `_OperationsEntryCard` | admin | Quarantined booking queue | Optional Booking Module Candidate | Critical | QUARANTINE |
| `Payments Review` | `/admin/payments` | `lib/features/admin_surface/pages/admin_operations_page.dart` | `_OperationsEntryCard` | admin | Quarantined financial | Remove Later / module-scoped | Critical | HIDE LATER |
| `Sessions & Scheduling` | `/admin/sessions` | `lib/features/admin_surface/pages/admin_operations_page.dart` | `_OperationsEntryCard` | admin | Legacy booking/session | Optional Booking Module Candidate | High | KEEP BUT RELABEL |
| `Payments Archive` | `/admin/archive/payments` | `lib/features/admin_surface/pages/admin_archive_page.dart` | `_openSection('payments')` | admin | Legacy financial archive | Quarantined archive | High | HIDE LATER |
| `Accounting Archive` | `/admin/archive/accounting` | `lib/features/admin_surface/pages/admin_archive_page.dart` | `_openSection('accounting')` | admin | Legacy financial archive | Quarantined archive | High | HIDE LATER |
| `Sessions Archive` | `/admin/archive/sessions` | `lib/features/admin_surface/pages/admin_archive_page.dart` | `_openSection('sessions')` | admin | Legacy session archive | Legacy archive | Medium | KEEP BUT RELABEL |
| `Booking Monitoring & Exception Board` | `/admin/booking-queue` | `lib/features/admin_surface/admin_section_map.dart` | `adminSectionEntries` | admin/search/map | Quarantined booking | Optional Booking Module Candidate | Critical | QUARANTINE |
| `Payment Review & Payouts` | `/admin/payments` | `lib/features/admin_surface/admin_section_map.dart` | `adminSectionEntries` | admin/search/map | Quarantined financial | Remove Later / module-scoped | Critical | HIDE LATER |
| `Sessions Monitoring & Exception Control` | `/admin/sessions` | `lib/features/admin_surface/admin_section_map.dart` | `adminSectionEntries` | admin/search/map | Legacy session control | Optional Booking Module Candidate | High | KEEP BUT RELABEL |
| `Payments Ledger` | `/admin/archive/payments` | `lib/features/admin_surface/admin_section_map.dart` | `adminSectionEntries` | admin/search/map | Legacy financial archive | Quarantined archive | High | HIDE LATER |
| `Accounting Ledger` | `/admin/archive/accounting` | `lib/features/admin_surface/admin_section_map.dart` | `adminSectionEntries` | admin/search/map | Legacy financial archive | Quarantined archive | High | HIDE LATER |
| `Customer Payment Proofs` | `/admin/payments` | `lib/features/admin_surface/pages/accounting_workspace_page.dart` | `Payment & Transfer Review.actions` | admin | Quarantined financial | Remove Later / module-scoped | Critical | HIDE LATER |
| `Approve / Reject Payment` | `/admin/payments` | `lib/features/admin_surface/pages/accounting_workspace_page.dart` | `Payment & Transfer Review.actions` | admin | Quarantined financial | Remove Later / module-scoped | Critical | HIDE LATER |
| `Freeze Amount` | `/admin/payments` | `lib/features/admin_surface/pages/accounting_workspace_page.dart` | `Payment & Transfer Review.actions` | admin | Quarantined financial | Remove Later | Critical | BURIAL CANDIDATE |
| `Financial Closing` | `/admin/archive/accounting` | `lib/features/admin_surface/pages/accounting_workspace_page.dart` | `Dues & Financial Close.actions` | admin | Quarantined accounting | Optional Accounting Module | Critical | NEEDS OWNER DECISION |
| `Commission / Tax Deduction` | no route | `lib/features/admin_surface/pages/accounting_workspace_page.dart` | `Dues & Financial Close.actions` | admin | Forbidden financial semantics | Burial Candidate | Critical | BURIAL CANDIDATE |
| `Payments Ledger` | `/admin/archive/payments` | `lib/features/admin_surface/pages/accounting_workspace_page.dart` | `Financial Records.actions` | admin | Legacy financial archive | Quarantined archive | High | HIDE LATER |
| `Accounting Ledger` | `/admin/archive/accounting` | `lib/features/admin_surface/pages/accounting_workspace_page.dart` | `Financial Records.actions` | admin | Legacy financial archive | Quarantined archive | High | HIDE LATER |
| `Open payments queue` | `/admin/payments` | `lib/features/admin_surface/pages/admin_booking_queue_page.dart` | `_openPaymentsQueue` | admin | Quarantined financial handoff from booking | Remove Later | Critical | QUARANTINE |
| `Payment proof` page internals | `/client/payment-proof` | `lib/features/client/presentation/pages/client_payment_proof_page.dart` | page form/actions | client | Quarantined financial | Remove Later / module-scoped | Critical | HIDE LATER |
| `Booking issue` support option | `/module/support-issue-selector` | `lib/features/modules/presentation/pages/support_issue_selector_page.dart` | `_options(client/center)` | client/center | Core support with booking language | Core support | Medium | KEEP BUT RELABEL |
| `Payment follow-up` support option | `/module/support-issue-selector` | `lib/features/modules/presentation/pages/support_issue_selector_page.dart` | `_options(client)` | client | Core support with financial language | Core support | High | KEEP BUT RELABEL |
| `Payout question` support option | `/module/support-issue-selector` | `lib/features/modules/presentation/pages/support_issue_selector_page.dart` | `_options(center)` | center | Core support with payout language | Core support | High | KEEP BUT RELABEL |
| `Payment question` support option | `/module/support-issue-selector` | `lib/features/modules/presentation/pages/support_issue_selector_page.dart` | `_options(clinician)` | clinician | Core support with financial language | Core support | High | KEEP BUT RELABEL |

---

# 4. Client Visibility Findings

## كل الطرق التي تجعل العميل يرى payment proof

1. `ClientDashboardPage` يعرض كارت مباشر:
   * label: `Payment proof` / `إثبات التحويل النقدي`
   * route: `/client/payment-proof`
   * source: `lib/features/client/presentation/pages/client_dashboard_page.dart`
   * risk: Critical
   * recommended action: HIDE LATER بعد owner decision.

2. `SupportIssueSelectorPage` يعرض option:
   * label: `Payment follow-up` / `متابعة دفعة أو تحويل`
   * route: `/module/support-issue-selector`
   * source: `lib/features/modules/presentation/pages/support_issue_selector_page.dart`
   * risk: High
   * recommended action: KEEP BUT RELABEL إلى صياغة support غير مالية.

3. `ClientPaymentProofPage` نفسه يعرض labels داخل الصفحة:
   * `Payment proof`
   * `No request currently awaiting payment`
   * `Payment quote`
   * `Submit payment proof`
   * source: `lib/features/client/presentation/pages/client_payment_proof_page.dart`
   * risk: Critical
   * recommended action: HIDE LATER للمدخل، ثم BURIAL CANDIDATE بعد migration.

## كل الطرق التي تجعل العميل يرى booking

1. `MenuPage`:
   * label/subtitle: `Browse specialists and request a booking`
   * route: `/module/specialists`
   * risk: Medium
   * recommended action: KEEP BUT RELABEL.

2. `SpecialistDetailsPage`:
   * label: `Request booking`
   * route: `/booking/request`
   * risk: High
   * recommended action: MODULE ENTRY LATER.

3. `BookingPage`:
   * labels: `Send request`, `My requests`
   * routes: `/booking/request`, `/booking/my`
   * risk: High
   * recommended action: QUARANTINE / HIDE LATER.

4. `ClientDashboardPage`:
   * label: `Bookings`
   * route: `/booking/my`
   * risk: High
   * recommended action: HIDE LATER.

5. `CenterDetailsPage`:
   * label: center request via admin
   * route: `/booking/center-request`
   * risk: High
   * recommended action: MODULE ENTRY LATER.

## Client verdict

العميل يرى الـ financial/booking كأنها جزء طبيعي من dashboard. هذا يتعارض مع الدستور لو اتفهم إن Mental Smile تملك booking/payment. لا يتم حذف أي شيء الآن، لكن أول hide لاحق بأقل خطر غالبًا هو كارت `Payment proof` من dashboard، مع إبقاء route للتوافق لحين قرار المالك.

---

# 5. Provider Visibility Findings

## clinician visibility

| item | route | source | current classification | risk | recommended action |
|---|---|---|---|---|---|
| `My sessions` | `/clinician/sessions` | `ClinicianOperationsPage._buildOperationsActions` | Legacy session/booking | High | KEEP BUT RELABEL |
| `Open cases` | `/clinician/chat-inbox` | `ClinicianOperationsPage` | Support escalation | Medium | KEEP |
| `Clinician inbox` | `/clinician/inbox` | router-only / `ClinicianInboxPage` | Legacy booking inbox | High | HIDE LATER |
| `Payment question` support option | `/module/support-issue-selector` | `SupportIssueSelectorPage` | Support with financial language | High | KEEP BUT RELABEL |

ملاحظة مهمة: `ClinicianInboxPage` يحتوي guard واضح أن legacy inbox demoted ومقروء من `booking_requests`. هذا يؤكد أنه توافق legacy وليس مسار Core.

## center visibility

| item | route | source | current classification | risk | recommended action |
|---|---|---|---|---|---|
| `New requests` | `/center/inbox` | `CenterDashboardPage` | Legacy booking inbox | High | MODULE ENTRY LATER |
| `Active requests` | `/center/inbox` | `CenterDashboardPage` | Legacy booking inbox | High | MODULE ENTRY LATER |
| `Rejected requests` | `/center/inbox` | `CenterDashboardPage` | Legacy booking inbox | High | MODULE ENTRY LATER |
| `Completed requests` | `/center/residencies` | `CenterDashboardPage` | Legacy residency/session | High | KEEP BUT RELABEL |
| `My sessions` / `الإقامات` | `/center/residencies` | `CenterDashboardPage` | Legacy residency/session | High | KEEP BUT RELABEL |
| `Payout question` support option | `/module/support-issue-selector` | `SupportIssueSelectorPage` | Support with payout language | High | KEEP BUT RELABEL |

## Provider verdict

مقدم الخدمة ما زال يرى request/session/inbox language مرتبطة بالـ booking legacy. المطلوب لاحقًا ليس الحذف الفوري، بل إعادة تسمية وفصل module entry. الـ center inbox غالبًا يحتاج Owner Decision لأنه قد يكون مستخدمًا تشغيليًا حاليًا.

---

# 6. Admin / Control Visibility Findings

## كل الطرق التي تجعل admin يرى payments/accounting

1. `AdminHubPage.compactCounters`
   * `Payment monitoring gate` -> `/admin/payments`
   * risk: Critical
   * action: HIDE LATER.

2. `AdminHubPage.departmentSectionCards`
   * `Accounting` -> `/admin/accounting`
   * subtitle: `Payment Review & Payouts, Payments Ledger, and Accounting Ledger`
   * risk: Critical
   * action: MODULE ENTRY LATER / NEEDS OWNER DECISION.

3. `AdminOperationsPage`
   * `Payments Review` -> `/admin/payments`
   * risk: Critical
   * action: HIDE LATER.

4. `AdminArchivePage`
   * `Payments Archive` -> `/admin/archive/payments`
   * `Accounting Archive` -> `/admin/archive/accounting`
   * risk: High
   * action: HIDE LATER, keep read-only legacy if needed.

5. `AccountingWorkspacePage`
   * `Customer Payment Proofs` -> `/admin/payments`
   * `Approve / Reject Payment` -> `/admin/payments`
   * `Freeze Amount` -> `/admin/payments`
   * `Financial Closing` -> `/admin/archive/accounting`
   * `Payments Ledger` -> `/admin/archive/payments`
   * `Accounting Ledger` -> `/admin/archive/accounting`
   * un-routed but visible: `Commission / Tax Deduction`
   * risk: Critical
   * action: NEEDS OWNER DECISION / BURIAL CANDIDATE for commission wording.

6. `admin_section_map.dart`
   * `Payment Review & Payouts`
   * `Payments Ledger`
   * `Accounting Ledger`
   * risk: Critical/High
   * action: HIDE LATER / RELABEL.

## admin sees booking/session

1. `AdminOperationsPage`
   * `Requests Queue` -> `/admin/booking-queue`
   * `Sessions & Scheduling` -> `/admin/sessions`

2. `AdminHubPage`
   * `Open request signals` -> `/admin/operations`
   * `Session readiness signals` -> `/admin/sessions`
   * `Requests & Gates` -> `/admin/operations`

3. `admin_section_map.dart`
   * `Booking Monitoring & Exception Board`
   * `Sessions Monitoring & Exception Control`
   * `Session Report`

4. `AdminBookingQueuePage`
   * `_openPaymentsQueue` -> `/admin/payments`
   * payout confirmation methods exist in same page.

## Admin verdict

`/admin/hub` يعرض frozen routes كأنها operational control surface. أخطرها payment/accounting. `Requests & Gates` أقل خطر لأنه control wrapper، لكنه يحتاج relabel واضح أن هذه legacy/quarantined visibility وليست core operations.

---

# 7. Quarantined Route Exposure

| route | exposure type | visible from UI? | actors | risk | recommended action |
|---|---|---|---|---|---|
| `/client/payment-proof` | dashboard card + router | Yes | client | Critical | HIDE LATER |
| `/admin/payments` | hub counter, operations card, accounting actions, booking queue handoff, router | Yes | admin | Critical | HIDE LATER |
| `/admin/accounting` | hub department card + router | Yes | admin | Critical | MODULE ENTRY LATER |
| `/admin/archive/payments` | archive section, accounting workspace, admin section map, router | Yes | admin | High | HIDE LATER |
| `/admin/archive/accounting` | archive section, accounting workspace, admin section map, router | Yes | admin | High | HIDE LATER |
| `/admin/booking-queue` | operations card, admin section map, router | Yes | admin | Critical | QUARANTINE |
| `/booking/my` | client dashboard, booking page appbar, router | Yes | client | High | HIDE LATER |
| `/admin/sessions` | hub counter, operations card, admin section map, router | Yes | admin | High | KEEP BUT RELABEL |
| `/booking/request` | specialist details, booking page, router | Yes | client | High | MODULE ENTRY LATER |
| `/booking/center-request` | center details, router; one disabled duplicate | Yes | client | High | MODULE ENTRY LATER |
| `/clinician/inbox` | router-only/legacy page | Not obvious in current UI | clinician | High | HIDE LATER |
| `/center/inbox` | center dashboard cards, router | Yes | center | High | MODULE ENTRY LATER |

---

# 8. Hidden / Router-Only Routes

| route | router status | UI exposure found | classification | note | recommended action |
|---|---|---|---|---|---|
| `/booking` | router case exists | no primary menu CTA found, app can open directly | Legacy booking | Lists clinicians and sends booking requests | QUARANTINE |
| `/clinician/inbox` | protected clinician route exists | no clear dashboard CTA found; legacy page exists | Quarantined legacy | `ClinicianInboxPage` says compatibility inbox | HIDE LATER |
| `/chat/clinician/inbox` | legacy alias exists | no direct visible CTA found | Legacy alias | retained for old deep links | KEEP for compatibility until owner decision |
| `/booking/center-request` | protected client route exists | visible from `CenterDetailsPage`; one `if(false)` hidden duplicate | Legacy center request | active visible bottom CTA | MODULE ENTRY LATER |
| `/admin/session-report` | admin route exists | opened from `AdminPaymentsPage` and section map | Legacy report | report around session/payment flow | KEEP BUT RELABEL |
| `/admin/archive/sessions` | admin route exists | archive home/accounting workspace | Legacy archive | session archive from booking records | KEEP BUT RELABEL |

---

# 9. Relabel Candidates

| current label | source | route | suggested future language | reason |
|---|---|---|---|---|
| `Bookings` / طلبات الحجز | `ClientDashboardPage` | `/booking/my` | `طلبات الخدمة القديمة` أو `Service Requests` | يقلل فكرة booking core |
| `Payment proof` / إثبات التحويل النقدي | `ClientDashboardPage` | `/client/payment-proof` | `Legacy payment proof` مؤقتًا أو hide | financial core ممنوع دستوريًا |
| `Request booking` / طلب حجز | `SpecialistDetailsPage` | `/booking/request` | `Request service connection` أو `طلب تواصل مع مقدم الخدمة` | marketplace لا يملك booking |
| `Request via admin` | `CenterDetailsPage` | `/booking/center-request` | `Request center contact` أو `طلب تواصل مع المركز` | لا تجعل الإدارة مالكة للحجز |
| `My sessions` | `ClientDashboardPage`, `ClinicianOperationsPage`, `CenterDashboardPage` | session routes | `Legacy sessions` أو `Provider coordination` | الجلسات ليست مملوكة للمنصة |
| `Requests Queue` | `AdminOperationsPage` | `/admin/booking-queue` | `Legacy request queue` | تجميد booking_requests |
| `Payments Review` | `AdminOperationsPage` | `/admin/payments` | `Legacy payment review` أو hide | financial quarantine |
| `Payment monitoring gate` | `AdminHubPage` | `/admin/payments` | `Legacy payment signals` أو hide | لا يظهر كـ core gate |
| `Accounting` | `AdminHubPage` | `/admin/accounting` | `Optional Accounting Module Preview` | المحاسبة optional |
| `Payment Review & Payouts` | `admin_section_map.dart` | `/admin/payments` | `Legacy payment visibility` | payout ممنوع كـ core |
| `Commission / Tax Deduction` | `AccountingWorkspacePage` | none | remove/hide later | commission core ممنوع |
| `Booking issue` | `SupportIssueSelectorPage` | support route | `Service request issue` | support لا يملك booking |
| `Payment follow-up` | `SupportIssueSelectorPage` | support route | `Legacy payment question` أو `billing-related support` فقط داخل module | financial language خطر |
| `Payout question` | `SupportIssueSelectorPage` | support route | `Provider account question` | يمنع payout ownership |

---

# 10. Hide Later Candidates

أقل خطر للإخفاء لاحقًا بعد موافقة المالك:

1. كارت `Payment proof` من `ClientDashboardPage`.
   * السبب: financial proof ليس core، route يمكن أن يظل للتوافق بدون CTA.

2. `Payment monitoring gate` من `AdminHubPage`.
   * السبب: يظهر financial surface كأنه control/core signal.

3. `Payments Review` من `AdminOperationsPage`.
   * السبب: يفتح `/admin/payments` مباشرة.

4. `Payments Archive` و`Accounting Archive` من الواجهة العامة للأرشيف.
   * السبب: يمكن إبقاؤهم كـ direct/admin-only deep links مؤقتًا مع تقليل الظهور.

5. `My requests` icon داخل `BookingPage`.
   * السبب: duplicate exposure لـ `/booking/my`.

6. أي mention لـ `Commission / Tax Deduction`.
   * السبب: يتعارض مباشرة مع الدستور إذا فهم كمنطق عمولة جلسات.

إخفاء لاحق بحذر أعلى:

* `/booking/my` من client dashboard، لأنه قد يكون ضروري للتوافق مع بيانات قديمة.
* `/center/inbox` من center dashboard، لأنه قد يكون workflow تشغيلي قائم.
* `/admin/booking-queue` من operations، لأنه قد يكون admin containment الحالي.

---

# 11. Module Entry Later Candidates

| current route | future module candidate | reason |
|---|---|---|
| `/booking/request` | Optional Booking Module أو Service Connection Module | طلب موعد/تواصل ليس core |
| `/booking/center-request` | Optional Booking Module أو Center Service Request Module | تنسيق مركز وليس marketplace core |
| `/booking/my` | Optional Booking Module legacy viewer | عرض بيانات قديمة أو module-scoped requests |
| `/center/inbox` | Optional Booking Module provider inbox | center request handling should be tenant/module-scoped |
| `/clinician/sessions` | Optional Booking Module / Professional Workspace | session logistics ليست care ownership |
| `/center/residencies` | Optional Center Module | الإقامات/الجلسات module-scoped |
| `/admin/accounting` | Optional Accounting Module | محاسبة اختيارية tenant-scoped |
| `/admin/payments` | Optional Accounting Module legacy bridge أو Burial Candidate | payment proof/confirmation خارج core |
| `/admin/sessions` | Optional Booking Module monitoring | session readiness ليس control core |

---

# 12. Owner Decisions Needed

1. هل يتم إخفاء `Payment proof` من client dashboard فورًا لاحقًا مع إبقاء route direct للتوافق؟

2. هل `/booking/request` يتحول لغويًا إلى `Service Request` أو `Provider Contact Request`، أم يظل `Booking` داخل module اختياري؟

3. هل `center request via admin` مطلوب تشغيليًا الآن، أم يتحول إلى `contact center` بدون booking semantics؟

4. هل `/admin/payments` مطلوب كـ legacy containment لفترة، أم يتم دفنه بعد archive؟

5. هل `/admin/accounting` سيصبح Optional Accounting Module حقيقي، أم Burial Candidate؟

6. هل `/center/inbox` و`/clinician/inbox` مطلوبين للتوافق فقط أم ما زالوا workflow فعلي؟

7. هل `session` labels يجب تتحول إلى `coordination`, `provider schedule`, أو `legacy sessions`؟

8. هل financial archive يجب يظل ظاهر في admin archive، أم يتحول إلى hidden direct route فقط؟

9. هل support options التي تقول `Payment`, `Payout`, `Booking` يتم relabel فقط، أم تزال من structured support؟

10. هل `Commission / Tax Deduction` مجرد placeholder غير مستخدم أم يجب دفنه فورًا في أول package تنفيذي؟

---

# 13. Final Verdict

الـ navigation الحالي ما زال يكشف booking/payment/accounting كأنهم مسارات تشغيل طبيعية داخل المنتج. هذا لا يعني تنفيذ حذف الآن، لكنه يثبت أن أول مرحلة تنفيذ آمنة لاحقًا يجب أن تكون visibility containment:

* hide financial CTAs أولًا.
* relabel booking/session wording ثانيًا.
* keep direct routes مؤقتًا للتوافق.
* extract module entries لاحقًا بعد Owner Decision.
* لا يتم لمس Firestore rules قبل tests وقرار مالك.

الإجابات المختصرة على أسئلة التقرير:

1. العميل يرى payment proof من client dashboard، ومن support option، ومن page internals.
2. الأدمن يرى payments/accounting من admin hub، admin operations، accounting workspace، archive، admin section map، وbooking queue handoff.
3. clinician/center يتعاملوا مع booking inbox عبر clinician legacy inbox route، clinician sessions، center dashboard inbox cards، center residencies.
4. نعم، `/menu` يستخدم booking wording في specialists subtitle، و`/admin/hub` يعرض payments/sessions/accounting كأنهم operational core.
5. نعم، فيه router-only أو hidden/fallback routes مثل `/booking`, `/clinician/inbox`, `/chat/clinician/inbox`, وdisabled center CTA.
6. أقل شيء خطر يمكن إخفاؤه لاحقًا: payment proof dashboard card، payment monitoring gate، payments review، financial archive entries.
7. ما يجب أن يبقى مؤقتًا للتوافق: `/booking/my`, `/admin/booking-queue`, `/center/inbox`, `/admin/archive/*`, direct routes.
8. يحتاج Owner Decision: accounting module، payment route burial، center/clinician inbox fate، booking-to-service relabel.
9. نعم، يوجد routes لا تظهر بوضوح في UI لكنها موجودة في router.
10. نعم، labels كثيرة تحتاج تغيير من Booking/Payment/Sessions إلى Service/Provider/Legacy أو module-scoped language.

هذا التقرير لا يغير navigation.
هذا التقرير لا يحذف routes.
هذا التقرير لا يعدل runtime.
هو فقط يحصر visibility قبل أي تنفيذ.
