# TRUST_DOMAIN_EXTRACTION_BLUEPRINT_V1

## 1. Executive Summary

هذا الـ Blueprint يثبت الشكل المستقبلي لفصل `Trust & Transparency Domain` داخل Mental Smile بدون تنفيذ أي تعديل.

القرار الحاكم:

```text
Reviews & Ratings
=
Trust & Transparency Domain
```

Trust Domain هو أول Domain مرشح للفصل لأنه أوضح من Booking وAccounting وSupport:

* `Booking` عندنا Legacy/Quarantined ومربوط تاريخيًا بـ `booking_requests`.
* `Accounting` ليس Core Mental Smile، ولو استمر يبقى Optional Module.
* `Support` يملك الشكاوى والتصعيد، لكنه لا يملك التقييمات كمصدر سمعة عام.
* `Trust` له معنى Core واضح: تقييمات، مراجعات، شفافية، تاريخ ثقة، وسمعة مقدم الخدمة.

الفصل هنا لا يعني نقل بيانات الآن. المقصود هو رسم Target Architecture يخلّي Trust Domain مستقل تدريجيًا عن `booking_requests` و`sessionRatings` بدون كسر Runtime.

---

## 2. Current State Architecture

الوضع الحالي تقريبًا:

```text
sessionRatings
↓
requestId
↓
booking_requests
```

هذا خلق تشابك بين Trust وBooking:

* `sessionRatings` تحمل معنى Trust لكنها مرتبطة عمليًا بـ `requestId`.
* `requestId` يربط التقييم بسجل داخل `booking_requests`.
* `booking_requests` مصنفة رسميًا كـ Frozen + Quarantined + Legacy Candidate.

المشاكل الحالية:

* Ownership confusion: التقييم Trust signal لكنه ظاهر كجزء من Booking lifecycle.
* Runtime coupling: إنشاء review أو عرضه قد يعتمد على request/session سياق قديم.
* Report coupling: بعض التقارير قد تقرأ rating كجزء من session/booking reporting.
* Archive coupling: الأرشفة قد تتعامل مع review كملحق لطلب قديم بدل كيان Trust مستقل.
* Profile coupling: صفحات الأخصائي أو المركز تحتاج ratings كسمعة عامة، وليس كامتداد للحجز.

---

## 3. Target Trust Domain Vision

`Trust & Transparency Domain` يجب أن يكون Domain مستقل وظيفته:

* reviews
* ratings
* comments
* trust history
* transparency signals
* provider reputation

Trust Domain ليس مسؤولًا عن:

* booking
* payment
* accounting
* support ownership
* session lifecycle
* treatment outcome guarantees

الهدف أن صفحات الأخصائيين والمراكز تعتمد مستقبلًا على Trust-owned read models بدل الاعتماد المباشر على Booking legacy containers.

---

## 4. Trust Domain Boundaries

### Trust Owns

Trust Domain يملك:

* provider reviews
* provider ratings
* public comments
* trust summaries
* transparency history
* provider reputation
* moderation state for review visibility
* review source metadata
* audit trail الخاص بتغيرات الثقة والشفافية

### Trust Does Not Own

Trust Domain لا يملك:

* booking requests
* payment proof
* accounting
* support tickets
* complaint workflow ownership
* session lifecycle
* diagnosis
* treatment plan
* payout أو commission

مسموح لـ Trust أن يحتفظ بـ reference إلى request قديم للتوافق، لكن ممنوع أن يكون request هو مالك التقييم.

---

## 5. Candidate Collections

هذه Collections مرشحة مستقبلية فقط. لا يتم إنشاؤها الآن.

### `provider_reviews`

Purpose: تخزين reviews النصية المرتبطة بمقدم خدمة.

Owner: Trust & Transparency Domain.

Example fields:

* `providerId`
* `providerType`
* `reviewerId`
* `ratingId`
* `comment`
* `visibility`
* `moderationStatus`
* `sourceType`
* `legacyRequestId`
* `createdAt`
* `updatedAt`

### `provider_ratings`

Purpose: تخزين rating structured قابل للحساب والتجميع.

Owner: Trust & Transparency Domain.

Example fields:

* `providerId`
* `providerType`
* `reviewerId`
* `score`
* `dimensions`
* `sourceType`
* `legacySessionRatingId`
* `createdAt`

### `trust_history`

Purpose: سجل زمني لتغيرات الثقة والشفافية.

Owner: Trust & Transparency Domain.

Example fields:

* `providerId`
* `eventType`
* `eventSource`
* `summary`
* `actorId`
* `actorRole`
* `createdAt`

