# BOOKING_LEGACY_OWNER_DECISIONS

هذه الوثيقة هي وثيقة قرارات رسمية.

تصنيفها:

```text
Owner Ratified Decisions
```

وتعتبر أعلى من أي افتراضات مستقبلية في تقارير booking legacy أو extraction أو containment.

هذه الوثيقة لا تعدل Runtime code.
هذه الوثيقة لا تعدل Firestore rules.
هذه الوثيقة لا تعدل routes.
هذه الوثيقة لا تحذف ملفات.
هذه الوثيقة لا تنفذ migration.
هذه الوثيقة لا تنفذ refactor.

المرجعيات الحاكمة:

* `docs/MENTAL_SMILE_DOMAIN_OWNERSHIP_CONSTITUTION.md`
* `docs/MENTAL_SMILE_FREEZE_AND_CLASSIFICATION_MAP.md`
* `docs/NAVIGATION_VISIBILITY_AUDIT.md`
* `docs/SAFE_VISIBILITY_CONTAINMENT_PLAN.md`
* `docs/BOOKING_LEGACY_INVENTORY.md`
* `docs/BOOKING_LEGACY_EXTRACTION_DECISION_PLAN.md`

---

# 1. Purpose

هذه الوثيقة تثبت قرارات الـ Owner النهائية المتعلقة بمصير:

* `booking_requests`
* booking lifecycle
* payment proof
* accounting
* sessions terminology
* reviews ownership
* support ownership

الغرض منها منع فتح نفس النقاش مرة أخرى في التقارير المستقبلية.

أي تقرير لاحق يجب أن يتعامل مع هذه القرارات كقرارات نهائية، وليس كاقتراحات أو احتمالات.

---

# 2. Official Platform Identity

القرار النهائي:

```text
Mental Smile
=
Mental Health Services Marketplace
```

Mental Smile ليست:

* Booking Platform
* Payment Platform
* Therapy Provider
* Accounting Platform
* Commission Platform

المنصة تملك الوصول، الشفافية، الدعم، التعليم، والتمكين المهني.

المنصة لا تملك علاقة العلاج، ولا الدفع، ولا التحصيل، ولا العمولة، ولا الجلسة نفسها.

---

# 3. Booking Module Decision

القرار النهائي:

```text
No Core Booking System
```

لن يتم بناء Core Platform حول الحجز.

المطلوب مستقبلًا:

```text
Provider Contact Request
+
Service Coordination
```

وليس:

```text
Full Booking Lifecycle
```

النتيجة:

أي Booking Module مستقبلي يعتبر:

```text
Optional Capability Module
```

وليس:

```text
Core Dependency
```

أي قدرة حجز مستقبلية يجب أن تكون قابلة للتفعيل أو الفصل أو التأجير بدون تعطيل Core Mental Smile.

---

# 4. Future Route Direction

القرار النهائي:

المسارات الحالية ذات أسماء booking يمكن أن تبقى مؤقتًا للتوافق.

لكن الاتجاه المستقبلي:

```text
Booking
↓
Provider Contact
```

أمثلة:

```text
/booking/request
↓
Provider Contact Request
```

```text
/booking/my
↓
My Service Requests
```

```text
/clinician/inbox
↓
Provider Request Inbox
```

هذا لا يعني تغيير routes الآن.

المقصود أن اللغة والملكية المستقبلية لا يجب أن تقدم booking كقلب المنصة.

---

# 5. Payment Proof Decision

القرار النهائي:

```text
Payment Proof
=
Legacy Compatibility Only
```

لا يتم تطويره.

لا يتم توسيعه.

لا يتم بناء Features جديدة عليه.

الاتجاه المستقبلي:

```text
Archive Only
```

بعد اكتمال مراحل الفصل.

أي ظهور حالي لـ payment proof يجب أن يعامل كـ legacy visibility وليس كقدرة مالية مملوكة للمنصة.

---

# 6. Accounting Decision

القرار النهائي:

```text
Accounting
≠ Core Mental Smile
```

