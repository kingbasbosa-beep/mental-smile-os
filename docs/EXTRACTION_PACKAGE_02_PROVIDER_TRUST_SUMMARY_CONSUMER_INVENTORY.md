# EXTRACTION_PACKAGE_02_PROVIDER_TRUST_SUMMARY_CONSUMER_INVENTORY

## 1. Executive Summary

Consumer Inventory ضروري قبل أي استخدام فعلي لـ `ProviderTrustSummary` لأن Read Surface لا يصبح آمنًا بمجرد وجود model أو mapper. الأهم هو معرفة:

* من سيقرأه؟
* من يعتمد حاليًا على `sessionRatings` أو `booking_requests`؟
* من يمكن نقله مبكرًا بأقل مخاطرة؟
* من يجب تأجيله لأنه مرتبط بتقارير أو أرشيف أو runtime aggregation حساس؟

الهدف من هذه الوثيقة هو حصر المستهلكين المحتملين فقط. لا يتم تعديل أي Consumer ولا UI ولا Runtime ولا Rules.

---

## 2. Current Trust Consumers

الأماكن المحتمل أنها تستهلك حاليًا ratings/reviews/trust signals:

* clinician profile.
* center profile.
* public provider pages.
* marketplace listing cards.
* client-facing provider discovery.
* provider dashboards.
* center dashboards.
* admin visibility pages.
* admin reports.
* analytics summaries.
* archive pages.
* future trust/transparency pages.

مصادر القراءة الحالية المحتملة:

* `sessionRatings`.
* legacy request/session context.
* derived values داخل profile أو dashboard.
* runtime aggregation.
* reports أو analytics summaries.

---

## 3. Consumer Classification

### Primary Consumer

مستهلك يعتمد مباشرة على trust summary في تجربة مستخدم أساسية:

* clinician public profile.
* center public profile.
* provider marketplace cards.

### Secondary Consumer

مستهلك يحتاج summary لدعم visibility أو decision support:

* admin visibility.
* reports.
* provider/center dashboards.

### Optional Consumer

مستهلك يمكن أن يستفيد من Trust summary لكن ليس ضروريًا في المرحلة الأولى:

* analytics experiments.
* ranking signals.
* provider self-insights.

### Future Consumer

مستهلك غير موجود أو غير مفعل بعد:

* trust profile pages.
* transparency timeline pages.
* reputation dashboards.
* external marketplace surfaces.

---

## 4. Dependency Mapping

| Consumer | Possible Current Dependency |
| --- | --- |
| clinician profile | `sessionRatings`, derived average, runtime aggregation |
| center profile | `sessionRatings`, derived average, runtime aggregation |
| public provider pages | profile-level derived values |
| marketplace cards | provider summary values or profile snapshots |
| provider dashboards | derived ratings, request/session summaries |
| center dashboards | derived ratings, request/session summaries |
| admin visibility | reports, `sessionRatings`, legacy request context |
| reports | analytics summaries, raw ratings, booking/session context |
| analytics | aggregates, summaries, historical reports |
| archive pages | legacy snapshots, `booking_requests`, rating references |

ملاحظة مهمة: أي dependency على `booking_requests` يجب أن يبقى compatibility-only، وليس ownership.

---

## 5. ProviderTrustSummary Adoption Candidates

أفضل candidates للانتقال مستقبلًا إلى `ProviderTrustSummary` بأقل مخاطرة:

* provider marketplace cards.
* clinician public profile header.
* center public profile header.
* simple admin overview display.

سبب انخفاض المخاطرة:

* تحتاج summary فقط، وليس raw review feed.
* لا تغير write path.
* لا تحتاج moderation workflow كامل.
* يمكنها دعم fallback لو summary غير متاح.

---

## 6. High Risk Consumers

Consumers لا يجب أن تنتقل مبكرًا:

* reports الرسمية.
* analytics التي تستخدم historical comparisons.
* archive pages.
* ranking/reputation systems.
* admin moderation views.

السبب:

* ممكن يحصل reporting mismatch.
* قد تظهر اختلافات بين legacy aggregation وTrust summary.
* archive يحتاج historical fidelity.
* ranking يحتاج policy واضحة لمنع trust abuse أو bias.
* moderation يحتاج visibility rules قبل الاعتماد.

