# SERVICE_COORDINATION_CAPABILITY_PACKAGE

## 1. Executive Summary

`Provider Contact Request` يمثل نية العميل في التواصل مع مقدم خدمة.

`Service Coordination` تمثل ما يحدث بعد وجود تواصل فعلي أو فرصة خدمة مفتوحة بين العميل ومقدم الخدمة.

الفرق الأساسي:

```text
Provider Contact Request
=
I want this provider to contact me.
```

```text
Service Coordination
=
Provider and client are coordinating around a service opportunity.
```

لكن `Service Coordination` ليست Booking Lifecycle. هي لا تؤكد حجز، ولا تدير علاج، ولا تملك دفع، ولا محاسبة، ولا مراجعات Trust، ولا شكاوى Support. هي فقط حالة تنسيق خفيفة تساعد الأطراف يعرفوا أن فيه تواصل/متابعة حول خدمة.

---

## 2. Capability Definition

تعريف الجملة الواحدة:

```text
Provider and client are coordinating around a service opportunity.
```

`Service Coordination` تفعل:

* تسجل أن طلب تواصل تحول إلى تنسيق نشط.
* تعرض حالة التنسيق بين العميل ومقدم الخدمة.
* تحفظ milestones بسيطة مثل انتظار رد أو متابعة مطلوبة.
* تساعد مقدم الخدمة والعميل على تتبع النشاط.
* تعطي Control Room visibility عند وجود stuck أو abuse signals.

لا تفعل:

* لا تؤكد booking.
* لا تدير session lifecycle.
* لا تدير payment.
* لا تدير accounting.
* لا تملك review.
* لا تملك support ticket.
* لا تشخص.
* لا تضمن نتيجة علاج.

---

## 3. Capability Boundaries

### Owns

`Service Coordination` تملك:

* coordination state.
* coordination activity.
* communication milestones.
* scheduling intent.
* follow-up markers.
* inactivity markers.
* provider/client coordination references.

### Does Not Own

`Service Coordination` لا تملك:

* confirmed booking.
* treatment lifecycle.
* payment.
* accounting.
* trust reviews.
* support ownership.
* diagnosis.
* treatment outcome.
* payout.
* commission.
* official appointment guarantee.

اللغة المعمارية المهمة:

```text
coordination intent
not
booking confirmation
```

---

## 4. Candidate Data Shape

نموذج منطقي فقط، بدون تنفيذ أو إنشاء collections.

| Field | Purpose |
| --- | --- |
| `coordinationId` | معرف التنسيق |
| `requestId` | reference لطلب التواصل المرتبط |
| `clientId` | العميل |
| `providerId` | مقدم الخدمة |
| `providerType` | clinician أو center أو نوع مقدم آخر |
| `coordinationStatus` | حالة التنسيق الحالية |
| `coordinationNotes` | ملاحظات تنسيقية غير علاجية |
| `preferredTimeWindow` | نافذة وقت مفضلة للتواصل أو المتابعة |
| `lastActorRole` | آخر طرف قام بنشاط |
| `lastActivityAt` | آخر وقت نشاط |
| `followUpNeededAt` | وقت متابعة محتمل إن وجد |
| `createdAt` | تاريخ الإنشاء |
| `updatedAt` | تاريخ التحديث |
| `legacyBookingRequestId` | reference للتوافق فقط |

حقول ممنوعة:

* `paymentStatus`
* `payoutStatus`
* `accountingStatus`
* `commissionStatus`
* `treatmentStatus`
* `diagnosis`
* `clinicalOutcome`
* `reviewStatus`
* `complaintStatus`

---

## 5. Status Model

Statuses بسيطة مقترحة:

### `initiated`

بدأ التنسيق بعد طلب تواصل أو signal واضح.

### `active`

التنسيق جاري بين العميل ومقدم الخدمة.

### `awaiting_response`

طرف ينتظر رد من الطرف الآخر.

### `follow_up_needed`

يحتاج متابعة لاحقة أو تذكير.

### `completed`

تم إغلاق التنسيق بشكل طبيعي.

