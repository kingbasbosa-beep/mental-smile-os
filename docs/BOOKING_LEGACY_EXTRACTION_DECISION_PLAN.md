# BOOKING_LEGACY_EXTRACTION_DECISION_PLAN

هذا التقرير لا ينفذ أي تعديل.
هذا التقرير لا يغير Runtime.
هذا التقرير لا يغير Rules.
هذا التقرير فقط يحول inventory إلى قرار extraction تدريجي.

المرجعيات الحاكمة:

* `docs/MENTAL_SMILE_DOMAIN_OWNERSHIP_CONSTITUTION.md`
* `docs/MENTAL_SMILE_FREEZE_AND_CLASSIFICATION_MAP.md`
* `docs/NAVIGATION_VISIBILITY_AUDIT.md`
* `docs/SAFE_VISIBILITY_CONTAINMENT_PLAN.md`
* `docs/BOOKING_LEGACY_INVENTORY.md`

---

# 1. Executive Decision Summary

`booking_requests` الحالية ليست Domain صالح، وليست Module صالح.

التصنيف الرسمي:

```text
Legacy Container
+ Frozen Runtime Dependency
+ Quarantined Cross-Domain Store
+ Optional Booking Module Source Inventory
+ Burial Candidate for financial/session overreach
```

المعنى العملي:

* لا يتم البناء عليها كـ Core Platform.
* لا يتم توسيعها.
* لا يتم إدخال payment/accounting/payout/commission جديد داخلها.
* لا يتم حذفها الآن لأنها ما زالت Runtime Dependency.
* يتم استخدامها كـ inventory لفهم ما يجب استخراجه لاحقًا.

الحكم التنفيذي:

```text
Contain first.
Extract later.
Bury only after compatibility and archive safety.
```

---

# 2. Split Map

## Optional Booking Module

ما يمكن أن يعيش مستقبلًا كـ Optional Booking Module:

* request intake
* provider contact request
* center contact request
* scheduling/coordination metadata
* provider inbox
* client legacy request viewer
* admin module exception board

ما لا يدخل في Optional Booking Module:

* payment
* payout
* accounting
* commission
* trust ratings as lifecycle gate
* support complaints as owned fields

القرار:

Optional Booking Module يجب أن يكون module مستقل، tenant/provider scoped، وغير مطلوب لتشغيل Core Mental Smile.

## Trust & Transparency Domain

ينتقل إليه مستقبلًا:

* ratings
* comments
* transparency history
* provider review signals
* complaint visibility summary

القرار:

التقييمات والتعليقات لا يجب أن تظل مملوكة لـ booking lifecycle. هي جزء من الثقة والشفافية، وليست proof أن المنصة تملك الجلسة أو النتيجة.

## Client Support Domain

ينتقل إليه مستقبلًا:

* support requests
* complaint routing
* chat/escalation linkages
* hotlines / issue routing

القرار:

الدعم والشكاوى والتصعيد يجب أن تكون support-owned. ممكن تحتفظ بروابط إلى legacy request IDs للمرجعية، لكن لا تكون owned fields داخل booking container.

## Optional Accounting Module

ينتقل إليه فقط لو Owner قرر تأجير أو تفعيل محاسبة:

* invoices
* provider internal payments
* center accounting
* financial reports
* ledgers

لكن لا يعود إلى Core Mental Smile.

القرار:

Accounting Module اختياري، tenant-scoped، وليس مصدر دخل core مبني على عمولة جلسة. لا يجوز أن يعيد financial ownership إلى marketplace.

## Legacy Compatibility

يبقى مؤقتًا:

* old request history
* old session fields
* old payment fields read-only later
* archive bridge
* deep link bridge

القرار:

Legacy Compatibility يبقى فقط لحماية المستخدمين والبيانات القديمة والروابط القديمة. لا يتحول إلى feature development path.

## Burial Candidate

مرشح للدفن لاحقًا:

* `bookingRequests`
* disabled mirror writes
* disabled clinician uid legacy fallback
* direct commission/payout semantics
* obsolete payment proof flow after visibility containment
* dead center CTA blocks

القرار:

لا يتم دفن أي عنصر قبل audit وtests وOwner Decision، لكن يتم منع توسيعه من الآن.

---

# 3. Future Optional Booking Module Shape

هذا تصميم مقترح فقط، بدون تنفيذ.

## Collection candidates

* `module_booking_requests`
* `module_booking_slots`
* `module_booking_provider_inbox`
* `module_booking_settings`
* `module_booking_audit_logs`

## Route candidates

* `/modules/booking/request`
* `/modules/booking/my`
* `/modules/booking/provider-inbox`
* `/modules/booking/admin`
* `/modules/booking/settings`

## Rule direction

