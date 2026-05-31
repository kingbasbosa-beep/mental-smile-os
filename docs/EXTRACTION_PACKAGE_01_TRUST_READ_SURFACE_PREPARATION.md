# EXTRACTION_PACKAGE_01_TRUST_READ_SURFACE_PREPARATION

## 1. Executive Summary

`ProviderTrustSummary` هو أول Extraction Candidate آمن لأنه Read Surface وليس Data Extraction.

المقصود:

```text
Read Surface Extraction
```

وليس:

```text
Data Extraction
```

Read Surface تسبق Collections وRules وWrites وMigration لأنها تسمح بتحديد شكل القراءة المستقبلي بدون تغيير المصدر الحالي أو كسر runtime.

`ProviderTrustSummary` مناسب كبداية لأنه:

* aggregate بسيط ومفهوم.
* يخدم profile pages والتقارير.
* لا يحتاج تغيير `SessionReviewPage`.
* لا يحتاج نقل `sessionRatings`.
* لا يحتاج تعديل `booking_requests`.
* يقلل مستقبلًا قراءة الواجهات المباشرة من legacy sources.

---

## 2. Current State

الوضع الحالي تقريبيًا:

```text
Profiles
↓
sessionRatings
↓
booking dependencies
```

مناطق التشابك:

* `sessionRatings` يحمل Trust meaning لكنه مرتبط تاريخيًا بـ session/request context.
* بعض profile/report consumers قد يفهموا ratings كجزء من booking lifecycle.
* `requestId` وlegacy references تخلق coupling مع `booking_requests`.
* review creation path لا يزال حساس ولا يجب لمسه الآن.
* reports والarchives قد تقرأ rating أو session data من نفس legacy context.

المشكلة ليست في وجود ratings، بل في أن surface القراءة غير مفصول عن legacy lifecycle.

---

## 3. Target State

الشكل المستهدف:

```text
Legacy Sources
↓
Compatibility Projection
↓
ProviderTrustSummary
↓
Consumers
```

المعنى:

* `sessionRatings` يبقى مصدر legacy مؤقت.
* projection layer مستقبلية تحسب summary.
* consumers تقرأ من `ProviderTrustSummary`.
* Trust Domain يصبح صاحب لغة القراءة والملكية.

هذا لا يعني إنشاء collection الآن. هذه وثيقة تصميم فقط.

---

## 4. ProviderTrustSummary Definition

Read Model منطقي فقط:

| Field | Purpose |
| --- | --- |
| `providerId` | معرف مقدم الخدمة |
| `providerType` | clinician أو center أو نوع مقدم آخر |
| `averageRating` | متوسط التقييمات القابلة للاحتساب |
| `reviewCount` | عدد المراجعات/التقييمات المحتسبة |
| `fiveStarCount` | عدد تقييمات 5 نجوم |
| `fourStarCount` | عدد تقييمات 4 نجوم |
| `threeStarCount` | عدد تقييمات 3 نجوم |
| `twoStarCount` | عدد تقييمات 2 نجمة |
| `oneStarCount` | عدد تقييمات 1 نجمة |
| `trustScore` | score مستقبلي محسوب وفق policy |
| `lastReviewAt` | آخر وقت review محتسب |
| `lastCalculatedAt` | آخر وقت حساب للـ summary |
| `sourceVersion` | version لمنطق projection لاحقًا |

ملاحظات:

* `trustScore` لا يجب أن يكون arbitrary قبل policy.
* star counts تساعد profile UI بدون قراءة raw reviews.
* `sourceVersion` مهم لتجنب reporting drift مستقبلًا.

---

## 5. Candidate Consumers

المستهلكون المحتملون لـ `ProviderTrustSummary`:

* provider public profile.
* clinician profile.
* center profile.
* marketplace listing cards.
* admin visibility.
* reports.
* analytics.
* future transparency pages.

الاستخدام:

* عرض rating summary.
* عرض review count.
* عرض trust score لو policy جاهزة.
* تقليل الحاجة لقراءة raw `sessionRatings` داخل profiles.

---

## 6. Compatibility Projection Design

تصميم نظري فقط:

