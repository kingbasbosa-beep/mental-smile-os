# COMPATIBILITY_LAYER_PACKAGE

## 1. Executive Summary

Compatibility Layer ضرورية لأن Mental Smile عندها عالم قديم لا يمكن قطعه فجأة:

* `booking_requests`
* `sessionRatings`
* legacy routes
* legacy inboxes
* legacy archives

وفي نفس الوقت عندها عالم جديد مطلوب تصميمه:

* Provider Contact
* Service Coordination
* Trust Domain
* Trust Read Models

أي Extraction قبل Compatibility يعتبر خطر إنتاجي:

```text
Extraction Before Compatibility
=
Production Risk
```

السبب أن routes قديمة، deep links، dashboards، archives، وreports ممكن تكون لسه تعتمد على legacy surfaces. لذلك لازم legacy يفضل readable وآمن، بينما يتم إدخال read models/capabilities الجديدة تدريجيًا بدون Big Bang Migration.

---

## 2. Current Legacy Surface Inventory

| Legacy Surface | Classification | Reason |
| --- | --- | --- |
| `booking_requests` | Must Stay | مصدر legacy أساسي ويحتاج compatibility/readability |
| `bookingRequests` | Transitional / Burial Candidate | محتمل duplicate أو mirror legacy ويحتاج inventory قبل burial |
| `sessionRatings` | Must Stay | مصدر legacy للـ reviews/ratings حتى تصميم Trust Read Models |
| legacy inboxes | Transitional | تخدم provider/center workflows حاليًا |
| legacy routes | Must Stay | ضرورية للتوافق وdeep links |
| legacy archives | Must Stay | مطلوبة للقراءة، audit، والرجوع التاريخي |

### Must Stay

يبقى قابل للقراءة مؤقتًا:

* `booking_requests`
* `sessionRatings`
* direct legacy routes
* archives

### Transitional

يبقى أثناء التحول ثم يعاد تصنيفه:

* provider/clinician inboxes القديمة.
* center inboxes القديمة.
* admin booking/session visibility.

### Burial Candidate

يدفن لاحقًا فقط بعد archive safety وOwner approval:

* `bookingRequests` لو ثبت أنه duplicate/dead.
* mirror writes القديمة.
* financial/payment lifecycle داخل booking.
* payout/commission semantics.

---

## 3. Compatibility Principles

مبادئ Compatibility:

* Legacy First Readability.
* No Breaking Routes.
* No Data Loss.
* No Big Bang Migration.
* No Forced Consumer Switch.
* No Rules Rewrite First.
* No Collection Rename First.
* No Runtime Rewrite First.
* Archive Before Burial.
* Owner Approval Before Extraction.

المعنى:

```text
New architecture can be designed.
Old runtime must remain stable until safe switch gates are met.
```

---

## 4. Route Compatibility Design

المسارات القديمة:

```text
/booking/*
```

يمكن أن تعيش مستقبلًا بجانب:

```text
/provider-contact/*
/coordination/*
```

بدون كسر deep links عبر الاتجاه التالي:

```text
Legacy route stays
↓
Copy/language containment
↓
Optional bridge view
↓
New capability route introduced later
↓
Legacy route redirects or reads archive later
↓
Burial only after approval
```

قواعد route compatibility:

* لا حذف route قديم قبل inventory كامل.
* لا redirect قبل اختبار deep links.
* لا تغيير route ownership بدون classification.
* routes القديمة قد تصبح compatibility shells مستقبلًا.

---

## 5. Consumer Compatibility Design

### Client Dashboards

تظل تقرأ legacy request history مؤقتًا، لكن language تتحول إلى service/contact wording. لا يتم إجبارها على Trust/Provider Contact models قبل readiness.

### Provider Dashboards

inboxes القديمة تظل Transitional. مستقبلًا يمكن ربطها بـ Provider Contact/Coordination read models، لكن بدون كسر `booking_requests` reads الآن.

### Center Dashboards

center request/activity views تظل متوافقة مع legacy، مع تقليل booking/session language.

### Admin Visibility

admin pages تظل تملك visibility على legacy queues والأرشيف، لكن بصياغة Legacy/Optional وليس Core.

### Archive Pages

archive pages تظل readable/searchable/auditable. لا تصبح Domain owner، لكنها تحفظ التاريخ.

---

## 6. Trust Compatibility Design

`sessionRatings` يمكن أن تظل source مؤقتة.

لكن Trust Read Models تصبح surfaces جديدة لاحقًا:

```text
sessionRatings
↓
projection candidate
↓
Trust Read Models
↓
profiles / reports / admin visibility
```

القواعد:

* `sessionRatings` لا يتم نقلها الآن.
* لا تغيير `SessionReviewPage` الآن.
* لا تغيير write path الآن.
* Trust Read Models لا تعني migration فورية.
* legacy references يمكن حفظها للتوافق.

الهدف النهائي:

```text
Trust-owned read surfaces
not
Booking-owned review reads
```

---

## 7. Provider Contact Compatibility Design

`booking_requests` تتعايش مع `Provider Contact Request` عبر mapping مفاهيمي قبل التنفيذ.

Legacy:

```text
booking_requests
```

Future capability:

```text
Provider Contact Request
```

Mapping محتمل:

| Legacy Meaning | Future Meaning |
| --- | --- |
| request created | contact request submitted |
| provider/clinician target | providerId/providerType |
| service details | service interest |
| request notes | request message |
| basic state | contact request status |

ما لا ينتقل:

* payment proof.
* payout.
* accounting.
* reviews.
* support ownership.
* session/treatment lifecycle.

---

## 8. Service Coordination Compatibility Design

legacy request states يمكن أن تتعايش مع Service Coordination states بدون تعديل Runtime عبر mapping تصميمي فقط.

Legacy states قد تعبر عن booking/session history.

Future states يجب أن تعبر عن coordination فقط:

| Legacy Concept | Future Coordination Meaning |
| --- | --- |
| pending/new request | initiated |
| provider seen/responded | active |
| waiting on party | awaiting_response |
| needs follow up | follow_up_needed |
| closed/done | completed |
| cancelled/rejected | cancelled |

ما يجب تجنبه:

* `booked`
* `paid`
* `session_completed`
* `treatment_completed`
* `accounting_review`

لا يتم تغيير status values الحالية الآن. هذا mapping للتصميم فقط.

---

## 9. Legacy Archive Strategy

حتى بعد الفصل، بعض البيانات يجب أن تبقى:

### Readable

* old booking request history.
* old payment proof references.
* old session/coordination states.
* old review source references.

### Searchable

* requestId.
* clientId.
* providerId.
* createdAt.
* status.
* archive category.

### Auditable

* historical status changes.
* financial legacy visibility.
* review source references.
* admin actions.
* compatibility events.

Archive لا يملك Domain. هو فقط يحفظ السجل بعد تحديد المالك الحقيقي لكل جزء.

---

## 10. Dependency Preservation Matrix

| Dependency | Preserve | Replace Later | Burial |
| --- | --- | --- | --- |
| `booking_requests` reads | Yes | Provider Contact / Coordination read models | After archive safety |
| `bookingRequests` | Temporary if used | None or compatibility alias | If duplicate/dead |
| `sessionRatings` writes | Yes for now | Trust-owned write/read model later | Only after extraction |
| `/booking/*` routes | Yes | `/provider-contact/*`, `/coordination/*` | Only after deep link safety |
| clinician/center inboxes | Yes | Provider Contact/Coordination inbox | After consumer switch |
| payment proof flow | Compatibility only | Archive-only | After financial archive |
| accounting views | Compatibility/Optional | Optional Accounting Module | If no operational value |
| archive pages | Yes | Domain-aware archive surfaces | Not before audit safety |
| report reads | Yes | Trust/Contact/Coordination summaries | After read model validation |

---

## 11. Future Switch Strategy

### Phase A - Legacy Source + Legacy UI

الوضع الحالي. legacy data وlegacy UI موجودين، مع language containment.

### Phase B - Legacy Source + New Read Models

تظهر Trust/Contact/Coordination read models كـ projection candidates، بينما المصدر القديم ما زال موجود.

### Phase C - Legacy Source + New Capability UI

واجهات جديدة تقرأ من read models/capability surfaces، لكن legacy source ما زال للتوافق.

### Phase D - Archive

legacy workflows تتحول إلى archive/read-only surfaces بعد tests وapproval.

### Phase E - Burial

دفن العناصر التي ثبت أنها dead أو duplicate أو financial/booking legacy غير ضروري.

---

## 12. Compatibility Risks

### Route Drift

routes قديمة وجديدة قد تعطي معاني مختلفة لنفس العملية.

### Data Drift

legacy data وread models الجديدة قد يختلفوا لو projection غير واضح.

### Archive Drift

الأرشيف قد يحفظ نسخة لا تطابق المالك الجديد للبيانات.

### Reporting Drift

reports قد تستمر في حساب trust/financial metrics من legacy booking data.

### Orphan References

documents قد تحتوي على `requestId` بدون document صالح أو provider/client واضح.

### requestId Dependencies

فصل Trust أو Coordination قبل فهم `requestId` dependencies قد يكسر review/session/report flows.

---

## 13. Extraction Readiness Gates

قبل أول Extraction فعلي يجب اكتمال:

* legacy consumers inventory.
* deep links inventory.
* Trust Read Models design approval.
* Provider Contact design approval.
* Service Coordination design approval.
* compatibility route plan.
* archive behavior design.
* rules design.
* emulator/manual test scenarios.
* rollback plan.
* Owner approval.

بدون هذه الشروط، أي extraction يعتبر high-risk.

---

## 14. What Must Not Be Done

ممنوع الآن:

* حذف collections.
* تغيير routes.
* migration.
* extraction.
* rules changes.
* data movement.
* rename collections.
* تغيير `requestId`.
* نقل `sessionRatings`.
* تعديل `booking_requests`.
* حذف inboxes أو archive pages.
* إجبار consumers على switch.

---

## 15. Final Verdict

نعم، Compatibility Layer هي آخر طبقة تصميم مطلوبة قبل أول Extraction Package فعلي.

السبب:

* عندنا legacy surfaces حقيقية لا يمكن قطعها مرة واحدة.
* Trust وProvider Contact وService Coordination محتاجين يعيشوا جنب legacy قبل ما يستبدلوه.
* أي extraction بدون compatibility يهدد routes وdashboards وarchives وreports.
* Compatibility Layer يحمي runtime ويعطي مساحة لفصل تدريجي.

الحكم النهائي:

```text
Compatibility must come before extraction.

Legacy remains readable while new domain surfaces are introduced gradually.
```

هذا Package لا يغير Runtime.

هذا Package لا يغير Rules.

هذا Package لا ينفذ Extraction.

هذا Package يصمم فقط Compatibility Layer المستقبلية.
