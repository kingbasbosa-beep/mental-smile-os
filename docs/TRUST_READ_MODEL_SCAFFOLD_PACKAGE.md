# TRUST_READ_MODEL_SCAFFOLD_PACKAGE

## 1. Executive Summary

نحتاج Trust Read Models قبل أي Trust Extraction لأن الواجهات العامة والتقارير لا يجب أن تفضل تقرأ مستقبلًا مباشرة من:

```text
sessionRatings
```

أو:

```text
booking_requests
```

السبب أن `sessionRatings` حاليًا مرتبطة تاريخيًا بـ request/session context، و`booking_requests` مصنفة كـ Frozen + Quarantined + Legacy Candidate. لو الواجهات فضلت تعتمد عليهم مباشرة، يبقى Trust Domain مش منفصل فعليًا، حتى لو غيرنا الأسماء.

Read Models هنا معناها surfaces مخصصة للقراءة فقط، تعبر عن Trust Domain بلغة واضحة:

* rating summary
* review feed
* trust history
* reputation snapshot

هذه الوثيقة لا تنشئ collections، ولا تغير runtime، ولا تنقل بيانات. هي فقط تصمم الشكل المستقبلي لأول Trust-owned read models.

---

## 2. Current Read Landscape

الاستهلاك الحالي للـ ratings/reviews/trust signals غالبًا يظهر في:

* provider profiles
* clinician public/profile pages
* center profiles
* public marketplace pages
* dashboards
* admin visibility
* reports
* analytics summaries

المشكلة الحالية:

* بعض الـ reads مرتبطة بـ `sessionRatings`.
* بعض السياقات تفهم review كامتداد لـ session أو booking.
* بعض التقارير قد تخلط بين trust data وlegacy request lifecycle.
* profile pages تحتاج reputation signal، وليس booking lifecycle.

الاتجاه الصحيح أن كل consumer يحتاج Trust data يقرأ من Trust Read Model، وليس من legacy source مباشرة.

---

## 3. Candidate Read Models

هذه Read Models مرشحة فقط. لا يتم تنفيذها الآن.

### ProviderTrustSummary

الغرض: summary سريع يعرض ثقة وسمعة مقدم الخدمة.

Candidate fields:

* `providerId`
* `providerType`
* `averageRating`
* `reviewCount`
* `trustScore`
* `transparencyFlags`
* `lastReviewAt`
* `lastUpdatedAt`

Use case:

* public profile header
* marketplace cards
* admin overview
* provider visibility summary

### ProviderReviewFeed

الغرض: عرض feed للتقييمات والمراجعات القابلة للظهور.

Candidate fields:

* `providerId`
* `reviews`
* `rating`
* `reviewDate`
* `visibilityStatus`
* `moderationStatus`
* `sourceType`
* `legacyReferenceId`

Use case:

* profile reviews tab
* public trust section
* admin moderation visibility

### TrustHistoryView

الغرض: timeline لتاريخ الثقة والشفافية.

Candidate fields:

* `providerId`
* `trustEvents`
* `moderationActions`
* `transparencyEvents`
* `eventDate`
* `actorRole`
* `visibility`

Use case:

* admin trust visibility
* transparency timeline
* future provider trust audit

### ProviderReputationSnapshot

الغرض: snapshot محسوبة لسمعة مقدم الخدمة.

Candidate fields:

* `providerId`
* `providerType`
* `score`
* `ratingTrend`
* `reviewVelocity`
* `transparencyScore`
* `calculatedAt`

Use case:

* analytics
* marketplace ranking signals
* reports
* admin trust dashboards

---

## 4. Consumer Mapping

| Read Model | Public Profile | Provider Dashboard | Admin Visibility | Reports | Analytics |
| --- | --- | --- | --- | --- | --- |
| ProviderTrustSummary | Yes | Yes | Yes | Yes | Yes |
| ProviderReviewFeed | Yes | Limited | Yes | Limited | Limited |
| TrustHistoryView | Limited | Limited | Yes | Yes | Limited |
| ProviderReputationSnapshot | Limited | Yes | Yes | Yes | Yes |

### Notes

* Public profile يحتاج summary وreviews الظاهرة فقط.
* Provider dashboard يحتاج صورة عن سمعته بدون امتلاك moderation.
* Admin visibility يحتاج history وmoderation context.
* Reports تحتاج snapshots أكثر من raw booking/session data.
* Analytics يجب أن تستهلك Trust-owned aggregates بدل legacy request lifecycle.

---

## 5. Projection Candidates

مصادر البيانات المستقبلية المحتملة:

* `sessionRatings`
* moderation records
* transparency records
* trust events
* provider profile verification data
* complaint visibility summaries

هذه Sources فقط، وليست Domain Owners.

المعنى:

```text
Legacy/source data
↓
Projection
↓
Trust Read Model
↓
Consumers
```

وليس:

```text
Consumers
↓
booking_requests/sessionRatings
```

`sessionRatings` قد تظل legacy input مؤقتًا، لكن Trust Domain يملك الـ read surface واللغة والملكية.

---

## 6. Ownership Boundaries

Trust Domain يملك:

* trust summaries
* ratings
* reviews
* reputation
* trust history
* transparency signals
* moderation visibility states

Trust Domain لا يملك:

* booking
* payment
* support ownership
* accounting
* payout
* commission
* session lifecycle
* treatment outcome

مسموح لـ Trust أن يحتفظ بـ legacy references للتوافق، لكن ممنوع أن تصبح هذه references هي المالك المعماري للتقييم.

