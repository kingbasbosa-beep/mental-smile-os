# BOOKING_REQUESTS_SURVIVABILITY_BLUEPRINT_V1

## 1. Executive Summary

`booking_requests` الحالية لا يمكن أن تبقى كـ Core لأنها حملت أكثر من Domain في نفس الـ collection:

* contact
* booking
* session coordination
* payment proof
* accounting
* payout/commission hints
* reviews/ratings
* support references
* archive/reporting behavior

هذا يخالف دستور Mental Smile:

```text
No collection may own multiple domains.
```

لكن ليس كل ما داخل `booking_requests` يجب أن يموت. الجزء الذي قد ينجو هو الجزء البسيط الذي يخدم هوية المنصة كسوق خدمات صحة نفسية:

```text
Provider Contact Request
+
Service Coordination
```

الناجي لا يكون Booking Core، ولا Payment Flow، ولا Accounting Flow، ولا Trust Owner، ولا Support Owner. هو فقط طريقة منظمة لطلب تواصل مع مقدم خدمة وتنسيق أولي غير علاجي وغير مالي.

---

## 2. Current State Analysis

محتويات `booking_requests` الحالية يمكن تصنيفها معماريًا كالتالي:

| Area | Meaning | Target Direction |
| --- | --- | --- |
| Contact | العميل يريد الوصول لمقدم خدمة | يمكن أن ينجو كـ Provider Contact Request |
| Coordination | متابعة حالة الطلب والتواصل المبدئي | يمكن أن ينجو كـ Service Coordination محدود |
| Trust | ratings/reviews/review status | ينتقل ملكيًا إلى Trust & Transparency Domain |
| Support | complaints/escalations/support references | ينتقل ملكيًا إلى Client Support Domain |
| Accounting | ledger/dues/financial close | Optional Accounting Module أو Burial |
| Payment | proof/confirmation/payment follow-up | Legacy compatibility فقط ثم Archive/Burial |
| Archive | snapshots/history | Archive behavior مستقل حسب الدومين |
| Reporting | admin/session/payment reports | يعاد تصنيفه حسب Domain أو Module |

المشكلة ليست اسم `booking_requests` فقط. المشكلة أنها أصبحت Legacy Container يجمع workflows لا يجب أن تعيش معًا.

---

## 3. Survivability Classification

| Component | Classification |
| --- | --- |
| Must Survive | Provider identity, client identity, request intent, service interest, contact/coordination status, timestamps, minimal actor audit |
| Optional | preferred time window, communication preference, notes visible to provider, simple coordination history |
| Legacy Only | old booking status, session status, request lifecycle fields, legacy request references, compatibility flags |
| Burial Candidate | payment proof, payout, commission, accounting fields, tax deduction fields, review ownership fields, support ownership fields |

### Must Survive

يبقى فقط ما يخدم وصول العميل لمقدم الخدمة:

* من العميل؟
* يريد التواصل مع من؟
* بخصوص أي خدمة؟
* ما حالة الطلب البسيطة؟
* متى تم الطلب؟

### Optional

يمكن أن تبقى بيانات تنسيقية خفيفة بشرط ألا تتحول إلى Booking Platform:

* وقت مفضل للتواصل.
* قناة تواصل مفضلة.
* رسالة مبدئية.
* سجل نشاط بسيط.

### Legacy Only

تبقى للقراءة والتوافق فقط أثناء التحول:

* حالات booking القديمة.
* روابط session قديمة.
* حقول مستخدمة في dashboards قديمة.

### Burial Candidate

يجب ألا تعيش في الكيان الجديد:

* payment proof.
* payout.
* commission.
* accounting ledger.
* session review ownership.
* support ticket ownership.

---

## 4. Provider Contact Capability

الشكل المستقبلي لـ `Provider Contact Request` يجب أن يكون صغير ومباشر.

### Required Fields

* `requestId`
* `clientId`
* `providerId`
* `providerType`
* `serviceId`
* `serviceName`
* `message`
* `contactPreference`
* `status`
* `createdAt`
* `updatedAt`

### Allowed Status Shape

أمثلة مستقبلية:

* `submitted`
* `seen`
* `responded`
* `closed`
* `cancelled`

هذه statuses لا تعني session lifecycle ولا treatment lifecycle.

### Fields That Must Not Survive

* payment proof fields
* payout fields
* commission fields
* accounting settlement fields
* review/rating fields
* complaint ownership fields
* diagnosis fields
* treatment outcome fields
* platform-owned session management fields

### Architectural Meaning

Provider Contact Request هو:

```text
I want this provider to contact me about this service.
```

وليس:

```text
Mental Smile booked, billed, managed, and guaranteed this session.
```

---

## 5. Service Coordination Capability

