# SAFE VISIBILITY CONTAINMENT PLAN

هذا التقرير يعتمد على:

1. `docs/MENTAL_SMILE_DOMAIN_OWNERSHIP_CONSTITUTION.md`
2. `docs/MENTAL_SMILE_FREEZE_AND_CLASSIFICATION_MAP.md`
3. `docs/NAVIGATION_VISIBILITY_AUDIT.md`

هذا التقرير لا يغير UI.
هذا التقرير لا يحذف routes.
هذا التقرير لا يعدل runtime.
هو فقط يحول audit إلى خطة containment آمنة.

---

# 1. Executive Summary

الهدف هنا ليس دفن الـ legacy الآن، ولا تعديل Firestore rules، ولا حذف أي route.

الهدف هو تقليل ظهور المسارات المجمدة والخطرة تدريجيًا من غير كسر:

* deep links
* legacy data
* protected router cases
* صفحات مستخدمة حاليًا في workflow
* توافق `booking_requests`

الخطة مقسمة إلى 3 مستويات:

* Level 1: تغييرات copy/hide صغيرة جدًا، بدون حذف route أو page.
* Level 2: مداخل تتحول لاحقًا إلى Optional Module Entry، ولا نخفيها فورًا.
* Level 3: عناصر ممنوع لمسها الآن للتوافق أو لأنها تحتاج Owner Decision أو tests.

أول micro-change آمن لاحقًا يفضل يكون:

```text
Hide Payment proof card from ClientDashboardPage only
+
Relabel Request booking wording
+
Relabel financial support options
+
No route deletion
+
No rules change
```

---

# 2. Level 1 Safe Hide / Copy Change Candidates

هذه أقل تغييرات خطورة لاحقًا لأنها تغيّر visibility أو copy فقط. لا تحذف route، لا تحذف page، ولا تعدل rules.

| العنصر | source file | current label | proposed label/action | why safe | risk | required test/manual check |
|---|---|---|---|---|---|---|
| Client payment card | `lib/features/client/presentation/pages/client_dashboard_page.dart` | `Payment proof` / `إثبات التحويل النقدي` | Hide card من dashboard فقط. route `/client/payment-proof` يظل موجود | يقلل financial core exposure بدون كسر deep links أو page | Medium | login كـ client، dashboard يفتح، باقي cards موجودة، direct route ما زال يعمل |
| Admin payment counter | `lib/features/admin_surface/pages/admin_hub_page.dart` | `Payment monitoring gate` | Hide quick stat أو relabel إلى `Legacy payment signals` | admin hub لا يعرض payment كأنه core signal | Medium | login كـ admin، hub layout لا يكسر، counters الأخرى تظهر |
| Admin operations payment entry | `lib/features/admin_surface/pages/admin_operations_page.dart` | `Payments Review` | Hide card أو relabel إلى `Legacy payment review` | route يبقى، لكن operations لا يدفع admin لمسار مالي كأنه core | Medium | admin operations page تفتح، Requests/Sessions cards لا تتأثر |
| Admin archive payment section | `lib/features/admin_surface/pages/admin_archive_page.dart` | `Payments Archive` | Hide section من archive landing أو relabel إلى `Legacy payments archive` | archive route يبقى direct للتوافق | Medium | archive page تفتح، non-financial archive sections تعمل |
| Admin archive accounting section | `lib/features/admin_surface/pages/admin_archive_page.dart` | `Accounting Archive` | Hide section من archive landing أو relabel إلى `Legacy accounting archive` | يقلل financial archive visibility بدون حذف page | Medium | archive section switching لا يكسر |
| Accounting workspace commission wording | `lib/features/admin_surface/pages/accounting_workspace_page.dart` | `Commission / Tax Deduction` | Hide item أو rename إلى `Legacy finance placeholder - disabled` | commission ممنوع كـ core، والitem بلا route ظاهر | Low/Medium | accounting page تفتح، item لا يوحي بعمولة جلسات |
| Client support payment option | `lib/features/modules/presentation/pages/support_issue_selector_page.dart` | `Payment follow-up` / متابعة دفعة أو تحويل | `Account/support follow-up` أو `Legacy billing question` | support يبقى، لكن بدون financial ownership | Low | client support selector يظهر options، submit يعمل |
| Center support payout option | `lib/features/modules/presentation/pages/support_issue_selector_page.dart` | `Payout question` | `Provider account question` | يمنع إيحاء أن المنصة تملك payout core | Low | center support selector يظهر، submit يعمل |
| Client/center support booking option | `lib/features/modules/presentation/pages/support_issue_selector_page.dart` | `Booking issue` | `Service request issue` | يقلل booking-as-core semantics | Low | support request created بنفس keys أو مع migration-aware label فقط |
| Clinician support payment option | `lib/features/modules/presentation/pages/support_issue_selector_page.dart` | `Payment question` | `Account/support question` | يمنع financial authority wording | Low | clinician support selector يظهر |
| Main menu specialists subtitle | `lib/features/home/presentation/pages/menu_page.dart` | `Browse specialists and request a booking` | `Browse specialists and request provider contact` أو `Browse specialists and compare services` | route `/module/specialists` core ويظل كما هو | Low | public menu يفتح، specialists card يعمل |
| Specialist CTA | `lib/features/specialists/presentation/specialist_details_page.dart` | `Request booking` | `Request provider contact` أو `Request service connection` | نفس route مؤقتًا، لكن copy لا يجعل booking core | Medium | details page يفتح، CTA يظل يرسل لنفس route |
| BookingPage send CTA | `lib/features/booking/presentation/pages/booking_page.dart` | `Send request` داخل booking context | `Send provider contact request` | يقلل booking language مع بقاء route | Medium | `/booking` direct يفتح ويعمل legacy flow |
| Center details CTA | `lib/features/centers/presentation/pages/center_details_page.dart` | `Request via admin` / center booking request | `Request center contact` أو `Ask center to contact me` | يقلل admin-owned booking semantics | Medium | center details page وCTA يفتحان route الحالي |
| Client dashboard bookings card | `lib/features/client/presentation/pages/client_dashboard_page.dart` | `Bookings` / طلبات الحجز | `Service requests` أو `Legacy requests` | route `/booking/my` يبقى للتوافق | Medium | dashboard count لا يكسر، route يعمل |
| Session labels | `ClientDashboardPage`, `ClinicianOperationsPage`, `CenterDashboardPage`, `AdminOperationsPage`, `AdminHubPage` | `My sessions`, `Sessions & Scheduling`, `Session readiness signals` | `Provider coordination`, `Legacy sessions`, أو `Service coordination` | يقلل امتلاك care/session relationship | Medium | كل role dashboard يفتح، routes لا تتغير |

