# FEDERATED_EXTRACTION_ROADMAP_V1

## 1. Executive Summary

Mental Smile بقت جاهزة تنتقل من مرحلة `discovery/audit` إلى مرحلة `phased extraction planning`.

الهدف مش تنفيذ فصل دلوقتي، لكن ترتيب الطريق الآمن للتحول إلى:

```text
Mental Smile = Mental Health Services Marketplace
```

مع فصل تدريجي لـ:

* Trust Domain
* Provider Contact Request
* Service Coordination
* Support ownership
* Optional Accounting Module
* Legacy `booking_requests` burial

ترتيب التنفيذ لازم يكون تدريجي:

```text
Visibility
↓
Language
↓
Ownership
↓
Read Models
↓
Compatibility
↓
Rules Design
↓
Extraction
↓
Archive
↓
Burial
```

أي محاولة تبدأ بـ migration أو rules rewrite أو collection rename قبل وضوح الملكية تعتبر خطر معماري.

---

## 2. Current Constitutional State

القرارات النهائية الحاكمة:

* Mental Smile ليست Booking Platform.
* Mental Smile هي Mental Health Services Marketplace.
* `booking_requests` لا تعيش كـ Core.
* الناجي المحتمل من `booking_requests` هو `Provider Contact Request + Service Coordination`.
* Reviews/Ratings ملك `Trust & Transparency Domain`.
* Support يملك الشكاوى والتصعيد.
* Accounting إما Optional Module أو Burial.
* Payment ownership خارج Core Mental Smile.
* Trust يملك السمعة والشفافية، وليس Booking.
* Support يملك الدعم، وليس Booking.
* أي Optional Module يجب ألا يتحول إلى hidden Core Dependency.

---

## 3. Extraction Principles

مبادئ التنفيذ:

* No Big Bang Migration.
* No Rules Rewrite First.
* No Collection Rename First.
* No Runtime Rewrite First.
* No Cross-Domain Collections.
* Optional Modules must never become Core Dependencies.
* Legacy stays until compatibility is safe.
* Direct routes القديمة تبقى لحد ما deep links تكون مفهومة.
* Read models تتصمم قبل أي runtime dependency switch.
* Archive safety لازم تسبق Burial.
* Owner approval مطلوب قبل أي فصل فعلي.

---

## 4. Phase 0 - Documentation Lock

### الهدف

تثبيت الوثائق الحاكمة كمرجعية معمارية قبل أي تنفيذ.

### يشمل

* Owner Decisions.
* Trust Blueprint.
* Booking Survivability Blueprint.
* Freeze Map.
* Federated Extraction Roadmap.

### المسموح

* docs only.
* توثيق قرارات.
* تثبيت boundaries.

### الممنوع

* code changes.
* rules changes.
* migrations.
* route changes.
* collection changes.

### Exit Criteria

* الوثائق موجودة ومعتمدة.
* لا توجد قرارات Owner مفتوحة حول booking/payment/trust/support.
* كل تقرير لاحق يرجع لهذه الوثائق بدل إعادة فتح نفس النقاش.

---

## 5. Phase 1 - Visibility & Language Containment

### الهدف

تقليل ظهور booking/payment/accounting كأنهم Core داخل UI.

### يشمل

* UI copy containment.
* admin legacy wording.
* provider/center service coordination wording.
* client payment proof hidden from dashboard.
* no route deletion.
* no page deletion.

### الممنوع

* route deletion.
* rules changes.
* query changes.
* service/adapters changes.
* collection changes.

### Exit Criteria

* Core UI لا يبيع Mental Smile كـ Booking Platform.
* financial wording يظهر كـ legacy/optional فقط.
* client/provider/admin language لا توحي أن المنصة تملك العلاج أو الدفع.
* direct legacy routes لا تنكسر.

---

## 6. Phase 2 - Trust Read Model Design

### الهدف

تصميم Trust-owned read models بدون تنفيذ.

### يشمل

* `provider_reviews`
* `provider_ratings`
* `trust_history`
* `transparency_events`
* `provider_reputation_snapshots`

### الممنوع

* إنشاء collections.
* migration.
* تعديل `SessionReviewPage`.
* تعديل `sessionRatings`.
* تعديل profile pages.

### Exit Criteria

