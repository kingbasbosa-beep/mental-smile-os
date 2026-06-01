# TRUST_FOUNDATION_REVIEW_PACKAGE

## 1. Executive Summary

Trust Foundation V1 جاهزة مبدئيًا كـ foundation صغيرة وآمنة للـ Trust Read Surface.

ما تم بناؤه حتى الآن يمثل بداية صحيحة:

* `ProviderTrustSummary` كـ immutable read model.
* `ProviderTrustSummaryMapper` كـ pure mapper من raw maps.
* `ProviderTrustSummaryContract` كـ future-facing contract بدون implementation.
* `trust_domain.dart` كـ barrel export.
* unit tests وfixtures بدون Firebase أو Firestore.

لا يوجد ما يستدعي إيقاف التوسع، لكن قبل أي fake implementation أو provider لاحقًا يجب الانتباه لمخاطر مهمة: sync contract، تاريخ `lastCalculatedAt` غير deterministic داخل mapper، والتعامل مع decimal ratings في star distribution.

الحكم المختصر:

```text
Safe to proceed cautiously.
No runtime extraction yet.
```

---

## 2. File Review

### `lib/features/trust/domain/models/provider_trust_summary.dart`

Purpose:

* تعريف read model/value object لـ `ProviderTrustSummary`.

Correctness:

* الحقول immutable باستخدام `final`.
* يوجد constructor واضح.
* يوجد `empty`, `copyWith`, `toMap`, `fromMap`.
* يوجد getters: `hasReviews`, `displayAverage`, `totalStarCount`.
* parsing دفاعي للأرقام والتواريخ.

Boundary Safety:

* لا Firebase.
* لا Flutter widgets.
* لا Firestore.
* لا runtime dependency.

Risks:

* `copyWith` يستخدم flags لمسح التواريخ، وهذا مقبول لكنه يحتاج consistency لو زادت nullable fields لاحقًا.
* `toMap/fromMap` تستخدم ISO strings للتواريخ، وهذا جيد كـ plain Dart لكنه ليس Firestore-specific.

Recommendation:

* Safe.
* لا يحتاج تصحيح فوري.

### `lib/features/trust/domain/mappers/provider_trust_summary_mapper.dart`

Purpose:

* تحويل `List<Map<String, dynamic>>` خام إلى `ProviderTrustSummary`.

Correctness:

* يحسب average.
* يحسب review count.
* يحسب star distribution.
* يتجاهل invalid values.
* يدعم keys متعددة: `rating`, `score`, `stars`.
* يقرأ تواريخ plain Dart/String.

Boundary Safety:

* لا Firebase.
* لا Firestore.
* لا services/repositories/providers.
* لا Future/Stream.

Risks:

* `lastCalculatedAt: DateTime.now()` يجعل النتائج غير deterministic بالكامل، لكنه مقبول لأن tests لا تعتمد عليه.
* decimal rating مثل `4.5` يتم احتسابه في average ويصنف كـ 5 نجوم بسبب `round()`. هذا قرار مؤقت يحتاج policy لاحقًا.
* `trustScore = averageRating` صحيح مؤقتًا، لكن يجب ألا يتحول إلى policy دائمة بدون approval.

Recommendation:

* Safe now.
* يجب توثيق rating rounding policy قبل production adoption.

### `lib/features/trust/domain/contracts/provider_trust_summary_contract.dart`

Purpose:

* تعريف contract للحصول على `ProviderTrustSummary` بدون معرفة المصدر.

Correctness:

* API واضحة وبسيطة:

```dart
ProviderTrustSummary getSummaryForProvider(String providerId);
```

Boundary Safety:

* لا Future.
* لا Stream.
* لا Firebase.
* لا implementation.

Risks:

* sync API مناسب الآن كـ contract خفيف، لكن implementation حقيقية قد تحتاج async مستقبلًا لو المصدر remote.
* يجب عدم استخدام هذا contract مع Firestore مباشرة قبل تصميم layer منفصلة.

Recommendation:

* Safe now.
* عند أول implementation حقيقي، راجع هل sync مناسب أم نحتاج contract جديد async منفصل.