### `cancelled`

تم إلغاء التنسيق حسب policy.

Statuses ممنوعة:

* `booked`
* `paid`
* `payout_pending`
* `accounting_review`
* `treatment_completed`
* `session_completed`
* `diagnosis_done`

السبب: هذه الحالات تجعل capability تعود إلى Booking/Payment/Treatment lifecycle.

---

## 6. Provider View Design

مقدم الخدمة يحتاج يرى:

* التنسيقات النشطة.
* العميل المرتبط حسب policy.
* الخدمة أو التصنيف.
* حالة التنسيق.
* آخر نشاط.
* هل فيه رد مطلوب منه.
* وقت متابعة مقترح.
* ملاحظات تنسيقية غير علاجية.

مقدم الخدمة لا يحتاج يرى:

* payment proof.
* accounting status.
* payout أو commission.
* Trust review controls.
* Support ticket ownership.
* diagnosis أو clinical outcome.
* internal admin flags غير مصرح بها.

---

## 7. Client View Design

العميل يحتاج يرى:

* التنسيقات المرتبطة بطلباته.
* مقدم الخدمة.
* حالة التنسيق.
* آخر نشاط.
* هل ينتظر رد.
* إمكانية الإلغاء أو الإغلاق حسب policy.

ما يجب أن يبقى مخفيًا:

* provider internal notes.
* admin internal flags.
* accounting/payment signals.
* moderation internals.
* أي workflow علاجي أو تشخيصي ليس من ملكية المنصة.

اللغة المناسبة:

```text
Service coordination
```

أو:

```text
Provider coordination
```

وليس:

```text
Confirmed booking
```

---

## 8. Admin Visibility Design

Control Room يحتاج visibility فقط، بدون امتلاك Domain.

يحتاج رؤية:

* stuck coordination.
* abuse signals.
* inactivity signals.
* duplicate coordination patterns.
* provider non-response.
* client spam.
* legacy compatibility warnings.

لا يحتاج أن يملك:

* العلاج.
* الحجز المؤكد.
* الدفع.
* المحاسبة.
* Trust reviews.
* Support tickets.

المبدأ:

```text
Admin sees exceptions.
Admin does not own the care relationship.
```

---

## 9. Candidate Read Models

هذه Read Models مرشحة فقط، بدون تنفيذ.

### CoordinationSummary

Purpose:

* عرض عدد التنسيقات المفتوحة، العالقة، والمغلقة.

Candidate fields:

* `providerId`
* `activeCount`
* `awaitingResponseCount`
* `followUpNeededCount`
* `completedCount`
* `lastActivityAt`

### CoordinationFeed

Purpose:

* feed للتنسيقات التي تظهر لمقدم الخدمة أو العميل.

Candidate fields:

* `coordinationId`
* `requestId`
* `providerId`
* `clientDisplayName`
* `serviceCategory`
* `coordinationStatus`
* `lastActivityAt`
* `nextFollowUpAt`

### CoordinationActivityTimeline

Purpose:

* timeline مبسط للأحداث التنسيقية.

Candidate fields:

* `coordinationId`
* `events`
* `actorRole`
* `eventType`
* `createdAt`
* `visibilityScope`

---

## 10. Future Route Direction

Routes منطقية مستقبلية فقط، بدون تنفيذ:

* `/coordination/my`
* `/coordination/provider`
* `/coordination/admin`
* `/coordination/:id`
* `/coordination/provider/:providerId`

الاتجاه:

```text
/booking/my
↓
/coordination/my
```

و:

```text
/clinician/inbox
↓
/coordination/provider
```

لكن لا يتم تغيير routes الآن.

---

## 11. Relationship With Provider Contact

الرحلة تبدأ من:

```text
Provider Contact Request
```

ثم تتحول إلى:

```text
Service Coordination
```

عندما يظهر أن الطرفين دخلوا في متابعة أو تنسيق حول الخدمة.

الشكل:

```text
Client submits provider contact request
↓
Provider views/responds
↓
Coordination is initiated
↓
Follow-up / awaiting response / completed
```