## Level 1 rule

أي تغيير لاحق في Level 1 يجب أن يلتزم بالتالي:

* لا حذف route constants.
* لا حذف router cases.
* لا حذف page files.
* لا تغيير Firestore rules.
* لا تغيير collection names.
* أي hide يكون من navigation فقط.
* أي relabel لا يغير keys أو data model إلا لو package منفصل مع tests.

---

# 3. Level 2 Module Entry Later Candidates

هذه عناصر لا نخفيها فورًا. يتم إعادة تصنيفها لاحقًا كمداخل Optional Module أو legacy bridge.

| route | يبقى مؤقتًا أم يختفي؟ | module direction | Owner Decision? | الخطر لو اتشال الآن |
|---|---|---|---|---|
| `/booking/request` | يبقى مؤقتًا | Optional Booking Module أو Service Connection Module | نعم | كسر CTA من specialist details وBookingPage، وتعطيل إنشاء طلبات legacy |
| `/booking/center-request` | يبقى مؤقتًا | Optional Booking Module أو Center Contact Request Module | نعم | كسر CTA من center details، وتعطيل center request workflow |
| `/booking/my` | يبقى مؤقتًا، ممكن hide من dashboard لاحقًا | Optional Booking Module legacy viewer | نعم | العميل يفقد الوصول لطلباته القديمة وحالاتها |
| `/center/inbox` | يبقى مؤقتًا | Optional Booking Module provider inbox | نعم | المركز قد يفقد workflow الرد على requests |
| `/clinician/inbox` | يبقى كـ deep link مؤقتًا لكن لا يظهر كمدخل أساسي | Legacy compatibility أو Optional Booking Module | نعم | كسر deep links/compatibility رغم أن الصفحة نفسها demoted |
| `/admin/booking-queue` | يبقى مؤقتًا كـ containment/admin legacy board | Optional Booking Module admin monitor أو Burial Candidate | نعم | admin يفقد مراقبة `booking_requests` قبل وجود بديل |
| `/admin/sessions` | يبقى مؤقتًا مع relabel | Optional Booking Module monitoring | نعم | كسر session readiness workflow الموجود |
| `/admin/accounting` | لا يختفي فورًا؛ يتحول لاحقًا إلى Optional Accounting Module preview أو hidden route | Optional Accounting Module | نعم جدًا | حذف مبكر يكسر admin accounting workspace وربما archive handoffs |