### `lib/features/trust/domain/trust_domain.dart`

Purpose:

* barrel export للـ Trust domain primitives.

Correctness:

* يصدر model.
* يصدر mapper.
* يصدر contract.

Boundary Safety:

* لا imports.
* لا runtime usage.
* لا Firebase/Firestore.

Risks:

* لا توجد مخاطر حالية.

Recommendation:

* Safe.

### `test/features/trust/domain/mappers/provider_trust_summary_mapper_test.dart`

Purpose:

* unit tests لـ `ProviderTrustSummaryMapper.fromRatings`.

Correctness:

* تغطي empty list.
* تغطي single rating.
* تغطي multiple ratings.
* تغطي invalid values.
* تغطي decimal/string handling.
* تغطي `trustScore = averageRating`.
* تغطي `totalStarCount`.
* تغطي `hasReviews`.
* تغطي `lastReviewAt`.

Boundary Safety:

* لا Firebase.
* لا Firestore mocks.
* لا integration tests.

Risks:

* الاختبارات تعتمد على import نسبي من test إلى lib، وقد يكون مقبولًا في المشروع لكن package imports قد تكون أنظف لاحقًا.
* لم يتم تشغيل tests في هذه المراجعة حسب boundary.

Recommendation:

* Safe.
* لاحقًا يمكن إضافة tests للـ `fromMap/toMap` في model package منفصل.

### `test/features/trust/fixtures/provider_trust_summary_fixtures.dart`

Purpose:

* توفير raw ratings وexpected summaries للاختبارات المستقبلية.

Correctness:

* بيانات صغيرة وواضحة.
* لا Firestore-like objects.
* توفر empty/single/mixed/invalid/string-decimal fixtures.

Boundary Safety:

* لا Firebase.
* لا Firestore.
* لا mocks.
* لا collection names.

Risks:

* `expectedMixedSummary.lastCalculatedAt` = null بينما mapper ينتج `DateTime.now()`، لذلك لا يجب مقارنة object كامل مباشرة بدون تجاهل هذا الحقل.

Recommendation:

* Safe.
* لو توسعت tests، يجب مقارنة fields محددة أو توفير helper comparison.

---

## 3. Boundary Check

لا يظهر أي تسريب لـ:

* Firebase.
* Firestore.
* Runtime flows.
* UI.
* routes.
* `booking_requests`.
* direct `sessionRatings` dependency.
* `SessionReviewPage`.
* collections.
* migration.

الـ mapper يتعامل فقط مع:

```text
List<Map<String, dynamic>>
```

وهذا plain Dart source وليس Firestore source.

---

## 4. Model Review

### Immutability

جيدة. كل الحقول `final` والconstructor واضح.

### Fields

الحقول تطابق Blueprint:

* `providerId`
* `providerType`
* `averageRating`
* `reviewCount`
* star counts
* `trustScore`
* `lastReviewAt`
* `lastCalculatedAt`
* `sourceVersion`

### Empty Factory

مناسبة كبداية وتسمح بملء provider identity اختياريًا.

### toMap/fromMap

Plain Dart mapping مناسب. لا يحتوي على Firestore assumptions.

### copyWith

مناسب. وجود clear flags للتواريخ مفيد بسبب nullable fields.

### Getters

* `hasReviews` واضح.
* `displayAverage` بسيط ومناسب كـ display helper.
* `totalStarCount` مهم لاختبارات consistency.

### Defensive Parsing

جيد للأرقام والتواريخ. لا يقبل string numbers، وهذا قرار defensive آمن.

---

## 5. Mapper Review

### Responsibility

المسؤولية محدودة وواضحة: raw maps إلى summary.

### Defensive Aggregation

جيدة. invalid ratings خارج 1-5 يتم تجاهلها.

### Invalid Values

يتجاهل:

* null.
* bool.
* strings.
* أقل من 1.
* أكبر من 5.

### String/Decimal Handling

* string ratings يتم تجاهلها.
* decimal ratings يتم قبولها للـ average.

### Star Distribution

يستخدم `round().clamp(1, 5)`.

مخاطرة لاحقة:

* `4.5` يصبح 5-star.
* قد تحتاج policy لاحقًا: round أو floor أو nearest bucket.

### trustScore TODO

موجود وواضح:

```text
trustScore = averageRating
```

هذا مناسب مؤقتًا، بشرط ألا يستخدم كـ official reputation policy.

---

## 6. Contract Review

### API Clarity

واضحة جدًا:

```dart
ProviderTrustSummary getSummaryForProvider(String providerId);
```

### Sync vs Async Choice

sync مناسب في foundation الحالية لأنه لا يوجد implementation ولا Firestore.

لكن مستقبلًا:

* fake provider يمكن أن يكون sync.
* memory provider يمكن أن يكون sync.
* remote datasource سيحتاج async contract منفصل أو layer مختلفة.

### Should It Stay Simple Now

نعم. إبقاؤه بسيطًا يمنع إدخال runtime assumptions مبكرًا.

### Future Implementation Risks

* لا يجب أن يتحول contract مباشرة إلى Firestore repository.
* لا يجب أن يفرض sync على مصادر remote.
* لا يجب أن يستخدم داخل UI قبل adoption plan.

---

## 7. Tests Review

### Coverage

التغطية جيدة للـ mapper:

* empty.
* single.
* mixed valid.
* invalid values.
* decimal/string.
* trust score.
* star totals.
* last review date.

### Fixture Usage

جيد. fixtures تقلل duplication وتجهز لاختبارات لاحقة.

### Missing Cases

يمكن لاحقًا إضافة:

* model `toMap/fromMap` roundtrip.
* `copyWith` nullable date clearing.
* unknown date format.
* conflicting rating keys in same map.
* negative decimal values.

### Overengineering Risk

منخفض. الملفات صغيرة ومحدودة.

---

## 8. Architecture Fit

ما تم بناؤه يمثل:

```text
Trust Read Surface Foundation
```

وليس مجرد utility code.

السبب:

* يوجد domain model.
* يوجد mapper pure.
* يوجد contract يفصل consumer عن source.
* يوجد barrel export.
* توجد tests وfixtures.
* لا يوجد runtime coupling أو Firestore dependency.

هذا هو الشكل الصحيح لأول Trust foundation قبل أي read model adoption فعلي.

---

## 9. Risks Before Next Package

قبل إضافة fake implementation أو provider لاحقًا، يجب الانتباه إلى:

* عدم ربط fake provider بأي UI.
* عدم استخدام Firestore أو `sessionRatings`.
* عدم تحويل contract إلى repository implementation.
* تحديد هل fake provider سيكون sync memory فقط.
* عدم تغيير barrel exports بطريقة تكسر imports.
* عدم إدخال Provider/Riverpod/DI قبل package منفصل واضح.
* عدم استخدام `trustScore` كقرار ranking أو visibility.
* عدم الاعتماد على `DateTime.now()` في tests بشكل brittle.

---

## 10. Recommendations

### Must Fix Now

لا يوجد must-fix يمنع التوسع.

### Should Fix Later

* توثيق rounding policy للـ decimal ratings.
* إضافة model roundtrip tests.
* تحديد async strategy قبل أي implementation حقيقي.
* إضافة comparison helper لو زادت expected summaries في fixtures.

### Safe To Proceed

آمن الانتقال إلى fake provider package بشرط:

* يكون fake/in-memory فقط.
* لا يقرأ Firestore.
* لا يكتب Firestore.
* لا يربط UI.
* لا يغير runtime.

---

## 11. Final Verdict

يمكن الانتقال إلى:

```text
CODE_PACKAGE_09_FAKE_PROVIDER_TRUST_SUMMARY_PROVIDER
```

بشرط أن يكون Fake Provider فقط، داخل Trust domain/test-safe boundary، وبدون أي runtime usage أو Firebase/Firestore.

الحكم النهائي:

```text
Trust Foundation V1 is architecturally sound as a read-surface foundation.

It is not an extraction yet, and must remain isolated until adoption gates are approved.
```

هذا Review لا يغير Runtime.

هذا Review لا يغير Rules.

هذا Review لا ينفذ Extraction.

هذا Review يراجع فقط Trust Foundation V1.