* tenant-scoped
* provider-scoped
* no financial fields
* no accounting fields
* no payout fields
* no commission fields

## Status model

Statuses نظيفة مقترحة:

* `submitted`
* `provider_review`
* `provider_accepted`
* `coordination_pending`
* `scheduled`
* `completed`
* `cancelled`
* `complaint_linked`

Statuses ممنوعة داخل module:

* `awaiting_payment`
* `payment_review`
* `payout_pending`
* `accounting_review`

## Module boundaries

الموديول يملك:

* طلب تواصل أو تنسيق خدمة.
* availability أو slots لو تم تفعيلها.
* inbox للمقدم داخل module.
* admin exception board للموديول فقط.
* audit logs خاصة بالموديول.

الموديول لا يملك:

* الدفع.
* التحصيل.
* payout.
* المحاسبة.
* تقييمات الثقة كجزء من lifecycle.
* الشكاوى كحقول داخل الطلب.

---

# 4. Legacy Read-Only Strategy

الاستراتيجية المستقبلية لـ `booking_requests`:

* readable للتوافق.
* no new financial writes.
* no new payment proof writes.
* no new payout/accounting writes.
* gradually hidden from navigation.
* available for archive/reporting only.

بدون تعديل rules الآن.

## Phased direction

### Phase 1: Visibility containment

تقليل ظهور booking/payment/accounting في UI، مع بقاء routes شغالة.

### Phase 2: Copy containment

تغيير اللغة من Booking/Payment/Sessions إلى:

* Service request
* Provider contact
* Service coordination
* Legacy financial visibility

### Phase 3: Read-only planning

تصميم قواعد مستقبلية تمنع writes الجديدة للحقول المالية، لكن فقط بعد tests.

### Phase 4: Archive-only mode

تحويل أجزاء من legacy إلى archive/reporting فقط.

### Phase 5: Burial

دفن العناصر التي ثبت أنها غير مستخدمة أو duplicated أو dead code.

---

# 5. Dependency Break Order

## 1. Visibility containment

الهدف:

تقليل ظهور financial/booking كـ Core في client/provider/admin navigation.

لا يلمس:

* routes
* rules
* services
* collections

الخطر:

Low إلى Medium حسب مكان الظهور.

tests المطلوبة لاحقًا:

* dashboard/manual navigation لكل role.
* direct deep links تظل تعمل.

## 2. Copy relabeling

الهدف:

تغيير اللغة من booking/payment/session ownership إلى service/contact/coordination.

لا يلمس:

* internal keys
* statuses
* write shape

الخطر:

Low.

tests المطلوبة لاحقًا:

* UI smoke test.
* localization review.

## 3. Report/archive quarantine

الهدف:

فصل archive/report language عن كونها core financial أو treatment ownership.

لا يلمس:

* archive data
* rules
* queries

الخطر:

Medium.

tests المطلوبة لاحقًا:

* admin archive opens.
* filters ما زالت تعمل.
* direct archive routes تعمل.

## 4. Support/chat link decoupling

الهدف:

تحويل chat/escalation linkage من booking-owned إلى support-owned reference.

لا يلمس الآن:

* chat rules
* support rules
* booking fields

الخطر:

High.

tests المطلوبة لاحقًا:

* chat owner access.
* clinician assigned access.
* admin escalation access.
* old booking-linked threads.

## 5. Reviews/rating decoupling

الهدف:

نقل ratings/reviews إلى Trust & Transparency Domain بدل booking lifecycle.

لا يلمس الآن:

* `sessionRatings`
* requestId bridge
* review status writes

الخطر:

High.

tests المطلوبة لاحقًا:

* client review flow.
* provider review flow.
* public rating display.
* admin report archive.

## 6. Provider inbox extraction

الهدف:

نقل clinician/center inbox إلى module-owned provider inbox.

لا يلمس الآن:

* `/clinician/inbox`
* `/center/inbox`
* existing queries

الخطر:

High.

tests المطلوبة لاحقًا:

* clinician assignment workflow.
* center request workflow.
* old request visibility.

## 7. Client request viewer extraction

الهدف:

استبدال `/booking/my` بviewer module/legacy واضح.

لا يلمس الآن:

* route
* client old history
* request copying

الخطر:

High.

tests المطلوبة لاحقًا:

* client old requests.
* action-needed states.
* completed/closed tabs.

## 8. Admin exception board extraction

الهدف:

تحويل `/admin/booking-queue` إلى module exception board أو legacy-only board.

لا يلمس الآن:

* admin queue commands
* adapters
* wrappers

الخطر:

Critical.

tests المطلوبة لاحقًا:

* admin assign/forward/reject flows.
* audit wrapper output.
* no accidental financial writes.

## 9. Financial write freeze

الهدف:

منع payment/payout/accounting writes الجديدة بعد تصميم بديل.