## Level 2 handling rules

* لا يتم hide لهذه routes من router.
* لا يتم حذفها من role guards.
* يمكن فقط تقليل ظهورها من top-level navigation بعد Owner Decision.
* أي route يتحول إلى module entry يجب أن يحمل copy واضح:

```text
Optional Module
Legacy Bridge
Not Core Platform
```

* أي module extraction لاحق يحتاج:
  * target owner
  * target collections
  * route namespace
  * rules direction
  * migration plan
  * rollback plan

---

# 4. Level 3 No Touch Yet

هذه عناصر لا يجب لمسها الآن إطلاقًا.

## routes يجب أن تبقى للتوافق

* `/client/payment-proof`
* `/booking`
* `/booking/request`
* `/booking/center-request`
* `/booking/my`
* `/center/inbox`
* `/center/residencies`
* `/clinician/inbox`
* `/clinician/sessions`
* `/admin/booking-queue`
* `/admin/payments`
* `/admin/accounting`
* `/admin/sessions`
* `/admin/archive/payments`
* `/admin/archive/accounting`
* `/admin/archive/sessions`
* `/admin/session-report`
* `/chat/clinician/inbox`

## pages يجب أن تبقى لأن workflow قائم

* `ClientPaymentProofPage`
* `MyBookingsPage`
* `BookingPage`
* `BookingRequestPage`
* `CenterBookingRequestPage`
* `ClinicianInboxPage`
* `CenterInboxPage`
* `ClientSessionsPage`
* `ClinicianSessionsPage`
* `CenterResidenciesPage`
* `AdminBookingQueuePage`
* `AdminPaymentsPage`
* `AccountingWorkspacePage`
* `AdminSessionsPage`
* `AdminArchivePaymentsPage`
* `AdminArchiveAccountingPage`
* `AdminArchiveSessionsPage`
* `AdminSessionReportPage`

## rules لا يجب لمسها

لا يتم تعديل Firestore rules الآن، خصوصًا:

* `booking_requests`
* `bookingRequests`
* `sessionRatings`
* `support_requests`
* `chat_threads`
* `chat_escalations`
* `clients`
* `clinicians`
* `centers`
* `admins`
* `resources`
* `system_domains`
* `ai_policies`
* `analytics_summaries`
* `system_alerts`

## collections لا يجب لمسها

* `booking_requests`
* `bookingRequests`
* `clients`
* `clinicians`
* `centers`
* `sessionRatings`
* `support_requests`
* `chat_threads`
* `chat_escalations`
* `resources`
* `admins`
* `system_domains`
* `ai_policies`
* `analytics_summaries`
* `system_alerts`
* `external_follow_up_registry`
* `external_follow_up_message_templates`
* `external_follow_up_campaigns`

## deep links وrouter-only routes يجب أن تبقى

* `/booking`
* `/clinician/inbox`
* `/chat/clinician/inbox`
* `/admin/session-report`
* `/admin/archive/payments`
* `/admin/archive/accounting`

السبب: حتى لو مفيش CTA واضح، ممكن يكون فيه saved links أو admin workflow أو legacy support محتاجهم.

---

# 5. Suggested First Micro-Change Package

هذه مجرد package مقترحة للتنفيذ لاحقًا. لا يتم تنفيذها داخل هذا التقرير.

## Package Name

```text
VISIBILITY_CONTAINMENT_01_CLIENT_AND_COPY_ONLY
```

## Scope

1. إخفاء كارت `Payment proof` من `ClientDashboardPage` فقط.
2. تغيير subtitle في `MenuPage` من:

```text
Browse specialists and request a booking
```

إلى:

```text
Browse specialists and compare provider services
```

3. تغيير CTA في `SpecialistDetailsPage` من:

```text
Request booking
```

إلى:

```text
Request provider contact
```

4. تغيير support labels:

* `Booking issue` -> `Service request issue`
* `Payment follow-up` -> `Account/support follow-up`
* `Payout question` -> `Provider account question`
* `Payment question` -> `Account/support question`

## Explicit Non-Scope

