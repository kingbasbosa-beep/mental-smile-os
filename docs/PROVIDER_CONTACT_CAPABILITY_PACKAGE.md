# PROVIDER_CONTACT_CAPABILITY_PACKAGE

## 1. Executive Summary

`Provider Contact Request` هو الناجي الطبيعي من `booking_requests` لأنه يمثل الجزء المتوافق مع هوية Mental Smile كسوق خدمات صحة نفسية:

```text
Client wants to reach a provider about a service.
```

هذا الجزء يخدم marketplace access بدون أن يحول المنصة إلى Booking Platform أو Payment Platform.

لكن هذه الـ capability لا يجب أن ترث أي شيء من الأجزاء الملوثة داخل `booking_requests`:

* payment
* accounting
* commission
* payout
* reviews
* support ownership

الهدف هو capability صغيرة، واضحة، non-financial، non-clinical، تساعد العميل يوصل لمقدم الخدمة وتساعد مقدم الخدمة يشوف طلبات التواصل، بدون أن تمتلك العلاقة العلاجية أو المالية.

---

## 2. Capability Definition

تعريف الجملة الواحدة:

```text
I want this provider to contact me regarding this service.
```

`Provider Contact Request` تفعل:

* تسجل نية العميل في التواصل مع مقدم خدمة.
* تحدد الخدمة أو التصنيف الذي يهتم به العميل.
* تنقل رسالة مبدئية لمقدم الخدمة.
* تسمح بمتابعة حالة تواصل بسيطة.
* تدعم visibility للأدمن عند وجود exception.

لا تفعل:

* لا تؤكد حجز.
* لا تدير جلسة.
* لا تحصّل أموال.
* لا تدير payout.
* لا تملك review.
* لا تملك complaint.
* لا تضمن نتيجة علاج.

---

## 3. Capability Boundaries

### Owns

`Provider Contact Request` تملك:

* contact intent.
* service interest.
* preferred communication.
* request activity.
* coordination markers.
* provider/client references.
* simple status.
* timestamps.

### Does Not Own

`Provider Contact Request` لا تملك:

* diagnosis.
* treatment outcome.
* booking confirmation.
* payment.
* accounting.
* trust reviews.
* support tickets.
* payout.
* commission.
* session lifecycle.
* official verification.

مسموح لها تحتفظ بـ references بسيطة للدعم أو الثقة مستقبلًا، لكن بدون ownership.

---

## 4. Candidate Data Shape

نموذج منطقي فقط، بدون تنفيذ أو إنشاء collections.

| Field | Purpose |
| --- | --- |
| `requestId` | معرف الطلب |
| `clientId` | العميل الذي طلب التواصل |
| `providerId` | مقدم الخدمة المستهدف |
| `providerType` | clinician أو center أو نوع مقدم آخر |
| `serviceCategory` | نوع الخدمة أو التصنيف المهتم به العميل |
| `serviceId` | اختياري لو الخدمة معرفة ككيان مستقل |
| `requestMessage` | رسالة العميل المبدئية |
| `preferredContactMethod` | وسيلة التواصل المفضلة |
| `preferredContactWindow` | وقت مفضل للتواصل إن وجد |
| `status` | حالة الطلب البسيطة |
| `lastActorRole` | آخر طرف قام بتحديث activity |
| `lastActivityAt` | آخر نشاط على الطلب |
| `createdAt` | تاريخ الإنشاء |
| `updatedAt` | تاريخ آخر تحديث |
| `legacyBookingRequestId` | reference اختياري للتوافق فقط |

حقول ممنوع تدخل النموذج:

* `paymentProof`
* `payoutStatus`
* `commission`
* `accountingStatus`
* `reviewStatus`
* `rating`
* `complaintStatus`
* `sessionDiagnosis`
* `treatmentOutcome`

---

## 5. Status Model

Statuses بسيطة مقترحة:

### `submitted`