### `transparency_events`

Purpose: أحداث الإفصاح، الوثائق، التحقق، أو تغييرات visibility.

Owner: Trust & Transparency Domain.

Example fields:

* `providerId`
* `providerType`
* `eventCategory`
* `documentRef`
* `verificationSource`
* `visibility`
* `createdAt`

### `provider_reputation_snapshots`

Purpose: read model سريع لعرض السمعة على البروفايلات والتقارير.

Owner: Trust & Transparency Domain.

Example fields:

* `providerId`
* `providerType`
* `averageRating`
* `reviewCount`
* `trustScore`
* `transparencyScore`
* `lastReviewAt`
* `calculatedAt`

---

## 6. Candidate Routes

هذه Routes مرشحة مستقبلية فقط. لا يتم إنشاؤها الآن.

### `/trust/provider/:id`

الغرض: عرض Trust overview لمقدم الخدمة.

### `/trust/history/:providerId`

الغرض: عرض transparency/trust timeline.

### `/trust/reviews/:providerId`

الغرض: عرض reviews والتعليقات العامة المرتبطة بمقدم الخدمة.

### `/trust/transparency/:providerId`

الغرض: عرض الوثائق، مصادر التحقق، وإشارات الشفافية.

هذه routes لا تستبدل profile pages مباشرة. الأفضل مستقبلًا أن profile pages تستهلك Trust read models بدل ما تتحول كلها إلى Trust routes.

---

## 7. Trust Projection Strategy

المطلوب مستقبلًا أن يظل:

```text
booking_requests
```

شغال للتوافق، وفي نفس الوقت:

```text
Trust Domain
```

يبقى مستقل.

الفكرة هي Projection وليس Direct Dependency.

Direct Dependency تعني:

```text
Trust UI
↓
booking_requests
```

وده ممنوع كاتجاه مستقبلي لأنه يخلي Trust تابع لـ Legacy Booking.

Projection تعني:

```text
Legacy source
↓
projection process
↓
Trust read model
↓
Profile / public UI
```

في المرحلة الانتقالية، ممكن `sessionRatings` تفضل مصدر legacy، لكن الواجهات الجديدة تقرأ من Trust-owned summaries بدل القراءة من booking lifecycle مباشرة.

---

## 8. Compatibility Strategy

`sessionRatings` يعيش مؤقتًا كـ Legacy Layer أثناء التحول.

القواعد:

* لا يتم حذف `sessionRatings` الآن.
* لا يتم نقل بيانات الآن.
* لا يتم تغيير write path الآن.
* لا يتم تغيير `requestId` الآن.
* لا يتم كسر direct runtime الحالي.

دور `sessionRatings` أثناء التحول:

* legacy source للـ reviews الحالية.
* compatibility layer للصفحات التي لم يتم فصلها بعد.
* input محتمل لتصميم projection لاحقًا.

الهدف النهائي ليس إعادة تسمية `sessionRatings` بسرعة، بل تقليل اعتماده كمصدر مباشر للواجهات العامة.

---

## 9. Dependency Break Order

### 1. Ownership

تثبيت أن reviews/ratings ملك Trust Domain، وليس Booking.

### 2. Projection Design

تصميم read models التي تعكس Trust data بدون أن تجعل Booking هو المالك.

### 3. Read Models

تعريف شكل summaries التي تحتاجها profile pages والتقارير.

### 4. Trust Summaries

تجهيز شكل average rating، review count، trust score، reputation score.

### 5. Runtime Isolation

تحويل consumers تدريجيًا للقراءة من Trust-owned surfaces بعد اعتماد التنفيذ.

### 6. Rules Design

تصميم Rules مستقلة للـ Trust Domain قبل أي تعديل فعلي.

### 7. Legacy Read Only

عند اكتمال التوافق، يتحول legacy layer إلى read-only.

### 8. Archive

أرشفة legacy links والبيانات التاريخية بطريقة لا تكسر التقارير.

### 9. Burial

دفن الاعتماد القديم بعد انتهاء الحاجة التشغيلية والتوافقية.

---

## 10. Rules Blueprint

لا يتم تعديل Firestore rules الآن.

الشكل المستقبلي المقترح:

* Reviewer ownership: العميل يقدر ينشئ review واحد لنفسه وفق شروط واضحة.
* Provider visibility: مقدم الخدمة يرى reviews الخاصة به حسب policy.
* Public review visibility: الظهور العام يعتمد على `visibility` و`moderationStatus`.
* Moderation boundaries: الأدمن/Control يقدر يراجع visibility أو moderation بدون امتلاك محتوى العلاج.
* Source integrity: لو review جاي من legacy request، يحتفظ بـ `legacyRequestId` كمرجع، وليس كمالك.
* Write immutability: بعض fields مثل `reviewerId`, `providerId`, `sourceType` لا تتغير بعد الإنشاء إلا بسياسة واضحة.
* Abuse protection: منع duplicate reviews، spam، أو review بدون سياق موثق.

