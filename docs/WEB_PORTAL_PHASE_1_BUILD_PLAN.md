# WEB_PORTAL_PHASE_1_BUILD_PLAN

## 1. Executive Summary

Phase 1 Web Portal هو أول بناء عملي للـ Sovereign Web Intake في Mental Smile.

الهدف ليس بناء نظام إداري كامل، ولا ربطه بالتطبيق، ولا إنشاء workflow engine.

الهدف:

```text
Email-driven Web Portal
+
Optional lightweight record later
```

الـ Portal في Phase 1 يفصل التسجيلات والطلبات الإدارية عن App Runtime، ويبدأ بأبسط نسخة قابلة للنشر.

---

## 2. Phase 1 Scope

Phase 1 يحتوي فقط على:

* Home.
* About.
* Library Landing.
* Provider Registration Form.
* Center Registration Form.
* Service Request Form.
* Package Request Form.
* Contact Form.

كل شيء في هذه المرحلة:

* Public-first.
* Email-driven.
* Manual review.
* No heavy permissions.
* No workflow engine.
* No app runtime integration.

---

## 3. Pages List

| Page | Purpose | Owner | Mode |
| --- | --- | --- | --- |
| Home | تعريف Mental Smile وتوجيه الزائر | Marketing / Owner | Static public |
| About | شرح الهوية والفرق بين Marketplace وBooking/Treatment Platform | Owner / Content | Static public |
| Library Landing | مدخل المحتوى التثقيفي | Library / Content | Static public |
| Provider Registration | تسجيل الأخصائيين | Provider Intake | Form |
| Center Registration | تسجيل المراكز | Center Intake | Form |
| Service Request | طلب خدمات تسويق/محتوى/تقنية/AI/شراكات | Commerce / Departments | Form |
| Package Request | طلب باقات أو اشتراكات أو تحقق أو ظهور | Commerce / Finance | Form |
| Contact | تواصل عام وتوجيه يدوي | Support / Owner | Form |

---

## 4. Forms List

Phase 1 forms:

* Provider Registration Form.
* Center Registration Form.
* Service Request Form.
* Package Request Form.
* Contact Form.

كل form يرسل إلى email routing محدد. يمكن لاحقًا إضافة lightweight records بعد اعتماد setup.

---

## 5. Fields لكل Form

### Provider Registration Form

Fields:

* full name.
* email.
* phone.
* specialty.
* license / certificate reference.
* city.
* service categories.
* profile links.
* document upload references.
* notes.

### Center Registration Form

Fields:

* center name.
* owner/manager name.
* email.
* phone.
* address.
* city.
* license reference.
* service categories.
* social links.
* document upload references.
* notes.

### Service Request Form

Fields:

* requester name.
* email.
* phone.
* organization name.
* service type.
* request summary.
* budget range.
* timeline.
* needs discovery call.
* notes.

Service types:

* Marketing Campaign.
* Content Creation.
* Technical Service.
* AI Service.
* White Label / Tenant.
* Partnership.

### Package Request Form

Fields:

* requester name.
* email.
* phone.
* provider/center name.
* package type.
* billing preference.
* needs quote.
* notes.

Package types:

* Subscription.
* Verification.
* Visibility Package.
* Tool / AI Package.
* Optional Module Rental.

### Contact Form

Fields:

* name.
* email.
* phone.
* topic.
* message.
* preferred contact method.

Topics:

* General inquiry.
* Provider question.
* Center question.
* Business request.
* Support program.
* Other.

---

## 6. Email Routing لكل Form

| Form | Initial Routing | CC / Escalation | Year-One Owner |
| --- | --- | --- | --- |
| Provider Registration | provider-intake email | Owner if sensitive | Founder / Provider Intake |
| Center Registration | center-intake email | Owner if sensitive | Founder / Center Intake |
| Service Request | commerce/service email | Relevant department | Founder / Commerce |
| Package Request | commerce/packages email | Finance if payment-ready | Founder / Commerce + Finance |
| Contact | general contact email | Support or Owner | Founder / Support |

