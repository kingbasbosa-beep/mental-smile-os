# APP_DEMO_PRODUCTIZATION_BLUEPRINT_V1

## 1. Executive Summary

Mental Smile يحتاج Demo/Productization Layer الآن لأن التطبيق بدأ يخرج من مرحلة “مجموعة features” إلى مرحلة منتج قابل للعرض والبيع والاشتراك. بعد فصل Booking Platform logic وPayment/Commission logic، وبعد انتقال Web Sovereign Intake وOwner Room وArchive وStrategic Intelligence إلى مسارات سيادية منفصلة، أصبح التطبيق نفسه يحتاج طبقة عرض منتجية نظيفة.

الهدف ليس بناء features جديدة الآن. الهدف هو تنظيم الموجود كمنتج مفهوم:

```text
Demo-ready
Subscription-ready
Sales-ready
No legacy confusion
```

الـ Demo Layer يجب أن يوضح للمشتري أو الشريك أو المركز أن Mental Smile هو Marketplace Runtime + Provider/Center Operating Surface، وليس نظام حجز أو دفع أو إدارة علاج.

## 2. Product Doctrine

العقيدة الرسمية:

```text
Mental Smile App
=
Marketplace Runtime + Provider/Center Operating Surface
```

وليس:

```text
Booking Platform
Payment Platform
Therapy Management System
```

التطبيق يعرض مقدمي الخدمة والمراكز والخدمات والثقة والشفافية والتواصل والتنسيق الخفيف. أما الدفع، العقود، الحسابات، التسجيلات، والسيادة الإدارية فتعيش في Web/Sovereign ecosystem أو وحدات اختيارية لاحقة.

## 3. What Must Be Removed / Hidden From Demo

بقايا legacy التي لا يجب أن تظهر في Demo:

* central booking language
* commission logic
* payout logic
* client-provider payment flow
* unclear payment tabs
* legacy booking request wording
* misleading appointment confirmation wording
* admin God-mode actions

الـ Demo يجب أن يستخدم لغة:

```text
Provider Contact
Service Coordination
Trust & Transparency
Disclosure
Professional Visibility
```

بدل لغة:

```text
Booking
Payment proof
Commission
Payout
Session ownership
```

## 4. Demo Tenant Types

## Demo Clinic / Clinician Account

يعرض:

* professional profile
* services
* contact request surface
* trust summary
* documents/disclosures
* basic visibility

الهدف: إظهار قيمة الاشتراك للأخصائي الفردي بدون ادعاء أن Mental Smile يدير العلاج أو الحجز أو الدفع.

## Demo Therapy Center Account

يعرض:

* center profile
* services
* specialists
* media
* pricing/disclosure copy
* contact request surface
* trust/disclosure section

الهدف: إظهار كيف يظهر المركز ككيان مهني داخل marketplace، مع شفافية في الخدمات والأسعار والوثائق بدون platform guarantee.

## Demo Education / Courses Center Account

يعرض:

* educational services
* courses/programs
* library-linked content
* inquiry/contact surface
* no therapy claim
* no booking/payment promise

الهدف: فتح مساحة مستقبلية للمراكز التعليمية والكورسات والدبلومات بدون خلطها مع العلاج أو الحجز أو الدفع.

## 5. Demo Data Strategy

اقتراح demo tenants:

* `demo_clinic_001`
* `demo_center_therapy_001`
* `demo_center_courses_001`

قواعد البيانات التجريبية:

* demo data isolated
* no real payment
* no real client data
* no real medical claims
* no production mixing

يجب أن تكون كل بيانات الـ Demo واضحة أنها للاختبار والعرض، ولا تستخدم أسماء عملاء حقيقيين أو ادعاءات علاجية أو وثائق حقيقية غير مصرح بها.

## 6. Subscription Product Surfaces

## Provider Subscription

يمكن بيعه كاشتراك يشمل:

* profile visibility
* contact request inbox
* trust display
* document/disclosure area

## Center Subscription

يمكن بيعه كاشتراك يشمل:

* center profile
* specialist listing
* services catalog
* media/disclosure area

## Education / Courses Subscription

يمكن بيعه كاشتراك يشمل:

* course/program listing
* education profile
* content links
* inquiry form

## Add-ons

إضافات قابلة للبيع لاحقًا:

* verification
* visibility package
* marketing package
* AI/tool package
* optional module rental

هذه add-ons لا تصبح core dependency، ولا يجب أن تعيد payment/booking/commission logic إلى قلب التطبيق.

## 7. App vs Web Product Boundary

الحد الفاصل:

```text
App
=
Product display + marketplace runtime
```