لا يلمس الآن:

* Firestore rules
* payment adapter
* admin payments

الخطر:

Critical.

tests المطلوبة لاحقًا:

* emulator rules tests.
* legacy read tests.
* blocked write tests.
* admin compatibility tests.

## 10. Legacy burial

الهدف:

دفن `bookingRequests` والعناصر الميتة والحقول غير المستخدمة.

لا يلمس الآن:

* any production data
* routes
* rules

الخطر:

Critical لو تم مبكرًا.

tests المطلوبة لاحقًا:

* data inventory.
* deep-link audit.
* rollback plan.
* owner approval.

---

# 6. What Must Not Be Done

ممنوع الآن:

* deleting `booking_requests`
* renaming collection
* changing rules
* removing routes
* migrating data
* replacing statuses
* moving reviews/support before tests
* creating `service_requests` as another cross-domain collection
* expanding booking fields
* adding payment/accounting/payout fields
* turning support complaints into booking-owned fields
* treating reviews as booking lifecycle gates
* making booking a hidden Core dependency

أي محاولة لإنشاء `service_requests` يجب أن تمنع نفس خطأ `booking_requests`: collection واحدة تحمل request + booking + payment + review + support + archive.

---

# 7. Owner Decisions Needed

قرارات مطلوبة قبل أي extraction:

1. هل Booking Module مطلوب فعلًا أم مجرد Contact Request؟

2. هل `/booking/request` يصبح Provider Contact لاحقًا؟

3. هل المركز يحتاج Center Contact Module منفصل؟

4. هل client legacy history يبقى كم سنة؟

5. هل payment proof القديم يبقى archive-only؟

6. هل accounting module سيتأجر أم يدفن؟

7. هل session terminology تتحول إلى coordination؟

8. هل reviews تنتقل إلى Trust Domain قبل أو بعد module extraction؟

9. هل support/chat linkage يحتفظ بـ requestId كمرجع فقط أم يتم عمل support-owned relation؟

10. هل admin exception board يبقى للأدمن فقط أم لكل tenant في module؟

11. هل يتم إنشاء route namespace جديد `/modules/booking/*` أم إبقاء القديم كalias؟

12. هل legacy financial fields تتحول read-only على rules level أم application level أولًا؟

---

# 8. First Safe Execution Packages

هذه packages مستقبلية صغيرة جدًا، بدون تنفيذ الآن.

## Package A: Archive/Report Copy Containment

الهدف:

تغيير لغة archive/report من financial/session ownership إلى legacy visibility.

نطاق آمن:

* copy only
* no route changes
* no rules changes

## Package B: Booking Status Label Containment

الهدف:

عرض status labels للمستخدم بلغة service coordination بدل payment/session lifecycle.

نطاق آمن:

* display labels فقط
* no status value changes
* no migration

## Package C: Support/Chat Decoupling Audit

الهدف:

جرد كل booking-linked chat/support fields قبل أي فصل.

نطاق آمن:

* docs only
* no code changes

## Package D: SessionRatings Decoupling Audit

الهدف:

جرد ارتباط `sessionRatings` بـ `requestId` وتحضير Trust Domain model.

نطاق آمن:

* docs only
* no rules changes

## Package E: Provider Inbox Module Blueprint

الهدف:

تصميم provider inbox داخل Optional Booking Module.

نطاق آمن:

* blueprint only
* no implementation

## Package F: Legacy Financial Write Freeze Plan

الهدف:

تصميم plan لمنع financial writes لاحقًا.

نطاق آمن:

* plan only
* no rules changes
* no service changes

---

# 9. Final Verdict

`booking_requests` اليوم ليست Domain ولا Module.

هي:

```text
Legacy Container
```

تعمل كـ runtime dependency تاريخي يحمل أكثر من دومين. لذلك القرار الصحيح ليس حذفها الآن، وليس توسيعها، وليس إعادة تسميتها.

القرار الصحيح:

1. Freeze.
2. Quarantine.
3. Reduce visibility.
4. Split responsibilities.
5. Extract clean optional module parts.
6. Move trust/support/accounting out.
7. Make legacy read-only later.
8. Bury dead compatibility only after evidence.

أي مستقبل نظيف يجب أن يمنع تكرار نموذج collection واحدة تحمل كل شيء.

النتيجة المعمارية النهائية:

```text
Optional Booking Module may survive.

booking_requests must not survive as Core.

Financial fields must leave or become archive-only.

Trust and Support must own their own data.

Legacy stays only as compatibility until burial is safe.
```

هذا التقرير لا ينفذ أي تعديل.
هذا التقرير لا يغير Runtime.
هذا التقرير لا يغير Rules.
هذا التقرير فقط يحول inventory إلى قرار extraction تدريجي.