هذا ليس:

```text
Booking confirmed
↓
Payment collected
↓
Session managed
↓
Treatment completed
```

الحد الدستوري:

```text
Coordination can organize contact.
It must not own care, payment, or treatment.
```

---

## 12. Compatibility Strategy

`Service Coordination` يمكن أن تعيش مستقبلًا بينما:

* `booking_requests` ما زالت موجودة.
* routes القديمة ما زالت موجودة.

الاستراتيجية:

```text
booking_requests remains legacy-readable
↓
Provider Contact model approved
↓
Service Coordination model approved
↓
Compatibility mapping designed
↓
Consumers move gradually
↓
Legacy booking language is contained
↓
Read-only/archive/burial when safe
```

مهم:

* لا يتم تغيير routes القديمة الآن.
* لا يتم حذف pages.
* لا يتم تغيير rules.
* لا يتم نقل data.
* لا يتم خلق collection جديدة قبل approval/tests.

---

## 13. Risks

### Coordination Ambiguity

المستخدم قد يفهم التنسيق كحجز مؤكد.

Mitigation direction:

* language واضح.
* statuses لا تحتوي على `booked`.
* UX يوضح أنها coordination وليست confirmation.

### Client Expectations

العميل قد يتوقع أن Mental Smile مسؤولة عن موعد أو نتيجة.

Mitigation direction:

* disclosure.
* wording.
* provider responsibility clarity.

### Provider Inactivity

مقدم الخدمة قد لا يرد.

Mitigation direction:

* inactivity signals.
* stuck coordination visibility.
* follow-up markers.

### Spam

طلبات متابعة كثيرة أو غير جادة.

Mitigation direction:

* rate limiting design.
* duplicate detection.
* abuse signals.

### Abuse

استخدام سيء من client أو provider.

Mitigation direction:

* activity trail.
* support reference path.
* admin exception visibility.

### Misunderstanding as Booking Confirmation

الخطر الأكبر هو تحول اللغة إلى booking again.

Mitigation direction:

* ممنوع status مثل `booked`.
* ممنوع payment fields.
* ممنوع platform-owned session lifecycle.

---

## 14. Future Evolution

يمكن لاحقًا إضافة:

### Provider Availability Hints

إظهار أوقات عامة أو availability hints كإفصاح، وليس حجز مركزي.

### Communication Milestones

إضافة milestones مثل:

* provider responded.
* client replied.
* follow-up requested.

### Reminder Signals

إشارات تذكير للتواصل أو المتابعة، بدون فرض موعد علاجي مؤكد.

القانون:

```text
Service Coordination may improve communication.
It must not become a Booking Platform.
```

---

## 15. What Must Not Be Done

ممنوع الآن:

* إنشاء collections.
* migration.
* تعديل `booking_requests`.
* تعديل routes.
* تعديل rules.
* بناء booking confirmation system.
* بناء payment flow.
* بناء accounting flow.
* بناء treatment lifecycle.
* تغيير statuses الحالية.
* تغيير queries.
* تعديل provider/center/client runtime.
* تنفيذ extraction.

---

## 16. Final Verdict

نعم، `Service Coordination` هو الوريث الشرعي للجزء التشغيلي الناجي من `booking_requests`.

السبب:

* يحافظ على قيمة التنسيق بدون تحويل Mental Smile إلى Booking Platform.
* يفصل التشغيل الخفيف عن payment/accounting/trust/support.
* يعطي provider/client visibility مفيدة بدون امتلاك العلاج.
* يسمح لـ Control Room برؤية exceptions فقط.
* يكمل `Provider Contact Request` بدل ما يستبدله.

الحكم النهائي:

```text
Provider Contact Request owns the contact intent.

Service Coordination owns the lightweight coordination state.

Neither owns booking, care, payment, accounting, trust, or support.
```

هذا Package لا يغير Runtime.

هذا Package لا يغير Rules.

هذا Package لا ينفذ Extraction.

هذا Package يصمم فقط Service Coordination Capability المستقبلية.