ملاحظة:

الأسماء النهائية للبريد يمكن تحديدها وقت setup. هذه الوثيقة تحدد routing logic فقط.

---

## 7. What Stays Manual In Year One

يبقى يدويًا في السنة الأولى:

* provider approval.
* center approval.
* document review.
* verification decision.
* quote preparation.
* payment instruction.
* package activation signal.
* legal review.
* partnership review.
* white label review.
* special cases escalation.

القانون:

```text
Founder Operated
Email Driven
Manual Review
No Heavy Workflow Engine
```

---

## 8. What Must Not Be Built Now

ممنوع الآن:

* complex staff permissions.
* workflow engine.
* full accounting system.
* full legal management system.
* automated quote engine.
* app runtime integration.
* deep Firestore rules.
* replacing current app routes.
* moving operational support prematurely.
* provider/center approval automation.
* payment processing inside portal.
* booking or service coordination runtime.
* AI automation for final decisions.

---

## 9. Suggested Folder Structure

اقتراح فقط، بدون تنفيذ:

```text
web_portal/
  pages/
    home/
    about/
    library/
    provider_registration/
    center_registration/
    service_request/
    package_request/
    contact/
  forms/
    provider_registration_form/
    center_registration_form/
    service_request_form/
    package_request_form/
    contact_form/
  content/
  routing/
  email_templates/
  shared/
```

بديل لو داخل نفس repo لاحقًا:

```text
lib/features/web_portal/
  presentation/
  domain/
  application/
```

لكن Phase 1 لا تنفذ أي structure الآن.

---

## 10. Suggested Route Names

اقتراح route names مستقبلية فقط:

```text
/
/about
/library
/register/provider
/register/center
/request/service
/request/package
/contact
```

ملاحظات:

* لا يتم تعديل routes الحالية.
* لا يتم استبدال app routes.
* web routes يجب أن تكون مستقلة عن App Runtime.

---

## 11. Firebase/Hosting Notes بدون تنفيذ

ملاحظات مستقبلية فقط:

* يمكن استضافة Phase 1 كـ static web أو Flutter Web أو framework منفصل.
* يمكن استخدام email service أو form backend بسيط.
* lightweight records اختيارية لاحقًا بعد اعتماد privacy/rules.
* لا يتم إنشاء Firestore collections الآن.
* لا يتم تعديل `firestore.rules` الآن.
* لا يتم إعداد Firebase Hosting الآن.
* لا يتم ربط portal بالتطبيق الآن.

القاعدة:

```text
Email first.
Records later if needed.
```

---

## 12. QA Checklist

عند التنفيذ المستقبلي، يجب مراجعة:

* Home تعرض الهوية الصحيحة: Marketplace وليس Booking/Treatment Platform.
* About يشرح Web/App separation بوضوح.
* Library Landing لا تقدم تشخيص أو علاج.
* Provider Registration form يحتوي الحقول المطلوبة.
* Center Registration form يحتوي الحقول المطلوبة.
* Service Request form يوجه الطلب للقسم الصحيح.
* Package Request form لا ينفذ payment مباشرة.
* Contact form يعمل كintake عام.
* كل forms ترسل email للوجهة الصحيحة.
* لا يوجد app runtime dependency.
* لا يوجد route replacement للتطبيق.
* لا يوجد Firestore write بدون approval.
* لا توجد مفاهيم booking/payment داخل Phase 1 portal بطريقة تشغيلية.

---

## 13. Final Verdict

Phase 1 Web Portal يجب أن يبدأ كـ:

```text
Minimal Sovereign Intake Portal
```

وليس:

```text
Full Admin Platform
```

أول بناء آمن هو pages عامة + forms ترسل email + manual review.

هذا يحقق الفصل بين Web Intake وApp Runtime بدون تعقيد مبكر.

هذا Plan لا يغير Runtime.

هذا Plan لا يغير Rules.

هذا Plan لا ينفذ Web setup.

هذا Plan يحدد فقط أول بناء للـ Web Portal.