* لا حذف route.
* لا حذف page.
* لا تعديل router.
* لا تعديل Firestore rules.
* لا تعديل collections.
* لا تعديل booking/payment services.
* لا تعديل admin pages في أول package إلا بعد manual QA للعميل.

## Why this package is the safest

* يقلل أوضح financial exposure للعميل.
* يقلل booking-as-core language في أول رحلة marketplace.
* لا يقطع access للبيانات القديمة.
* لا يغير data model.
* لا يغير permissions.
* rollback بسيط: إرجاع card أو label.

---

# 6. Manual QA Checklist

## Before change

* افتح `/menu` كزائر.
* افتح `/client/dashboard` كـ client.
* افتح `/module/specialists` ثم specialist details.
* افتح `/module/support-issue-selector` لكل supportType مهم.
* افتح direct route `/client/payment-proof`.
* افتح direct route `/booking/my`.

## After Level 1 micro-change

* client dashboard لا يعرض `Payment proof` card.
* direct route `/client/payment-proof` ما زال يفتح لو اتكتب يدويًا أو جاء من deep link.
* باقي client dashboard cards لا تتزحزح أو تكسر layout.
* menu لا يقول `request a booking`.
* specialist details CTA لا يقول `Request booking`.
* CTA ما زال يفتح route الحالي بدون كسر.
* support options تظهر copy الجديدة.
* support request submit لا يتأثر.
* لا يوجد أي تغير في `firestore.rules`.
* لا يوجد أي تغير في `routes.dart`.
* لا يوجد أي تغير في `app_router.dart`.

## Admin smoke check بعد أي Level 1 خاص بالأدمن

* `/admin/hub` يفتح.
* `/admin/operations` يفتح.
* `/admin/archive` يفتح.
* direct route `/admin/payments` ما زال يفتح.
* direct route `/admin/accounting` ما زال يفتح.
* direct route `/admin/archive/payments` ما زال يفتح.
* direct route `/admin/archive/accounting` ما زال يفتح.

## Provider smoke check بعد أي relabel

* `/clinician/operations` يفتح.
* `/clinician/sessions` يفتح.
* `/center/dashboard` يفتح.
* `/center/inbox` يفتح.
* `/center/residencies` يفتح.

---

# 7. Owner Decisions Needed

1. هل إخفاء `Payment proof` من client dashboard مسموح الآن مع بقاء direct route؟

2. هل نستخدم لغة:

```text
Provider contact request
```

أم:

```text
Service request
```

بدل `Booking`؟

3. هل `/booking/request` سيظل اسمه الداخلي كما هو مؤقتًا، مع تغيير copy فقط، أم نخطط route alias جديد لاحقًا؟

4. هل `Payment follow-up` support option يتحول إلى support عام، أم يختفي تمامًا؟

5. هل `Payout question` للمراكز/الأخصائيين يتحول إلى `Provider account question` أم يخرج من support options؟

6. هل `Commission / Tax Deduction` مجرد placeholder يتم إخفاؤه في أول admin package، أم يحتاج توثيق مالي منفصل؟

7. هل `/admin/accounting` يتحول إلى Optional Accounting Module preview، أم يتم تقليله كـ legacy فقط؟

8. هل `Payments Archive` و`Accounting Archive` يختفوا من archive landing مع بقاء direct route، أم يظلوا visible للأدمن؟

9. هل `Sessions` تتحول لغويًا إلى `Provider coordination`، أم تبقى `Sessions` مؤقتًا لتجنب لخبطة المستخدمين؟

10. هل center inbox والclinician inbox يجب أن يظلوا visible أم يتحولوا إلى module-only entry بعد extraction؟

---

# 8. Final Verdict

الخطة الآمنة هي containment تدريجي:

1. ابدأ بـ hide/copy فقط.
2. لا تحذف routes.
3. لا تلمس rules.
4. لا تلمس collections.
5. أبق deep links شغالة.
6. خفف language التي توحي أن Mental Smile يملك booking أو payment أو session.
7. حوّل booking/accounting لاحقًا إلى Optional Module entries بعد Owner Decision.

أول تنفيذ لاحق يجب أن يكون صغير جدًا:

```text
Hide Payment proof card from ClientDashboardPage
+
Relabel request booking wording
+
Relabel financial support options
+
No routes change
+
No rules change
```

هذا التقرير لا يغير UI.
هذا التقرير لا يحذف routes.
هذا التقرير لا يعدل runtime.
هو فقط يحول audit إلى خطة containment آمنة.
