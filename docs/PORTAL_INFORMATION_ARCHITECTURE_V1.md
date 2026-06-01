# PORTAL_INFORMATION_ARCHITECTURE_V1

## 1. Executive Summary

Mental Smile Web Portal ليس مجرد موقع تسويقي.

هو:

```text
Sovereign Intake + Administrative Gateway
```

وظيفته الأساسية فصل التسجيلات، المستندات، الطلبات، المال، القانون، المكتبة، التسويق، والمحتوى عن App Runtime.

القاعدة الحاكمة:

```text
Web = Sovereign / Administrative / Intake Portal
App = Operational Marketplace Runtime
```

الـ Portal يستقبل ويفرز ويوجه. التطبيق يشغل Marketplace Runtime: provider contact، service coordination، trust visibility، operational support، monitoring.

---

## 2. Portal Top-Level Sections

| Section | Purpose | Owner | Public/Private | Year-One Mode | Future Mode |
| --- | --- | --- | --- | --- | --- |
| Home | تعريف سريع بالمنصة والاتجاهات الرئيسية | Marketing / Owner | Public | Static page | Dynamic public hub |
| About | شرح الهوية والدستور التشغيلي | Owner / Content | Public | Static page | Governance-aware page |
| Library | محتوى توعوي وتعليمي | Library / Content | Public | Landing + curated links | `library.mentalsmile.com` |
| Provider Registration | تسجيل الأخصائيين | Provider Intake | Public form | Email/manual review | Intake queue |
| Center Registration | تسجيل المراكز | Center Intake | Public form | Email/manual review | Intake queue |
| Services | شرح الخدمات المهنية والإدارية | Commerce / Marketing | Public | Static catalog | Quote-aware catalog |
| Packages | باقات الاشتراك والظهور والأدوات | Commerce / Finance | Public | Request form | Subscription portal |
| Commerce Intake | استقبال طلبات تجارية | Commerce | Public/Private | Email-driven | Commerce queue |
| Marketing & Content Requests | طلب حملات أو محتوى | Marketing / Content | Public/Private | Manual review | Department queue |
| Technical / AI Requests | طلبات تقنية أو ذكاء اصطناعي | Technical | Public/Private | Discovery review | Technical queue |
| Special Support Programs | مبادرات دعم خاصة | Support Programs | Public | Manual intake | Program portal |
| Finance & Legal | المال والقانون والتعاقدات | Finance / Legal | Private-first | Manual handling | Dedicated subdomains |
| Contact | تواصل عام | Support / Owner | Public | Email routing | Ticket/intake routing |
| Owner Room Future Area | قرارات وسيادة المشروع | Owner | Private | Not built first | `owner.mentalsmile.com` |

---

## 3. Public Website Pages

### Home

تعرض Mental Smile كسوق خدمات صحة نفسية، وتوجه المستخدم إلى التسجيل، المكتبة، الخدمات، والباقات.

### About Mental Smile

تشرح أن Mental Smile ليست منصة علاج أو دفع أو حجز مركزي، بل Marketplace قائم على الوصول، الشفافية، الدعم، التعليم، وتمكين مقدمي الخدمة.

### Marketplace Explanation

تشرح الفرق بين:

* discovery.
* provider contact.
* service coordination.
* trust transparency.

وتوضح أن الرعاية والدفع والتشخيص مسؤولية العميل ومقدم الخدمة.

### For Providers

صفحة للأخصائيين تعرض:

* الظهور.
* الملف المهني.
* أدوات مستقبلية.
* التسجيل.
* الباقات.

### For Centers

صفحة للمراكز تعرض:

* profile center.
* عرض الخدمات.
* disclosure.
* marketing opportunities.
* registration.

### Library Landing

مدخل للمكتبة: مقالات، فيديوهات، تمارين، أدلة، محتوى وقائي.

### Services Landing

مدخل للطلبات الإدارية والمهنية: marketing، content، technical، AI، white label.

### Packages Landing

عرض أولي للباقات والاشتراكات وطلبات quote.

### Contact

قنوات التواصل العامة وتوجيه الطلب إلى القسم المناسب.

---

## 4. Registration Forms

### Provider Registration Form

Fields مبدئية:

* full name.
* email.
* phone.
* specialty.
* license / certificate reference.
* city.
* service categories.
* profile links.
* document upload references.

Owning unit: Provider Intake.

Routing destination: Provider Registration inbox / email.

Year-one handling: manual review by founder/operator.

Future queue: Provider Intake Queue.

### Center Registration Form

Fields مبدئية:

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

Owning unit: Center Intake.

Routing destination: Center Registration inbox / email.

Year-one handling: manual review by founder/operator.

Future queue: Center Intake Queue.

---

## 5. Commerce / Package Request Forms

| Form | Price Known? | Needs Quote? | Direct To Finance? | Owner Review? | Department Review? |
| --- | --- | --- | --- | --- | --- |
| Subscription Request | Sometimes | Sometimes | Yes after approval | Sometimes | Commerce |
| Verification Request | Usually | Sometimes | Yes after review | Yes | Trust / Compliance |
| Visibility Package Request | Sometimes | Yes for custom | Yes after quote | Sometimes | Marketing |
| Tool / AI Package Request | Usually no | Yes | After quote | Yes | Technical / AI |
| Optional Module Rental Request | No | Yes | After contract | Yes | Technical + Legal |

Commerce يستقبل الطلب، لكن لا يملك التنفيذ كله.

القانون:

```text
Commerce ≠ Fulfillment
Departments own execution.
Finance owns payment.
```

---

## 6. Service Request Forms

| Form | Owning Department | Intake Fields | Needs Quote? | Discovery Call? | Becomes Commerce Order When | Execution Owner |
| --- | --- | --- | --- | --- | --- | --- |
| Marketing Campaign Request | Marketing | goal, audience, budget range, channels, timeline | Yes | Often | scope + quote approved | Marketing |
| Content Creation Request | Content | content type, language, topic, deadline, references | Sometimes | Sometimes | content scope approved | Content |
| Technical Service Request | Technical | problem, desired outcome, platform, urgency | Yes | Often | technical scope approved | Technical |
| AI Service Request | Technical / AI | use case, data type, output, risk level | Yes | Yes | AI scope approved | Technical / AI |
| White Label / Tenant Request | Owner / Commerce / Technical | brand, market, tenant needs, timeline | Yes | Yes | owner + legal approval | Owner + Technical |
| Partnership Request | Owner / Commerce | partner type, offer, region, contact person | Usually | Yes | owner approval | Owner / Commerce |

---

## 7. Finance & Legal Intake

### Finance Intake

Finance Intake يملك:

* billing profile.
* receipts.
* payment instructions.
* payment verification.
* package activation signal.

Finance لا يعيش داخل App Runtime. التطبيق لا يجب أن يصبح accounting أو payment platform.

### Legal Intake

Legal Intake يملك:

* contracts.
* licenses.
* compliance.
* legal archive.
* agreement review.

Legal لا يعيش داخل App Runtime لأن بياناته وصلاحياته وأرشيفه سيادي.

مستقبلًا يمكن فصلهم إلى:

```text
finance.mentalsmile.com
legal.mentalsmile.com
```

---

## 8. Library Information Architecture

Library كيان Web-first.

### Categories

* prevention.
* anxiety.
* depression.
* addiction education.
* family support.
* children support.
* special needs.
* disability support.
* provider education.

### Content Types

* articles.
* videos.
* exercises.
* guides.
* audio future.
* multilingual future.
* accessibility future.

التطبيق قد يستهلك المكتبة، لكنه لا يملكها.

القانون:

```text
Library is Web-owned.
App may consume Library.
```

---

## 9. Special Support Programs

Special Support Programs تعيش Web-first.

أمثلة:

* Deaf and Mute Support.
* Children of Cases Support.
* community initiatives.
* special outreach.

الفرق بينها وبين Operational Support:

* Special Programs: برامج سيادية، لها intake وسياسات ومبادرات.
* Operational Support: متابعة تشغيلية داخل التطبيق، استفسارات، تصعيدات، ومساعدة يومية.

---

## 10. Department Routing Matrix