العميل أرسل طلب تواصل.

### `viewed`

مقدم الخدمة أو الجهة المسؤولة شاهدت الطلب.

### `provider_contacted`

مقدم الخدمة تواصل أو بدأ الرد.

### `coordination_pending`

فيه تنسيق مفتوح، لكن بدون معنى booking confirmation.

### `completed`

تم إغلاق الطلب تنسيقيًا.

### `cancelled`

العميل أو مقدم الخدمة ألغى الطلب حسب policy.

Statuses ممنوعة:

* `payment_review`
* `payout_pending`
* `accounting_review`
* `commission_pending`
* `session_completed`
* `treatment_completed`

السبب: هذه statuses ترجع capability إلى booking/payment/accounting lifecycle.

---

## 6. Provider Inbox Design

مقدم الخدمة يحتاج يرى:

* اسم/معرف العميل حسب policy.
* الخدمة أو التصنيف المطلوب.
* رسالة العميل.
* وسيلة التواصل المفضلة.
* تاريخ الطلب.
* حالة الطلب.
* هل الطلب جديد أو تمت مشاهدته.
* آخر نشاط.

مقدم الخدمة لا يحتاج يرى:

* payment proof.
* payout.
* commission.
* accounting status.
* trust review controls.
* support ticket ownership.
* diagnosis أو treatment outcome.
* internal admin-only notes غير مصرح بها.

الـ inbox يجب أن يتكلم بلغة:

```text
Provider Request Inbox
```

وليس:

```text
Booking Inbox
```

---

## 7. Client View Design

العميل يحتاج يرى:

* الطلبات التي أرسلها.
* مقدم الخدمة المرتبط.
* الخدمة أو التصنيف.
* حالة التواصل.
* تاريخ الإنشاء وآخر تحديث.
* إمكانية الإلغاء أو الإغلاق حسب السياسة.

ما يجب أن يبقى مخفيًا:

* internal admin notes.
* provider internal workflow.
* financial/admin flags.
* accounting state.
* moderation internals.
* أي بيانات لا تخص العميل أو تكشف معلومات تشغيلية حساسة.

الاسم المستقبلي المناسب:

```text
My Provider Contact Requests
```

أو:

```text
My Service Requests
```

---

## 8. Admin Visibility Design

Control Room يحتاج visibility فقط، وليس ownership.

الأدمن يحتاج:

* exception visibility.
* abuse signals.
* stuck requests.
* duplicate request patterns.
* provider non-response signals.
* client spam signals.
* legacy compatibility warnings.

الأدمن لا يملك من خلال هذه capability:

* العلاج.
* الدفع.
* payout.
* accounting.
* trust reviews.
* support workflow.

المعنى:

```text
Admin observes exceptions.
Admin does not own the domain relationship.
```

---

## 9. Candidate Read Models

هذه Read Models مرشحة فقط، بدون تنفيذ.

### ProviderContactSummary

Purpose:

* ملخص سريع لعدد الطلبات، الجديد، العالق، والمكتمل لمقدم الخدمة.

Candidate fields:

* `providerId`
* `newCount`
* `pendingCount`
* `completedCount`
* `lastRequestAt`

### ProviderContactFeed

Purpose:

* feed قابل للعرض داخل inbox لمقدم الخدمة.

Candidate fields:

* `providerId`
* `requestId`
* `clientDisplayName`
* `serviceCategory`
* `status`
* `lastActivityAt`
* `isUnread`

### ContactActivityView

Purpose:

* timeline مبسط لنشاط الطلب.

Candidate fields:

* `requestId`
* `events`
* `actorRole`
* `eventType`
* `createdAt`

---

## 10. Future Route Direction

Routes منطقية مستقبلية فقط، بدون تنفيذ:

* `/provider-contact/request`
* `/provider-contact/my`
* `/provider-contact/inbox`
* `/provider-contact/admin`
* `/provider-contact/:requestId`