أي تعديل Rules مستقبلي لازم يسبقه:

* Domain ownership clarity
* route classification
* write path verification
* emulator tests
* Owner approval

---

## 11. Analytics Blueprint

مستقبلًا، المقاييس التالية يجب أن تصبح Trust-owned:

* `averageRating`
* `reviewCount`
* `trustScore`
* `reputationScore`
* `lastReviewAt`
* `transparencyScore`

الاتجاه:

```text
provider_reviews / provider_ratings
↓
Trust aggregation
↓
provider_reputation_snapshots
↓
profiles / reports / admin visibility
```

Analytics لا يجب أن تعتمد مباشرة على `booking_requests` لحساب سمعة مقدم الخدمة.

---

## 12. Archive Blueprint

الأرشيف المستقبلي يجب أن يستهلك Trust Data بدل booking lifecycle لما يكون الموضوع عن تقييم أو سمعة.

الاتجاه:

```text
Trust events
↓
Archive snapshots
↓
Historical visibility
```

بدل:

```text
booking lifecycle
↓
rating attached as side effect
↓
archive
```

الأرشفة يجب أن تحفظ:

* review identity
* provider identity
* visibility state
* moderation state
* source reference
* created/updated timestamps

بدون تحويل الأرشيف إلى مالك للتقييم.

---

## 13. Extraction Readiness Gates

لا يتم أي Extraction فعلي قبل تحقق الشروط التالية:

* Rules design completed.
* Write path verified.
* Projection models defined.
* Consumers inventoried.
* Profile consumers mapped.
* Admin/report consumers mapped.
* Duplicate prevention strategy approved.
* Moderation policy approved.
* Privacy policy approved.
* Emulator tests designed.
* Rollback/compatibility plan approved.
* Owner approval documented.

---

## 14. Risks

### Runtime Risks

* كسر صفحة review الحالية.
* كسر profile summaries.
* ظهور تقييمات ناقصة أو مكررة.
* اختلاف بين legacy data وTrust read models.

### Data Risks

* duplicate reviews.
* orphan reviews بدون provider واضح.
* requestId قديم لا يشير إلى request موجود.
* اختلاف تاريخ الإنشاء بين source والprojection.

### Trust Abuse Risks

* fake reviews.
* review bombing.
* provider manipulation.
* client spam.

### Moderation Risks

* review ظاهر قبل المراجعة.
* review مخفي بدون سجل شفاف.
* تضارب بين admin action وpublic visibility.

### Privacy Risks

* كشف بيانات علاجية داخل comment.
* ربط review بسياق session حساس.
* ظهور معلومات client غير مقصودة.

---

## 15. What Must Not Be Done

ممنوع الآن:

* إنشاء collections جديدة.
* نقل بيانات.
* تغيير Firestore rules.
* تغيير routes.
* تعديل `SessionReviewPage`.
* تعديل `sessionRatings`.
* تغيير profile pages.
* تغيير analytics.
* تغيير `requestId`.
* فصل runtime.
* تنفيذ migration.
* تنفيذ extraction.

أي خطوة تنفيذية لازم تنتظر اعتماد Blueprint وخطة تنفيذ منفصلة.

---

## 16. Final Verdict

نعم، Trust Domain هو:

```text
Mental Smile First Constitutional Extraction Candidate
```

السبب:

* يطابق هوية Mental Smile كسوق خدمات صحة نفسية قائم على الشفافية.
* reviews/ratings Core للثقة، وليست Core للحجز.
* فصل Trust يقلل اعتماد الواجهات العامة على `booking_requests`.
* Trust يمكن فصله تدريجيًا عبر projections وread models بدون Big Bang Migration.
* Booking وAccounting أكثر خطورة لأنهما Legacy/Optional/Quarantined.

الحكم النهائي:

```text
Trust should become an independent domain through ownership clarity, projections, read models, and rules design.

sessionRatings remains a legacy compatibility layer until safe extraction gates are satisfied.
```

هذا Blueprint لا يغير Runtime.

هذا Blueprint لا يغير Rules.

هذا Blueprint لا ينفذ Extraction.

هذا Blueprint يرسم فقط الشكل المستقبلي لـ Trust Domain.
