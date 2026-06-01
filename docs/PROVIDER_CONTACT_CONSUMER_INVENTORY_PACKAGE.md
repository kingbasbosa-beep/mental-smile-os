# PROVIDER_CONTACT_CONSUMER_INVENTORY_PACKAGE

## 1. Executive Summary

هذا التقرير يحصر المستهلكين المحتملين لـ Provider Contact Foundation قبل أي استخدام Runtime.

`ProviderContactRequest` يمثل:

```text
I want this provider to contact me regarding this service.
```

وليس Booking. لذلك أي Consumer مستقبلي يجب أن يقرأ هذه capability كـ contact intent أو service request visibility فقط، بدون دفع أو محاسبة أو تقييمات أو دعم مملوك لها.

---

## 2. Current Possible Consumers

### Client Dashboard

قد يحتاج مستقبلًا لعرض "My Provider Contact Requests" أو "My Service Requests".

Current risk:

* قد يكون مرتبطًا حاليًا بلغة booking/payment legacy.

### Provider Dashboard

قد يحتاج رؤية incoming contact requests أو service request inbox.

Current risk:

* لا يجب أن يتحول إلى Booking Inbox أو session workflow.

### Center Dashboard

قد يحتاج عرض طلبات تواصل مع المركز أو service interest.

Current risk:

* يجب تجنب language توحي أن المنصة تؤكد الحجز أو تدير الخدمة.

### Admin Visibility

قد يحتاج Control Room رؤية stuck requests أو abuse signals.

Current risk:

* visibility فقط، وليس ownership.

### Archive

قد يحتاج حفظ references للطلبات القديمة والتوافق.

Current risk:

* archive لا يملك domain ولا يقرر workflow.

### Support Reference

قد يحتاج support ربط reference request عند وجود شكوى أو متابعة.

Current risk:

* Support يملك الشكوى، وليس Provider Contact.

---

## 3. Future Consumers

### My Provider Contact Requests

واجهة العميل المستقبلية لعرض طلبات التواصل.

Risk level: Low to Medium.

### Provider Request Inbox

واجهة مقدم الخدمة لقراءة contact/service requests.

Risk level: Medium.

### Admin Exception Visibility

واجهة Control Room لمراقبة العالق أو المريب.

Risk level: Medium to High.

---

## 4. Low-Risk Adoption Candidates

أقل candidates مخاطرة لاحقًا:

* read-only client list.
* read-only provider inbox preview.
* simple request status display.
* admin count/visibility summary without actions.

هذه candidates لا تغير writes ولا routes ولا rules.

---

## 5. High-Risk Consumers To Delay

يجب تأجيل:

* أي workflow يغير status.
* أي admin action يتحكم في الطلبات.
* أي route replacement لـ `/booking/*`.
* أي archive mutation.
* أي support escalation write.
* أي coordination automation.

السبب: هذه تحتاج rules design، compatibility plan، وOwner approval.

---

## 6. Compatibility Notes With `booking_requests`

`booking_requests` تبقى legacy-readable أثناء التحول.

Provider Contact لا يجب أن تقرأ أو تكتب `booking_requests` مباشرة في هذه المرحلة.

الاتجاه المستقبلي:

```text
booking_requests
↓
compatibility layer
↓
Provider Contact read surfaces
```

وليس:

```text
Provider Contact
↓
booking_requests as owner
```

---

## 7. What Must Not Be Done

ممنوع الآن:

* تعديل Runtime.
* تعديل Rules.
* تعديل Routes.
* تعديل UI.
* إنشاء collections.
* نقل بيانات.
* ربط Provider Contact بـ `booking_requests`.
* إدخال payment أو accounting أو review أو complaint ownership.
* تحويل Provider Contact إلى Booking lifecycle.

---

## 8. Final Verdict

Consumer inventory يوضح أن Provider Contact Foundation جاهزة كـ domain foundation، لكنها ليست جاهزة للاستخدام Runtime قبل تصميم adoption package منفصل.

أول adoption آمن مستقبلًا يكون read-only وبـ fallback واضح.

هذا التقرير لا يغير Runtime.

هذا التقرير لا يغير Rules.

هذا التقرير لا ينفذ Extraction.