* Trust read model واضح.
* projection strategy موثقة.
* consumers معروفين.
* boundaries بين Trust وBooking وSupport واضحة.

---

## 7. Phase 3 - SessionReview Write Verification

### الهدف

تأكيد exact writes داخل `SessionReviewPage` قبل أي فصل.

### يشمل

* exact fields.
* write order.
* batch/transaction status.
* duplicate prevention.
* failure behavior.
* request/status mutations.

### الممنوع

* تعديل writes.
* تغيير rules.
* تغيير `requestId`.
* تغيير status values.
* نقل `sessionRatings`.

### Exit Criteria

* كل write معروف.
* كل mutation معروف.
* كل risk موثق.
* أول break points للفصل واضحة.

---

## 8. Phase 4 - Provider Contact / Service Coordination Design

### الهدف

تحويل الناجي من `booking_requests` إلى capability صغيرة وواضحة.

### يشمل

* Provider Contact Request.
* Service Coordination.
* Provider Request Inbox.
* Client Request History.
* Admin Exception Visibility.

### الممنوع

* إنشاء successor collections.
* تغيير routes.
* migration.
* تغيير queries.
* تغيير status values.

### Exit Criteria

* fields معتمدة.
* statuses معتمدة.
* لا payment/accounting/trust/support ownership داخل الكيان الجديد.
* admin visibility معرفة كـ exception visibility فقط.

---

## 9. Phase 5 - Compatibility Layer Design

### الهدف

تحديد كيف يعيش `booking_requests` أثناء التحول.

### يشمل

* legacy read behavior.
* deep links.
* archive bridges.
* old request history.
* old payment proof archive.
* old session fields.
* dashboards التي ما زالت تعتمد على legacy counts.

### الممنوع

* read-only rules change قبل tests.
* حذف routes.
* حذف pages.
* دفن بيانات قبل archive safety.

### Exit Criteria

* كل legacy consumer معروف.
* كل deep link معروف.
* archive behavior واضح.
* read-only direction موثقة لكن غير منفذة.

---

## 10. Phase 6 - Rules Design

### الهدف

تصميم Rules المستقبلية فقط، بدون تعديل `firestore.rules`.

### يشمل

* Trust rules.
* Provider Contact rules.
* Service Coordination rules.
* Optional Accounting rules.
* Legacy read-only rules.
* moderation boundaries.
* public/private trust visibility.

### الممنوع

* تعديل `firestore.rules` الآن.
* deploy.
* emulator execution داخل هذه المرحلة.
* فتح writes جديدة قبل tests.

### Exit Criteria

* rules design مكتوبة.
* test scenarios مكتوبة.
* Owner approval قبل التنفيذ.
* كل rule مرتبطة بـ Domain أو Optional Module واضح.

---

## 11. Phase 7 - First Safe Extraction Packages

هذه packages تنفيذ مستقبلية مقترحة فقط، ولا يتم تنفيذ أي شيء في هذه الوثيقة.

### Package 1

Trust read model scaffold docs/tests only.

الغرض: تثبيت model shape وtest scenarios بدون runtime switch.

### Package 2

Trust projection design implementation plan.

الغرض: تحديد كيف تتحول legacy ratings إلى Trust projection لاحقًا.

### Package 3

Provider contact request model design.

الغرض: تثبيت fields/statuses والفرق بين contact request وbooking.

### Package 4

Legacy booking read-only plan.

الغرض: تصميم مسار تحويل `booking_requests` إلى compatibility/read-only لاحقًا.

### Package 5

Financial write freeze plan.

الغرض: وقف أي توسع مستقبلي في payment/accounting/commission قبل archive/burial.

---

## 12. Phase 8 - Archive Strategy

### الهدف

تحويل legacy financial/session/review data إلى archive-safe surfaces.

### يشمل

* payment proof archive-only.
* accounting archive-only or optional module.
* old session history.
* trust source references.
* historical request snapshots.
* compatibility-only financial records.

### الاتجاه

Archive لا يملك Domain. هو يحتفظ بتاريخ آمن ومنظم بعد وضوح المالك الحقيقي لكل معلومة.

---

## 13. Phase 9 - Burial Strategy

### الهدف

دفن العناصر التي ثبت عدم حاجتها بعد اكتمال التوافق والأرشفة.

### يشمل