| Form / Page | Owner | Initial Routing | Year-One Handling | Future Queue |
| --- | --- | --- | --- | --- |
| Provider Registration | Provider Intake | provider intake email | manual review | Provider Intake Queue |
| Center Registration | Center Intake | center intake email | manual review | Center Intake Queue |
| Subscription Request | Commerce / Finance | commerce email | manual quote/payment | Subscription Queue |
| Verification Request | Trust / Compliance | verification inbox | manual document review | Verification Queue |
| Visibility Package Request | Marketing / Commerce | marketing inbox | manual quote | Marketing Queue |
| Tool / AI Package Request | Technical / AI | technical inbox | discovery review | Technical Queue |
| Optional Module Rental Request | Owner / Technical / Legal | owner review | manual discovery | Module Rental Queue |
| Marketing Campaign Request | Marketing | marketing inbox | manual scope | Marketing Queue |
| Content Creation Request | Content | content inbox | manual scope | Content Queue |
| Technical Service Request | Technical | technical inbox | manual review | Technical Queue |
| AI Service Request | Technical / AI | AI intake inbox | discovery call | AI Queue |
| White Label / Tenant Request | Owner / Commerce | owner inbox | owner review | Tenant Queue |
| Partnership Request | Owner / Commerce | owner inbox | founder review | Partnership Queue |
| Finance Intake | Finance | finance inbox | manual handling | Finance Queue |
| Legal Intake | Legal | legal inbox | manual review | Legal Queue |
| Contact Form | Support / Owner | general inbox | manual routing | Contact Queue |
| Special Support Program Form | Support Programs | program inbox | manual review | Program Queue |

---

## 11. Year-One Execution Model

السنة الأولى يجب أن تكون:

```text
Founder Operated
Email Driven
Manual Review
No Heavy Workflow Engine
```

### Principles

* forms may send email.
* records may be lightweight.
* no complex permissions first.
* no department staffing assumption.
* no over-automation.
* no workflow engine قبل وضوح الطلبات الفعلية.

وجود Department لا يعني وجود فريق كامل.

```text
Department Exists
≠
Department Staff Exists
```

---

## 12. Future Portal Evolution

يمكن فصل الـ Portal لاحقًا إلى:

### `portal.mentalsmile.com`

Administrative intake وforms وdepartment routing.

### `library.mentalsmile.com`

المكتبة والمحتوى التعليمي.

### `finance.mentalsmile.com`

Billing, receipts, financial archive, subscription handling.

### `legal.mentalsmile.com`

Contracts, licensing, compliance, legal archive.

### `owner.mentalsmile.com`

Owner Room، القرارات، AI governance، strategy.

### `hr.mentalsmile.com`

HR، roles، onboarding، policies.

هذا التصميم يسمح بالفصل تدريجيًا بدون إعادة بناء النظام.

---

## 13. What Must Not Be Built Now

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
* building subdomains before validation.
* over-automation.

---

## 14. Minimal First Build

### Phase 1 Web Portal

أول نسخة قابلة للبناء:

* Home.
* About.
* Library Landing.
* Provider Registration Form.
* Center Registration Form.
* Service Request Form.
* Package Request Form.
* Contact Form.

كلها:

```text
Email-driven + lightweight record optional
```

الهدف ليس بناء نظام إداري كامل، بل فصل intake السيادي عن App Runtime.

---

## 15. Final Verdict

نعم، Portal Information Architecture هذه هي آخر طبقة تخطيط مطلوبة قبل بدء Web/Firebase setup، بشرط أن يبدأ التنفيذ كـ minimal Web Portal وليس workflow platform كامل.

ونعم، الفصل بين Web Intake وApp Runtime هو الاتجاه الأنظف من ترقيع التطبيق.

السبب:

* يحمي التطبيق من تضخم إداري.
* يفصل السيادة عن التشغيل.
* يقلل permissions داخل App Runtime.
* يسمح بالاستقبال اليدوي في السنة الأولى.
* يفتح الطريق لتقسيم subdomains مستقبلًا.

الحكم النهائي:

```text
Build Web Portal as Sovereign Intake.
Keep App as Operational Marketplace Runtime.
Do not merge administrative sovereignty into the app.
```

هذا Blueprint لا يغير Runtime.

هذا Blueprint لا يغير Rules.

هذا Blueprint لا ينفذ Web setup.

هذا Blueprint يحدد فقط Information Architecture للويب.