إذا تم الاحتفاظ به، يكون:

```text
Optional Accounting Module
```

خصائصه:

* قابل للتأجير أو الاستضافة
* Tenant Scoped
* غير مرتبط بـ Marketplace Core
* غير مبني على عمولة جلسة
* غير مالك لدفع العميل لمقدم الخدمة

إذا لم تظهر له قيمة تشغيلية واضحة:

```text
Burial Candidate
```

ويمكن دفنه لاحقًا بعد archive وcompatibility safety.

---

# 7. Session Terminology Decision

القرار النهائي:

لغة:

```text
Session Ownership
```

تتحول تدريجيًا إلى:

```text
Service Coordination
```

أو:

```text
Provider Coordination
```

السبب:

Mental Smile لا تملك أو تدير العلاج نفسه.

أي ذكر للجلسات يجب أن يكون في سياق coordination أو legacy visibility، وليس في سياق platform-owned care relationship.

---

# 8. Reviews & Ratings Decision

القرار النهائي:

التقييمات والمراجعات ملك:

```text
Trust & Transparency Domain
```

وليست:

```text
Booking Lifecycle
```

الاتجاه المستقبلي:

* ratings
* reviews
* comments
* transparency history

تنتقل إلى Trust Domain.

يسمح بوجود legacy request reference أثناء الانتقال، لكن لا يجب أن تكون التقييمات مملوكة لـ booking flow.

---

# 9. Support Ownership Decision

القرار النهائي:

الشكاوى والدعم والتصعيد ملك:

```text
Client Support Domain
```

وليست:

```text
Booking Domain
```

يسمح فقط بوجود:

```text
Reference Link
```

إلى request قديم إذا احتاج الدعم لذلك.

الدعم لا يصبح امتدادًا للحجز، والحجز لا يملك الشكاوى أو التصعيد.

---

# 10. Financial Ownership Decision

القرار النهائي:

Mental Smile لا تملك:

* payment flow
* payout flow
* commission flow
* settlement flow

بين العميل ومقدم الخدمة.

دور المنصة:

* transparency
* discovery
* support
* trust
* education
* marketing enablement

فقط.

أي payment أو payout أو commission يظهر في legacy يجب أن يعامل كمنطقة مجمدة ومؤرشفة لاحقًا، وليس كمنطق platform core.

---

# 11. Legacy Strategy Decision

القرار النهائي:

```text
Freeze
↓
Quarantine
↓
Read Only
↓
Archive
↓
Burial
```

وليس:

```text
Rewrite
```

أو:

```text
Big Bang Migration
```

الاستراتيجية المعتمدة هي تفكيك تدريجي آمن، يبدأ بتقليل الظهور واللغة، ثم ownership، ثم dependency extraction، ثم archive، ثم burial.

---

# 12. Future Extraction Authority

القرار النهائي:

أي Extraction مستقبلي يجب أن يلتزم:

* No Rules Rewrite First
* No Runtime Rewrite First
* No Collection Rename First
* No Data Migration First

الأولوية دائمًا:

1. Visibility
2. Language
3. Ownership
4. Dependencies
5. Extraction
6. Archive
7. Burial

أي خطة تبدأ بـ rules rewrite أو migration أو rename قبل تقليل الظهور وفهم الملكية تعتبر مخالفة لهذه الوثيقة.

---

# 13. Final Owner Verdict

القرار النهائي الرسمي:

```text
booking_requests
must not survive as Core.

A lightweight Provider Contact / Service Coordination capability may survive.

Trust owns trust.

Support owns support.

Accounting is optional.

Financial ownership is outside Mental Smile.

Legacy stays only until compatibility and archive safety are achieved.
```

الحكم النهائي:

`booking_requests` تبقى فقط كـ legacy compatibility إلى أن يصبح archive والدفن آمنين.

أي capability مستقبلية يجب أن تبدأ من ownership واضح، وليس من إعادة استخدام container قديم يحمل أكثر من دومين.