```text
sessionRatings
↓
filter visible/eligible ratings
↓
aggregate by providerId/providerType
↓
calculate average/count/star distribution
↓
ProviderTrustSummary
```

بدون تعديل Runtime:

* لا يتم تغيير write path.
* لا يتم تغيير `SessionReviewPage`.
* لا يتم نقل data.
* لا يتم إنشاء collection.
* لا يتم تعديل rules.

`sessionRatings` هنا Source فقط، وليس Domain Owner.

القانون:

```text
Projection reads from legacy.
Trust owns the resulting read surface.
```

---

## 7. Dependency Impact Analysis

إذا تم تصميم Read Surface مستقبلًا، ما الذي لا يتأثر:

### SessionReviewPage

لا يتغير. يظل write path كما هو حتى readiness كاملة.

### booking_requests

لا يتغير. لا حذف، لا mutation، لا migration.

### routes

لا تتغير. profiles والlegacy routes تظل كما هي حتى package تنفيذ منفصل.

### Firestore rules

لا تتغير الآن. أي rules design يأتي لاحقًا.

### archives

لا تتغير. archive يظل legacy-readable.

### sessionRatings

لا يتم نقلها أو تعديلها. تظل source مؤقت.

---

## 8. Risk Analysis

### Stale Projections

الخطر: summary لا يعكس آخر ratings.

احتواء مستقبلي:

* `lastCalculatedAt`.
* refresh policy.
* fallback display rules.

### Trust Score Drift

الخطر: trust score يتغير بسبب logic مختلف أو غير موثق.

احتواء مستقبلي:

* `sourceVersion`.
* calculation policy.
* reproducible scoring rules.

### Duplicate Aggregation

الخطر: review واحد يحتسب أكثر من مرة.

احتواء مستقبلي:

* duplicate prevention design.
* source identity.
* reviewer/provider/context uniqueness.

### Reporting Mismatch

الخطر: reports القديمة تعطي أرقام مختلفة عن summary الجديد.

احتواء مستقبلي:

* report compatibility notes.
* side-by-side validation.
* migration-free reconciliation قبل consumer switch.

---

## 9. Extraction Readiness Gates

قبل التنفيذ الفعلي يجب تحقق:

* consumer inventory approved.
* trust blueprint approved.
* compatibility plan approved.
* manual QA scenarios documented.
* aggregation policy approved.
* duplicate prevention strategy approved.
* moderation visibility policy approved.
* fallback behavior approved.
* rules design مكتوبة قبل أي rules change.
* Owner approval.

---

## 10. Future Expansion Path

بعد نجاح `ProviderTrustSummary` يمكن التوسع إلى:

### ProviderReviewFeed

عرض reviews الظاهرة والمصرح بها.

### TrustHistoryView

عرض timeline للثقة والشفافية وmoderation actions.

### ProviderReputationSnapshot

حساب reputation أكثر تقدمًا للتقارير والتحليلات.

ترتيب منطقي:

```text
ProviderTrustSummary
↓
ProviderReviewFeed
↓
TrustHistoryView
↓
ProviderReputationSnapshot
```

---

## 11. What Must Not Be Done

ممنوع الآن:

* إنشاء collections.
* تعديل `SessionReviewPage`.
* تعديل `sessionRatings`.
* تغيير rules.
* تغيير routes.
* migration.
* نقل البيانات.
* تعديل `booking_requests`.
* تغيير write path.
* تغيير `requestId`.
* تنفيذ projection.
* تنفيذ extraction.

---

## 12. Final Verdict

نعم، `ProviderTrustSummary` هو أول مولود دستوري آمن من Trust Domain.

السبب:

* يبدأ من القراءة وليس الكتابة.
* لا يمس legacy writes.
* لا يحتاج migration.
* يعطي consumers surface واضح بدل raw legacy reads.
* يمهد لفصل Trust تدريجي بدون كسر Runtime.

الحكم النهائي:

```text
ProviderTrustSummary is the safest first Trust Read Surface Extraction Candidate.

It prepares ownership and consumption before data movement, rules changes, or runtime extraction.
```

هذا Package لا يغير Runtime.

هذا Package لا يغير Rules.

هذا Package لا ينفذ Extraction.

هذا Package يصمم فقط أول Read Surface Extraction Candidate في Mental Smile.