الاتجاه:

```text
/booking/request
↓
/provider-contact/request
```

و:

```text
/booking/my
↓
/provider-contact/my
```

لكن لا يتم تغيير routes الآن.

---

## 11. Compatibility Strategy

هذه capability يمكن أن تعيش مستقبلًا بينما:

* `booking_requests` لا تزال موجودة.
* routes القديمة لا تزال موجودة.

الاستراتيجية:

```text
Legacy booking_requests stays readable
↓
Provider Contact model gets approved
↓
Compatibility mapping is designed
↓
New consumers move gradually
↓
Legacy routes remain as bridges
↓
Legacy becomes read-only
↓
Archive/Burial when safe
```

مهم:

* لا يتم حذف route قديم قبل deep link inventory.
* لا يتم تغيير rules قبل tests.
* لا يتم نقل بيانات قبل approval.
* لا يتم اعتبار `booking_requests` مصدر الملكية الجديد.

---

## 12. Risks

### Spam

قد يرسل العميل طلبات كثيرة لنفس مقدم الخدمة.

Mitigation direction:

* duplicate prevention.
* rate limits.
* abuse signals.

### Duplicate Requests

قد يظهر أكثر من request لنفس client/provider/service.

Mitigation direction:

* active request check.
* idempotency design.

### Abandoned Requests

طلبات لا يرد عليها مقدم الخدمة.

Mitigation direction:

* stuck request visibility.
* expiration policy.
* provider response signals.

### Provider Abuse

مقدم خدمة قد يتجاهل أو يسيء استخدام بيانات التواصل.

Mitigation direction:

* complaint reference path.
* audit trail.
* visibility to Control Room.

### Client Abuse

عميل قد يستخدم الطلبات للإزعاج أو spam.

Mitigation direction:

* rate limits.
* reporting.
* temporary restrictions.

### Coordination Ambiguity

الطلب قد يفهم كحجز مؤكد.

Mitigation direction:

* language containment.
* status naming.
* no booking confirmation terminology.

---

## 13. Future Evolution

ممكن لاحقًا إضافة:

### Service Coordination

إضافة coordination events وحالة تنسيق خفيفة، بدون session/payment ownership.

### Verification Signals

إظهار trust/transparency signals لمقدم الخدمة أو العميل كقراءة فقط من Trust Domain.

### Provider Availability

إظهار availability كإفصاح أو hint، وليس نظام booking مركزي.

القانون:

```text
Provider Contact can evolve into coordination.
It must not evolve back into a Booking Platform.
```

---

## 14. What Must Not Be Done

ممنوع الآن:

* إنشاء collections.
* migration.
* تعديل `booking_requests`.
* تعديل routes.
* تعديل rules.
* بناء payment flow.
* بناء accounting flow.
* بناء booking lifecycle.
* تغيير status values.
* تغيير queries.
* تعديل provider inbox runtime.
* حذف routes أو pages.
* تنفيذ extraction.

---

## 15. Final Verdict

نعم، `Provider Contact Request` هو الوريث الدستوري الشرعي للجزء الناجي من `booking_requests`.

السبب:

* يطابق هوية Mental Smile كسوق خدمات صحة نفسية.
* يسهل وصول العميل لمقدم الخدمة بدون امتلاك العلاج.
* يسمح بتنسيق أولي بدون payment أو accounting.
* يفصل Trust وSupport عن booking legacy.
* يمنع عودة `booking_requests` كـ collection مركزية متعددة الدومينات.

الحكم النهائي:

```text
Provider Contact Request is the clean successor to the survivable contact-intent part of booking_requests.

It must remain non-financial, non-clinical, and non-booking-core.
```

هذا Package لا يغير Runtime.

هذا Package لا يغير Rules.

هذا Package لا ينفذ Extraction.

هذا Package يصمم فقط Provider Contact Capability المستقبلية.