`Service Coordination` هو مفهوم تنسيقي خفيف.

وظيفته:

* متابعة حالة تواصل.
* إظهار أن مقدم الخدمة رد أو لم يرد.
* تسجيل أن الطلب اكتمل تنسيقيًا.
* دعم visibility للأدمن عند وجود exception.

لا يملك:

* العلاج.
* التشخيص.
* دفع الجلسة.
* تحصيل.
* عمولة.
* ضمان نتيجة.
* إدارة الجلسة كـ medical workflow.

الشكل الصحيح:

```text
Contact request
↓
Provider response
↓
Coordination state
↓
Closed or archived
```

وليس:

```text
Booking
↓
Payment
↓
Session
↓
Review
↓
Accounting
```

---

## 6. Provider Inbox Blueprint

مقدم الخدمة يجب أن يرى:

* طلبات تواصل جديدة.
* بيانات العميل اللازمة للتواصل حسب policy.
* الخدمة المطلوبة.
* الرسالة المبدئية.
* حالة التنسيق.
* سجل نشاط بسيط.

مقدم الخدمة لا يجب أن يرى داخل هذا الـ inbox:

* platform payment proof.
* payout.
* commission.
* accounting settlement.
* Trust ownership controls.
* Support ticket ownership.
* أي إيحاء أن Mental Smile تدير العلاج نفسه.

الـ inbox المستقبلي يجب أن يسمى:

```text
Provider Request Inbox
```

أو:

```text
Service Request Inbox
```

وليس:

```text
Booking Inbox
```

---

## 7. Client Request History Blueprint

العميل يجب أن يرى:

* الطلبات التي أرسلها لمقدمي الخدمة.
* حالة الطلب البسيطة.
* مقدم الخدمة المرتبط.
* تاريخ الطلب.
* إمكانية إغلاق أو إلغاء الطلب حسب السياسة.

ما يصبح Archive فقط:

* payment proof القديم.
* booking lifecycle القديم.
* session lifecycle القديم.
* أي financial confirmation.
* أي accounting state.

الاسم المستقبلي المناسب:

```text
My Service Requests
```

أو:

```text
My Provider Contact Requests
```

وليس:

```text
My Bookings
```

---

## 8. Admin Exception Visibility Blueprint

Control Room يحتاج visibility فقط، وليس ownership.

الأدمن قد يحتاج رؤية:

* طلبات عالقة.
* طلبات لم يتم الرد عليها.
* طلبات مغلقة بشكل غير واضح.
* conflict أو abuse signals.
* legacy compatibility warnings.

الأدمن لا يملك:

* payment flow.
* payout flow.
* commission flow.
* treatment/session ownership.
* Trust review ownership.
* Support workflow ownership إلا من خلال Support Domain.

الهدف:

```text
Exception visibility
not
Domain ownership
```

---

## 9. Candidate Future Collections

هذه Collections مرشحة فقط. لا يتم إنشاؤها الآن.

### `provider_contact_requests`

Purpose: طلب تواصل من العميل إلى مقدم الخدمة.

Candidate fields:

* `clientId`
* `providerId`
* `providerType`
* `serviceId`
* `message`
* `contactPreference`
* `status`
* `createdAt`
* `updatedAt`
* `legacyBookingRequestId`

### `service_coordination`

Purpose: حالة التنسيق الخفيفة المرتبطة بطلب تواصل.

Candidate fields:

* `contactRequestId`
* `providerId`
* `clientId`
* `coordinationStatus`
* `lastActorRole`
* `lastActivityAt`
* `closedAt`

### `provider_request_inbox`

Purpose: read model سريع لمقدم الخدمة.

Candidate fields:

* `providerId`
* `requestId`
* `clientDisplayName`
* `serviceName`
* `status`
* `isUnread`
* `lastActivityAt`

### `request_activity_log`

Purpose: سجل نشاط بسيط للطلب.

Candidate fields:

* `requestId`
* `actorId`
* `actorRole`
* `eventType`
* `message`
* `createdAt`

بدائل اسمية ممكنة:

* `provider_connection_requests`
* `service_contact_requests`
* `coordination_events`

---

## 10. Candidate Routes

هذه Routes مرشحة فقط. لا يتم إنشاؤها الآن.

### `/provider-contact/request`

الغرض: إنشاء طلب تواصل مع مقدم خدمة.

### `/provider-contact/my`

الغرض: عرض طلبات العميل.

### `/provider/inbox`

الغرض: inbox لمقدم الخدمة يرى فيه طلبات التواصل.

### `/service-coordination/:requestId`

الغرض: عرض حالة التنسيق الخفيفة.

### `/admin/provider-requests`

الغرض: رؤية Control/Exception بدون ownership.

### `/admin/service-coordination-signals`