```text
Web
=
Sovereign intake + commerce + future administration
```

التطبيق يعرض المنتج ويشغل marketplace runtime:

* provider profiles
* center profiles
* services
* trust display
* provider contact
* service coordination
* support visibility

الويب يستقبل:

* registrations
* package requests
* service requests
* payment/commerce intake
* legal/finance/archive future

## 8. Control Room Monitoring Scope

Control Room يراقب لاحقًا:

* provider contact requests
* service coordination status
* trust signals
* support/escalation patterns
* stuck requests
* provider/center activity signals
* demo tenant health
* operational alerts

ولا يراقب أو يملك:

* finance execution
* legal execution
* owner decisions
* tool ownership
* strategic intelligence ownership

Control Room يظل Operational First، ولا يتحول إلى Owner Room أو Finance/Legal/Admin super system.

## 9. Demo QA Checklist

قائمة QA للـ Demo:

* demo clinic opens correctly
* demo center opens correctly
* demo education/courses center opens correctly
* no booking/payment promise
* contact request wording clean
* trust summary visible
* portal links work
* app/splash bridge works
* no real payment
* no real approval promise
* no commission/payout surfaces visible
* no misleading appointment confirmation copy

## 10. Technical Implementation Options

## Option A: Static Demo Fixtures

الأسرع والأكثر أمانًا.

المزايا:

* no Firestore writes
* no Auth dependency
* isolated from production
* easy to review
* low deployment risk

العيوب:

* أقل واقعية من المنتج الحقيقي.
* قد يحتاج duplicate UI wiring لاحقًا.
* لا يختبر runtime data flows.

## Option B: Firestore Seeded Demo Tenant

أقرب للمنتج الحقيقي.

المزايا:

* يعرض التطبيق كما سيعمل فعليًا.
* يمكن اختباره عبر نفس read paths.
* مناسب لعروض أقرب للواقع.

العيوب:

* يحتاج seed discipline.
* خطر production mixing إذا لم يتم عزله جيدًا.
* قد يتأثر بـ rules وpermissions.
* لا يجب أن يتضمن دفع أو بيانات حقيقية.

## Option C: Dedicated Demo Firebase Project

أنظف للعروض، لكنه أبطأ.

المزايا:

* عزل كامل عن production.
* مناسب للديموهات الرسمية.
* يسمح بتجربة أقرب للحقيقة بدون خطر بيانات production.

العيوب:

* إعداد أبطأ.
* تكلفة تشغيلية وتنظيمية أعلى.
* يحتاج project config وإدارة نشر منفصلة.

## 11. Recommended First Implementation

التوصية الأولى:

```text
Start with Static Demo Fixtures
```

ثم الانتقال لاحقًا إلى:

```text
Seeded Demo Tenant
```

عندما تكون boundaries مستقرة.

السبب:

* Static fixtures تقلل المخاطر.
* لا تدخل Firestore أو Auth أو rules في أول demo package.
* تسمح بتنظيف اللغة والسطح المنتج قبل إدخال data complexity.

الدفع الحقيقي لا يدخل Demo. لا يوجد real payment، ولا payment proof، ولا payout، ولا commission flow داخل demo.

## 12. Product Readiness Definition

نقول إن المنتج قابل للعرض عندما يتحقق الآتي:

* provider demo ready
* center demo ready
* education/courses demo ready
* portal intake ready
* no legacy booking/payment confusion
* control room monitoring scope defined
* no real payment
* no real approval promise
* trust/disclosure language clear
* subscription surfaces واضحة

## 13. Final Recommendation

نعم، يجب بناء Demo/Productization Layer قبل العودة إلى Control Room.

السبب:

* Control Room يراقب منتجًا، لذلك يجب أولًا تحديد المنتج المعروض.
* العودة إلى Control Room قبل productization قد تعيد legacy booking/payment/admin confusion.
* Demo Layer يساعد على البيع والاشتراك والشراكات.
* المنتج يحتاج surfaces واضحة قبل بناء monitoring أعمق.
* Demo tenants تكشف أين ما زالت اللغة أو الواجهات توحي بأن Mental Smile يملك الحجز أو الدفع أو العلاج.

التوصية:

ابدأ بـ Static Demo Fixtures + clean product language + three demo tenant profiles. بعد ذلك يمكن تقييم Seeded Demo Tenant أو Dedicated Demo Firebase Project حسب درجة نضج المنتج وحاجة العروض.

هذا Blueprint يوثق فقط.
هذا Blueprint لا ينشئ demo accounts.
هذا Blueprint لا يغير Firestore.
هذا Blueprint لا يغير Rules.
هذا Blueprint لا يغير Runtime.