---

## 7. Read Model Dependency Analysis

| Read Model | Coupling | Reason |
| --- | --- | --- |
| ProviderTrustSummary | Low | يمكن حسابه من مصادر متعددة ولا يحتاج booking lifecycle مباشرة |
| ProviderReviewFeed | Medium | غالبًا يحتاج legacy review source وmoderation visibility |
| TrustHistoryView | Medium | يحتاج دمج trust/moderation/transparency events |
| ProviderReputationSnapshot | High | يحتاج rules واضحة للحساب، analytics، وتجنب abuse أو bias |

### Low Coupling

`ProviderTrustSummary` هو أسهل candidate لأنه يعرض aggregates بسيطة.

### Medium Coupling

`ProviderReviewFeed` و`TrustHistoryView` يحتاجوا moderation وvisibility policies.

### High Coupling

`ProviderReputationSnapshot` أخطر لأنه قد يؤثر على ranking والظهور والثقة العامة.

---

## 8. Future API/View Direction

بدون تنفيذ، الاتجاه المنطقي للـ views أو endpoints المستقبلية:

### Provider Trust Summary

Purpose:

* إرجاع average rating، review count، trust score، transparency flags.

Logical shape:

```text
getProviderTrustSummary(providerId)
```

### Provider Review Feed

Purpose:

* إرجاع reviews الظاهرة وفق moderation/visibility.

Logical shape:

```text
getProviderReviewFeed(providerId, visibilityScope)
```

### Transparency Timeline

Purpose:

* عرض history للوثائق، التحقق، moderation، trust events.

Logical shape:

```text
getProviderTransparencyTimeline(providerId)
```

### Reputation Snapshot

Purpose:

* إرجاع calculated reputation score للعرض أو reports.

Logical shape:

```text
getProviderReputationSnapshot(providerId)
```

---

## 9. Test Scenario Design

هذه scenarios للتصميم فقط، ولا يتم تنفيذ tests الآن.

### Scenario 1 - New Review Added

Expected:

* review source يدخل projection.
* `reviewCount` يزيد.
* `averageRating` يعاد حسابه.
* `lastReviewAt` يتحدث.

### Scenario 2 - Duplicate Review Blocked

Expected:

* لا يتم احتساب review مكرر لنفس source/client/provider context.
* read model لا يتضاعف.
* duplicate prevention موثقة.

### Scenario 3 - Moderation Hides Review

Expected:

* review لا يظهر في public feed.
* summary يتبع policy المعتمدة: إما يحتسب أو يستبعد حسب القرار.
* trust history يسجل moderation action.

### Scenario 4 - Provider Profile Refresh

Expected:

* profile يقرأ summary جاهز.
* لا يقرأ booking lifecycle مباشرة.
* fallback legacy واضح لو read model غير متاح.

### Scenario 5 - Trust Score Recalculation

Expected:

* score يعاد حسابه من مصادر Trust-owned.
* calculation timestamp يتحدث.
* analytics لا تعتمد على raw `booking_requests`.

---

## 10. Compatibility Strategy

يمكن للـ Read Models أن تعيش مستقبلًا بينما:

* `sessionRatings` ما زالت موجودة.
* `booking_requests` ما زالت موجودة.

بدون كسر Runtime عبر الاستراتيجية التالية:

```text
Legacy stays readable
↓
Trust projections designed
↓
Read models introduced later
↓
Consumers switch gradually
↓
Legacy becomes read-only
↓
Archive/Burial when safe
```

في البداية، لا يتم تغيير write path. الهدف فقط أن يتحدد شكل القراءة المستقبلي. بعد ذلك يمكن تنفيذ projection layer لاحقًا بعد rules/tests/approval.

---

## 11. Extraction Readiness Contribution

Trust Read Models تساعد في:

### Trust Extraction

تفصل لغة القراءة عن legacy source، وتخلي Trust له surface واضح.

### Legacy Isolation

تمنع profile pages والتقارير من الاعتماد المباشر على `booking_requests`.

### Compatibility

تسمح بوجود legacy data في الخلفية بدون كسر المستخدم.

### Archive Safety

توضح ما الذي يجب حفظه كـ trust history وما الذي يبقى legacy reference فقط.

---

## 12. What Must Not Be Done

ممنوع الآن:

* إنشاء collections.
* migration.
* تغيير `SessionReviewPage`.
* نقل `sessionRatings`.
* تعديل rules.
* تعديل routes.
* تعديل profile pages.
* تغيير write path.
* تغيير requestId.
* تغيير status values.
* تنفيذ projection.
* تنفيذ extraction.

---

## 13. Final Verdict

نعم، Read Models هي الخطوة الصحيحة التالية قبل أي Trust Extraction فعلي.

السبب:

* تعطي Trust Domain سطح قراءة مستقل.
* تقلل الاعتماد المستقبلي على `sessionRatings` و`booking_requests`.
* تسمح بفصل تدريجي بدون Big Bang Migration.
* تساعد في تصميم rules/tests قبل التنفيذ.
* تحافظ على compatibility أثناء التحول.

الحكم النهائي:

```text
Trust Read Models should be designed before any runtime extraction.

They are the bridge between legacy sessionRatings and a future Trust-owned architecture.
```

هذا Package لا يغير Runtime.

هذا Package لا يغير Rules.

هذا Package لا ينفذ Extraction.

هذا Package يصمم فقط أول Trust Read Models المستقبلية.
