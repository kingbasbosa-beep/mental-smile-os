# WEB_P3B_EMAIL_FIRST_INTAKE_BLUEPRINT

## 1. Executive Summary

Mental Smile تختار في السنة التشغيلية الأولى:

```text
Email First Intake
```

بدل:

* CRM.
* Ticketing.
* Workflow Engines.
* Intake Systems.

السبب أن المرحلة الأولى Founder Operated، وحجم الطلبات الحقيقي لم يثبت بعد. بناء CRM أو workflow engine مبكرًا سيضيف تكلفة وتعقيد وصلاحيات قبل وجود احتياج مثبت.

Email First يسمح بـ:

* تشغيل فوري.
* تكلفة منخفضة.
* مراجعة بشرية.
* مرونة في تغيير التصنيف.
* عدم إنشاء collections مبكرًا.
* عدم تعقيد Firestore rules.
* الحفاظ على قابلية التطور لاحقًا.

---

## 2. Current Operational Doctrine

العقيدة التشغيلية للسنة الأولى:

```text
Founder Operated

Email Driven

Manual Review

Manual Assignment

Manual Follow-up

No Workflow Engine

No CRM

No Ticket System
```

هذا لا يعني أن الإدارات غير موجودة. يعني فقط أن تنفيذها في السنة الأولى يدوي ومؤسس بواسطة الـ Owner.

---

## 3. Primary Intake Inbox

Primary Operational Inbox:

```text
mentalsmile.platform@gmail.com
```

الدور الحالي:

* استقبال Service Requests.
* استقبال Package Requests.
* استقبال Contact Requests.
* استقبال business/commerce inquiries.
* مراجعة أولية بواسطة الـ Owner.
* تصنيف الطلب يدويًا.
* الرد أو المتابعة يدويًا.

هذا البريد هو نقطة التشغيل الأساسية للـ Portal Intake في السنة الأولى.

---

## 4. Backup Inbox

Backup Operational Inbox:

```text
recoveryhubworld@gmail.com
```

يستخدم عند:

* فشل الوصول إلى الـ Primary Inbox.
* مشكلة مؤقتة في استقبال الرسائل.
* احتياج recovery أو continuity.
* تواصل يدوي بديل عند توقف primary.

لا يستخدم كـ:

* primary routing inbox.
* department mailbox.
* CRM بديل.
* أرشيف رسمي دائم.

القاعدة:

```text
Backup supports continuity.
Primary remains the official intake point.
```

---

## 5. Service Request Intake

Service Request يمثل طلب خدمة مثل:

* Marketing Campaign.
* Content Creation.
* Technical Service.
* AI Service.
* White Label / Tenant.
* Partnership.

Fields:

* requester.
* organization.
* service type.
* budget.
* timeline.
* notes.

Destination:

```text
Primary Inbox
```

Review:

```text
Owner Review
```

بعد المراجعة، يتم التواصل يدويًا لتحديد scope أو discovery call أو الرفض/التأجيل.

---

## 6. Package Request Intake

Package Request يمثل طلب:

* Subscription.
* Verification.
* Visibility Package.
* Tool / AI Package.
* Optional Module Rental.

Fields:

* requester.
* provider/center.
* package type.
* billing preference.
* notes.

Destination:

```text
Primary Inbox
```

Review:

```text
Owner Review
```

Finance أو payment instructions لا تصدر تلقائيًا. أي دفع أو إيصال يأتي فقط بعد مراجعة بشرية.

---

## 7. Contact Request Intake

Contact Request يمثل تواصل عام أو استفسار.

Fields:

* name.
* topic.
* message.
* preferred contact method.

Destination:

```text
Primary Inbox
```

Review:

```text
Owner Review
```

لا يستخدم هذا النموذج للدعم الطارئ أو الحالات العاجلة.

---

## 8. Intake Lifecycle

دورة intake في السنة الأولى:

```text
Visitor

↓

Portal Form

↓

Email

↓

Owner Inbox

↓

Review

↓

Decision

↓

Manual Response

↓

Follow-up
```

لا توجد assignment automation أو ticket lifecycle في هذه المرحلة.

---

## 9. Failure Handling Strategy

إذا فشل:

```text
Primary Inbox
```

الإجراء:

1. استخدام `recoveryhubworld@gmail.com` مؤقتًا لاستقبال أو متابعة الطلبات.
2. توثيق يدوي لأي رسائل وصلت للـ backup.
3. نقل أو نسخ المتابعة المهمة إلى primary عند عودته.
4. عدم تحويل backup إلى mailbox رسمي دائم إلا بقرار Owner.

Backup يستخدم لاستمرارية التشغيل فقط.

---

## 10. Transitional Persistence Strategy

### Phase 1

الحالة الحالية:

```text
Portal Form

↓

Email

↓

Owner Review
```

لا يوجد Firestore intake record الآن.

### Phase 2

مستقبلاً فقط:

```text
Portal Form

↓

Firestore Intake Record

↓

Owner Review
```

هذا غير منفذ حاليًا.

لا يبدأ Phase 2 إلا عند وجود:

* حجم طلبات يستحق persistence.
* privacy/rules design.
* owner approval.
* QA plan.

### Phase 3

مستقبلاً فقط:

```text
Portal Form

↓

Intake Records

↓

Assignment

↓

Department Queue
```

هذا غير منفذ حاليًا.

لا يبدأ Phase 3 إلا عند وجود إدارات أو workloads تحتاج queue حقيقي.

---

## 11. What Must Not Be Built Now

ممنوع حاليًا:

* CRM.
* Ticket System.
* Workflow Engine.
* Department Queues.
* Finance Automation.
* Legal Automation.
* Automatic Assignment.
* Automatic Approval.
* Auto Responses.
* Firestore Intake Records.
* mailto integration.
* backend email sending.
* app runtime integration.

---

## 12. Future Evolution

التطور المستقبلي الممكن:

```text
Email

↓

Shared Inbox

↓

Firestore Intake Records

↓

Department Mailboxes

↓

Queues

↓

CRM

↓

Federated Intake System
```

هذا مجرد اتجاه مستقبلي، وليس تنفيذًا حاليًا.

---

## 13. Final Recommendation

نعم:

```text
Email First
```

هو الحل الأنسب للسنة الأولى.

### حدوده

* لا يعطي tracking كامل.
* لا يعطي dashboard أو queue.
* يعتمد على discipline يدوي.
* قابل للفوضى إذا زاد حجم الطلبات.
* يحتاج أرشفة يدوية جيدة.

### متى ننتقل إلى Firestore Intake Records؟

عندما:

* يزيد حجم الطلبات.
* يصبح البحث والمتابعة اليدوية صعبين.
* يحتاج Owner visibility منظمة.
* يتم اعتماد rules/privacy design.

### متى يصبح CRM أو Ticketing منطقيًا؟

عندما:

* توجد فرق متعددة.
* توجد SLA أو response targets.
* توجد assignment بين إدارات.
* يزيد حجم الطلبات عن قدرة البريد.
* تصبح التقارير والمتابعة جزءًا من التشغيل اليومي.

الحكم النهائي:

```text
Use Email First now.
Design for records later.
Do not build workflow before demand proves it.
```

هذا Blueprint يوثق فقط.

هذا Blueprint لا يرسل بريدًا.

هذا Blueprint لا يضيف mailto.

هذا Blueprint لا يضيف Backend.

هذا Blueprint لا يضيف Firestore.

هذا Blueprint لا يغير Runtime.