الغرض: مراقبة مؤشرات التعثر والتوافق.

المسارات القديمة مثل `/booking/request` و`/booking/my` قد تبقى مؤقتًا كـ compatibility routes، لكن اتجاه اللغة والملكية يجب أن يتحول إلى Provider Contact / Service Coordination.

---

## 11. Compatibility Strategy

`booking_requests` يعيش مؤقتًا كـ Legacy Layer أثناء التحول.

المسموح:

* قراءة بيانات قديمة.
* دعم deep links القديمة.
* إصلاح bugs صغيرة للتوافق.
* inventory/audit.
* mapping ذهني إلى Provider Contact وService Coordination.

الممنوع:

* توسيع `booking_requests`.
* إضافة payment/accounting/payout.
* بناء Core Platform فوقه.
* جعله مصدر Trust أو Support.
* استخدامه كـ collection مركزية جديدة باسم مختلف.

الاتجاه:

```text
booking_requests
↓
legacy compatibility
↓
read only
↓
archive
↓
burial
```

---

## 12. Burial Candidates

العناصر التالية يجب أن تدفن نهائيًا من أي successor مستقبلي:

* payment proof ownership.
* payment confirmation ownership.
* payout fields.
* commission fields.
* tax deduction wording/fields.
* settlement workflow.
* accounting ledger ownership.
* review/rating ownership.
* complaint ownership.
* support escalation ownership.
* full booking lifecycle.
* session lifecycle as platform-owned care workflow.
* reports التي تفترض أن booking هو قلب المنصة.

قد تبقى بعض هذه العناصر في archive أو compatibility فقط، لكن لا تدخل الكيان الجديد.

---

## 13. Extraction Readiness Gates

لا يتم أي فصل فعلي قبل تحقق الشروط التالية:

* Owner approval على اسم الكيان الناجي.
* Provider Contact fields approved.
* Service Coordination boundaries approved.
* Consumers inventory completed.
* Rules design completed.
* Route compatibility plan approved.
* Deep links inventory completed.
* Legacy read-only strategy approved.
* Archive behavior designed.
* Manual QA plan approved.
* Emulator tests designed قبل أي rules change.
* No migration plan إلا بعد اكتمال ownership clarity.

---

## 14. Risks

### Runtime Risks

* كسر صفحات قديمة تعتمد على `booking_requests`.
* كسر inbox للأخصائي أو المركز.
* كسر direct route قديم.
* اختلاف count أو status في dashboards.

### Rules Risks

* rules الحالية قد تكون مصممة حول booking lifecycle.
* أي فصل قبل rules design قد يفتح read/write gaps.
* module-scoped rules تحتاج tests قبل التنفيذ.

### Data Risks

* legacy requests فيها fields مختلطة.
* بعض documents قد لا تحتوي على provider أو client بشكل واضح.
* status values قد تكون غير موحدة.
* payment/review/support fields قد تكون embedded داخل نفس document.

### UX Risks

* المستخدم قد يتوه بين Booking وProvider Contact.
* مقدم الخدمة قد يظن أن المنصة تدير الجلسة.
* الأدمن قد يرى financial wording كأنه Core.

### Compatibility Risks

* deep links القديمة.
* archive pages.
* reports القديمة.
* dashboards التي تعرض counts من `booking_requests`.

---

## 15. What Must Not Be Done

ممنوع الآن:

* حذف `booking_requests`.
* تغيير Firestore rules.
* تغيير routes.
* migration.
* extraction.
* rename collections.
* refactor runtime.
* تغيير query shape.
* تغيير status values.
* إنشاء successor collections.
* حذف pages.
* كسر deep links.

هذا Blueprint للتصميم فقط، وليس تنفيذ.

---

## 16. Final Verdict

إذا ماتت `booking_requests` الحالية، الكيان الصغير الذي يستحق أن يولد مكانها هو الاثنين معًا:

```text
Provider Contact Request
+
Service Coordination
```

لكن بشرط مهم:

* Provider Contact يملك نية العميل في التواصل مع مقدم الخدمة.
* Service Coordination يملك حالة التنسيق الخفيفة فقط.
* Trust يملك reviews/ratings.
* Support يملك الشكاوى والتصعيد.
* Accounting يبقى optional أو يدفن.
* Payment ownership خارج Core Mental Smile.

الحكم النهائي:

```text
booking_requests must not survive as Core.

A small provider contact and service coordination capability may survive as a clean, tenant-aware, non-financial, non-clinical capability.
```

هذا Blueprint لا يغير Runtime.

هذا Blueprint لا يغير Rules.

هذا Blueprint لا ينفذ Extraction.

هذا Blueprint يحدد فقط ما الذي يستحق الحياة بعد موت `booking_requests` الحالية.