* `bookingRequests`.
* disabled mirror writes.
* dead center CTA blocks.
* payment proof flow بعد archive.
* commission/payout semantics.
* duplicated legacy dashboards.

### الممنوع

* burial قبل tests.
* burial قبل Owner approval.
* burial قبل archive safety.
* burial قبل معرفة كل consumer.

---

## 14. Risk Matrix

| Risk Area | Risk | Mitigation Direction |
| --- | --- | --- |
| Runtime | كسر صفحات legacy أو deep links | compatibility layer قبل extraction |
| Firestore rules | فتح أو كسر permissions | rules design + emulator tests قبل التعديل |
| Data compatibility | fields مختلطة داخل legacy documents | inventory + read models + archive strategy |
| UX confusion | المستخدم يظن المنصة Booking/Payment Platform | visibility/language containment |
| Admin workflows | admin يظن financial tools Core | legacy/optional wording + module boundaries |
| Provider inbox | provider يعتمد على booking language | Provider Request Inbox wording/design |
| Client history | client يفقد history قديم | legacy request history + archive bridge |
| Trust abuse | reviews مزيفة أو مكررة | moderation + duplicate prevention strategy |
| Privacy | review يكشف بيانات علاجية | moderation boundaries + visibility rules |
| Archive/report drift | تقارير قديمة لا تطابق read models الجديدة | archive snapshots + migration-free compatibility plan |

---

## 15. Manual QA Strategy

هذه strategy مستقبلية بدون أوامر.

### Client Journey

* فتح dashboard.
* التأكد أن payment proof لا يظهر كـ Core.
* فتح direct legacy routes للتوافق.
* مراجعة client request history مستقبلًا.

### Provider Journey

* فتح provider inbox.
* التأكد من language الخاصة بـ service requests.
* التأكد أن payment/accounting غير ظاهرين كملكية provider inbox.

### Center Journey

* فتح center dashboard.
* مراجعة service coordination wording.
* التأكد أن center لا يرى booking كـ Core platform promise.

### Admin Journey

* فتح admin hub.
* مراجعة legacy financial wording.
* مراجعة exception visibility بدل domain ownership.

### Legacy Direct Routes

* التأكد أن routes القديمة لا تنكسر أثناء containment.
* توثيق أي route router-only.

### Review Flow

* فهم review creation lifecycle.
* التأكد قبل أي فصل أن write path موثق بالكامل.

### Support Flow

* التأكد أن support labels لا تجعل booking/payment Core.
* الحفاظ على reference links فقط عند الحاجة.

### Archive Flow

* مراجعة archive visibility.
* التأكد أن archive لا يصبح Domain owner.

---

## 16. Commit Strategy

ترتيب commits المستقبلي المقترح:

* docs roadmap commit.
* visibility containment commit.
* trust blueprint commit.
* provider contact blueprint commit.
* rules design commit.
* extraction package commits.
* archive strategy commit.
* burial package commits بعد approval/tests.

كل commit يجب أن يكون صغير وواضح، ويفصل بين docs وruntime وrules.

---

## 17. What Must Not Be Done

ممنوع الآن:

* حذف `booking_requests`.
* تعديل rules.
* تغيير routes.
* migration.
* إنشاء collections جديدة.
* refactor واسع.
* تغيير status values.
* تغيير `requestId`.
* نقل `sessionRatings`.
* دفن payment proof قبل archive.
* تغيير `SessionReviewPage`.
* تغيير query shapes.
* كسر deep links.
* تنفيذ أي Extraction.

---

## 18. Final Verdict

نعم، Mental Smile جاهزة للانتقال إلى phased extraction planning.

لكنها ليست جاهزة لتنفيذ Extraction مباشر قبل اكتمال:

* read model design.
* rules design.
* compatibility plan.
* archive safety.
* Owner approval.

أول مسار تنفيذي آمن بعد اعتماد هذه الوثيقة هو:

```text
Trust read model design
↓
SessionReview write verification
↓
Provider Contact / Service Coordination design
↓
Compatibility layer design
```

وليس migration أو rules rewrite.

هذا Roadmap لا يغير Runtime.

هذا Roadmap لا يغير Rules.

هذا Roadmap لا ينفذ Extraction.

هو فقط يحدد ترتيب التنفيذ الآمن.