---

## 7. Compatibility Impact Analysis

يمكن إدخال `ProviderTrustSummary` مستقبلًا بدون كسر runtime عبر:

```text
Legacy source remains readable
↓
ProviderTrustSummary becomes optional read surface
↓
Low-risk consumers read summary with fallback
↓
Reports compare old/new values
↓
High-risk consumers switch only after validation
```

للحفاظ على التوافق:

* لا يتم تغيير `SessionReviewPage`.
* لا يتم تغيير `sessionRatings`.
* لا يتم تغيير `booking_requests`.
* لا يتم تغيير archives.
* لا يتم إجبار reports أو dashboards على switch مبكر.
* fallback مطلوب لأي consumer ينتقل مستقبلًا.

---

## 8. Consumer Readiness Matrix

| Consumer | Current Source | Future Source | Risk Level | Migration Readiness |
| --- | --- | --- | --- | --- |
| provider marketplace cards | derived/profile values | `ProviderTrustSummary` | Low | High |
| clinician profile header | `sessionRatings` or derived values | `ProviderTrustSummary` | Low | High |
| center profile header | `sessionRatings` or derived values | `ProviderTrustSummary` | Low | High |
| public reviews section | raw reviews / `sessionRatings` | `ProviderReviewFeed` later | Medium | Medium |
| provider dashboard | derived values | `ProviderTrustSummary` | Medium | Medium |
| center dashboard | derived values | `ProviderTrustSummary` | Medium | Medium |
| admin overview | reports/derived values | `ProviderTrustSummary` | Medium | Medium |
| admin moderation views | raw reviews/moderation context | Trust moderation surface later | High | Low |
| reports | analytics summaries/raw data | Trust summaries after validation | High | Low |
| analytics | aggregates/historical summaries | `ProviderReputationSnapshot` later | High | Low |
| archive pages | legacy snapshots | archive-safe trust references | High | Low |
| ranking systems | derived/rules-specific values | Trust/reputation snapshots later | High | Low |

---

## 9. Safe Adoption Order

من الأسهل إلى الأصعب:

1. Marketplace listing cards.
2. Clinician profile header.
3. Center profile header.
4. Simple public profile trust summary.
5. Provider dashboard summary.
6. Center dashboard summary.
7. Admin overview display.
8. Public review feed.
9. Reports.
10. Analytics.
11. Ranking/reputation systems.
12. Archive pages.
13. Admin moderation views.

القاعدة:

```text
Summary display first.
Raw reviews and policy-heavy consumers later.
```

---

## 10. Extraction Readiness Contribution

هذا التحليل يساعد أول Extraction فعلي لاحقًا لأنه:

* يحدد أقل consumers مخاطرة.
* يمنع switch عشوائي للـ reports أو archives.
* يوضح أين نحتاج fallback.
* يفصل بين read surface وwrite path.
* يثبت أن Trust extraction يبدأ بالعرض والقراءة وليس بنقل البيانات.
* يحمي compatibility layer من كسر deep runtime dependencies.

---

## 11. What Must Not Be Done

ممنوع في هذا الـ Package:

* تعديل أي Consumer.
* تعديل أي UI.
* تعديل أي Route.
* تعديل أي Runtime.
* تعديل أي Rule.
* تغيير `SessionReviewPage`.
* تغيير `sessionRatings`.
* تغيير `booking_requests`.
* تشغيل migration.
* إنشاء collections.
* تنفيذ Extraction.

---

## 12. Final Verdict

لدينا رؤية تصميمية واضحة لمستهلكي `ProviderTrustSummary` المستقبليين، لكن هذه ليست موافقة تنفيذية على نقل أي consumer الآن.

أول adoption آمن مستقبلًا يجب أن يبدأ من:

```text
Marketplace cards
↓
Public profile headers
↓
Simple admin overview
```

ويجب تأجيل:

```text
Reports
Analytics
Archives
Moderation
Ranking
```

حتى تكتمل سياسات projection وfallback وvalidation.

هذا Package لا يغير Runtime.

هذا Package لا يغير Rules.

هذا Package لا ينفذ Extraction.

هذا Package يحصر فقط مستهلكي `ProviderTrustSummary` المستقبليين.
