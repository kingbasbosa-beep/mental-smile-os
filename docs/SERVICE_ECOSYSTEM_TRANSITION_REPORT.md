# SERVICE ECOSYSTEM TRANSITION REPORT

## Mental Smile - From Commission-Based Booking Flow to Service Ecosystem Platform

هذا التقرير لا ينفذ تغييرات.

هذا التقرير فقط يحدد الطريق الآمن للتحول.

---

## 1. Executive Summary

Mental Smile في الحالة الجديدة ليست منصة عمولات جلسات، وليست وسيط مالي، وليست جهة تحصيل أو تأكيد دفع أو إدارة payouts.

الاتجاه الصحيح:

```text
Mental Smile = Service Ecosystem Platform
```

يعني المنصة دورها يبقى تسهيل الوصول للخدمة، بناء الثقة، إظهار مقدمي الخدمة، دعم العميل، التعليم، الوقاية، المكتبة، التسويق، الشكاوى، التقييمات، التعليقات، وإعطاء أدوات تشغيل وظهور للأخصائيين والمراكز.

الحالة الحالية في الكود لا تزال تحمل بقايا واضحة من نموذج أقدم:

- `booking_requests` تجمع بين طلب الخدمة ودورة دفع ودورة payout ودورة accounting.
- يوجد UI للعميل لرفع `payment proof`.
- يوجد Admin UI لمراجعة الدفع وتأكيده.
- يوجد منطق `commission` و `net amount due to center`.
- يوجد `payoutStatus` للأخصائي والمركز.
- توجد صفحات archive/report تعرض بيانات دفع وتحويلات.
- توجد Firestore rules تسمح بتحديث حقول payment داخل booking lifecycle.

الاستنتاج التنفيذي:

Mental Smile جاهزة فكريا للتحول إلى Service Ecosystem، لكن runtime الحالي لم يتحرر بعد من دورة payment/commission/payout. التحول يجب أن يكون تدريجي: inventory ثم freeze ثم quarantine ثم UI de-emphasis ثم decoupling ثم legacy burial.

---

## 2. Current Runtime State

الحالة الحالية مبنية حول collection رئيسية اسمها:

```text
booking_requests
```

هذه collection حاليا تحتوي على خليط من:

- طلب العميل.
- رد مقدم الخدمة.
- حالة الجلسة.
- حالة payment.
- proof reference.
- accounting review.
- commission calculation.
- payout transfer.
- archive/report flags.

أهم runtime surfaces الموجودة حاليا:

| Surface | Current reality | State | Risk |
|---|---|---:|---:|
| Client booking | العميل يرى طلبات وحالات مثل `awaiting_payment` و `payment_review` | Active | High |
| Client payment proof | صفحة صريحة لرفع إثبات دفع | Active | Critical |
| Admin payments | مراجعة payment proof وتأكيد/رفض الدفع وتأكيد payout | Active | Critical |
| Admin sessions | ممكن تفتح payment quote من flow الجلسة | Active | Critical |
| Accounting workspace | مساحة admin مرتبطة بالدفع والتحويل والسجلات | Partial | High |
| Archive payments/accounting | أرشيف مالي قديم مرتبط بالجلسات | Partial/Active | High |
| Booking health | health counts فيها `paymentReviewCount` و `payoutPendingCount` | Partial | Medium |
| Firestore rules | تسمح بتحديث payment proof fields | Active | Critical |
| Center pricing | أسعار وخدمات المركز موجودة كعرض سعر | Active | Keep with rename |
| Clinician price text | سعر الأخصائي موجود كبيان ظهور | Active | Keep with rename |

ملاحظة مهمة: وجود pricing أو price display ليس مشكلة بحد ذاته. المشكلة هي ربط السعر بدورة تحصيل أو إثبات دفع أو عمولة أو payout داخل المنصة.

---

## 3. Financial Cycle Inventory

### 3.1 Current Payment / Payout / Accounting Files

| File path | Class / function / page | Route | Collection | Current role | Risk | Classification |
|---|---|---|---|---|---:|---|
| `lib/features/client/presentation/pages/client_payment_proof_page.dart` | `ClientPaymentProofPage` | `/client/payment-proof` | `booking_requests` | العميل يختار طلب في `awaiting_payment` ويرفع payment proof metadata | Critical | Active / Remove candidate |
| `lib/features/admin_surface/pages/admin_payments_page.dart` | `AdminPaymentsPage` | `/admin/payments` | `booking_requests` | admin يراجع الدفع، يوافق/يرفض، ويؤكد payout | Critical | Active / Quarantine |
| `lib/features/admin_surface/data/services/admin_payment_decision_adapter.dart` | `AdminPaymentDecisionAdapter.approvePayment` | via `/admin/payments` | `booking_requests` | تأكيد payment وتحويل الطلب إلى session setup | Critical | Active / Quarantine |
| `lib/features/admin_surface/data/services/admin_payment_decision_adapter.dart` | `rejectPayment` | via `/admin/payments` | `booking_requests` | رفض payment وإرجاع الطلب إلى `awaiting_payment` | Critical | Active / Quarantine |
| `lib/features/admin_surface/data/services/admin_payment_decision_adapter.dart` | `confirmClinicianPayout` | via `/admin/payments` | `booking_requests` | تأكيد تحويل payout للأخصائي | Critical | Active / Remove candidate |
| `lib/features/admin_surface/data/services/admin_payment_decision_adapter.dart` | `confirmCenterAccountingReview` | via `/admin/payments` | `booking_requests` | حساب gross/commission/net للمركز | Critical | Active / Remove candidate |
| `lib/features/admin_surface/data/services/admin_payment_decision_adapter.dart` | `confirmCenterPayout` | via `/admin/payments` | `booking_requests` | تأكيد payout للمركز | Critical | Active / Remove candidate |
| `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | `approvePayment`, `rejectPayment` | legacy/admin flows | `booking_requests` | payment methods موجودة كمسار قديم أو deprecated | Critical | Legacy / Quarantine |
| `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | `confirmCenterAccountingReview` | legacy/admin flows | `booking_requests` | commission calculation قديم | Critical | Legacy / Quarantine |
| `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart` | `confirmClinicianPayout`, `confirmCenterPayout` | legacy/admin flows | `booking_requests` | payout confirmation قديم | Critical | Legacy / Quarantine |
| `lib/features/admin_surface/data/services/admin_session_decision_adapter.dart` | `scheduleCenterResidency` | via `/admin/sessions` | `booking_requests` | يفتح quote ويدخل الطلب في `awaiting_payment` | Critical | Active / Quarantine |
| `lib/features/admin_surface/pages/admin_sessions_page.dart` | session setup payment dialog | `/admin/sessions` | `booking_requests` | يحسب tax/total/paymentBreakdown ويفتح payment | Critical | Active / Quarantine |
| `lib/features/booking/presentation/pages/my_bookings_page.dart` | booking status UI | booking pages | `booking_requests` | يعرض `awaiting_payment`, `payment_review`, `payout_pending`, receipt/note | High | Active / Freeze |
| `lib/features/booking/presentation/pages/clinician_inbox_page.dart` | clinician decision flow | clinician booking inbox | `booking_requests` | قبول الطلب يحوله إلى `awaiting_payment` ويكتب payment fields | High | Active / Quarantine |
| `lib/features/booking/presentation/pages/center_booking_request_page.dart` | center booking create | center request flow | `booking_requests` | ينشئ paymentStatus/payoutStatus مع طلب المركز | High | Active / Freeze |
| `lib/features/client/presentation/pages/client_dashboard_page.dart` | dashboard action | `/client/payment-proof` | none direct | يظهر زر أو action باسم Payment proof | High | Active / Remove candidate |
| `lib/features/client/presentation/pages/client_sessions_page.dart` | session state labels | client sessions | `booking_requests` | يعرض `payout_pending` ضمن lifecycle | Medium | Active / Freeze |
| `lib/features/clinician/presentation/pages/clinician_operations_page.dart` | payment confirmed gate | clinician ops | `booking_requests` | يستخدم `payment_confirmed` في تشغيل session state | High | Active / Quarantine |
| `lib/features/admin_surface/pages/admin_session_report_page.dart` | payment report fields | admin report | `booking_requests` | يعرض paymentStatus/payoutStatus/receipt/payout dates | High | Active / Freeze |
| `lib/features/admin_surface/pages/admin_archive_payments_page.dart` | payment archive | `/admin/archive/payments` | archive/booking data | أرشيف payment/transfer | High | Partial / Freeze |
| `lib/features/admin_surface/pages/admin_archive_accounting_page.dart` | accounting archive | `/admin/archive/accounting` | archive/accounting data | أرشيف accounting | High | Partial / Freeze |
| `lib/features/admin_surface/pages/accounting_workspace_page.dart` | accounting workspace | `/admin/accounting` | connected payment records | workspace مالي admin | High | Partial / Freeze |
| `lib/features/booking/data/services/booking_health_service.dart` | booking health counts | system health | `booking_requests`, system docs | يحسب `payment_review` و `payout_pending` | Medium | Partial / Freeze |
| `lib/core/ui/value_label_mapper.dart` | status labels | global | none | labels لحالات payment/payout | Medium | Active / Freeze |
| `lib/core/system/domain_registry.dart` | booking domain description | system registry | none | يصف booking بأنه يحتوي payment states | Medium | Active / Rename candidate |
| `firestore.rules` | booking user update allowlist | Firestore rules | `booking_requests` | يسمح بحقول payment proof من المستخدم | Critical | Active / Quarantine |
| `test/center_cycle.rules.test.js` | center cycle rules test | test | `booking_requests` | يثبت transitions فيها payment/payout | Medium | Legacy / Freeze |
| `tools/qa_bot/audit_center_followup.py` | QA audit | tool | `booking_requests` | يبحث عن `payout_pending` | Low/Medium | Legacy / Freeze |

### 3.2 Current Financial Fields Found

أهم الحقول المالية أو شبه المالية المرتبطة بدورة الجلسة:

| Field | Current meaning | New model status |
|---|---|---|
| `paymentStatus` | حالة payment داخل booking lifecycle | Freeze then remove/legacy |
| `payment_confirmed` | هل payment اتأكد | Freeze then remove |
| `paymentReceiptFileName` | اسم ملف إثبات الدفع | Remove from active flow |
| `paymentReceiptUrl` | رابط إثبات الدفع | Remove from active flow |
| `paymentSubmittedAt` | وقت رفع الإثبات | Remove from active flow |
| `paymentClientNote` | ملاحظة العميل مع الإثبات | Remove from active flow |
| `paymentApprovedAt` | وقت موافقة admin على الدفع | Remove |
| `paymentRejectedAt` | وقت رفض الدفع | Remove |
| `paymentApprovedBy` | admin الذي أكد الدفع | Remove |
| `payoutStatus` | حالة تحويل مستحقات provider | Remove |
| `payoutTransferredAt` | وقت تحويل payout | Remove |
| `payoutTransferredBy` | admin الذي أكد payout | Remove |
| `accountingReviewStatus` | حالة مراجعة accounting | Remove |
| `grossClientPaidAmount` | إجمالي ما دفعه العميل | Remove from platform lifecycle |
| `appCommissionPercent` | نسبة عمولة المنصة | Remove |
| `appCommissionAmount` | قيمة عمولة المنصة | Remove |
| `netAmountDueToCenter` | صافي مستحق المركز | Remove |
| `accountingReviewNotes` | ملاحظات accounting | Remove or legacy archive only |
| `accountingConfirmedBy` | admin accounting confirmer | Remove |
| `accountingConfirmedAt` | وقت تأكيد accounting | Remove |
| `paymentBreakdownText` | تفصيل quote/payment | Remove from request flow |
| `paymentQuotePreparedAt` | وقت تجهيز quote | Remove |
| `paymentQuotePreparedBy` | admin مجهز quote | Remove |
| `stayTaxPercent` | tax داخل payment quote | Remove from platform payment |
| `stayTaxAmount` | tax amount | Remove |
| `stayTotalAmount` | total amount | Remove |

حقول يجب التعامل معها بحذر لأنها قد تبقى كـ price visibility وليس payment lifecycle:

| Field / model | Current meaning | New model status |
|---|---|---|
| `sessionPriceText` | سعر الأخصائي كنص في التسجيل/الظهور | Keep as displayed provider price |
| `CenterPricing.price` | سعر خدمة أو إقامة أو package للمركز | Keep as service price display |
| `pricingUnit` | وحدة السعر | Keep |
| `pricingReady` | هل المركز مجهز بيانات pricing | Keep/Rename |
| `selectedAccommodationPrice` | سعر accommodation مختار | Rename to displayed provider price or remove from request |
| `selectedAccommodationPricingSnapshot` | snapshot سعر وقت الطلب | Quarantine; possible future transparency snapshot |

### 3.3 UI Exposure

الدورة المالية ظاهرة للمستخدم أو admin في أماكن واضحة:

- `/client/payment-proof`: رفع إثبات دفع.
- `/admin/payments`: مراجعة الدفع وتأكيد payout.
- `/admin/accounting`: مساحة accounting.
- `/admin/archive/payments`: أرشيف payment.
- `/admin/archive/accounting`: أرشيف accounting.
- `/admin/sessions`: فتح payment quote في بعض مسارات المركز.
- admin reports: عرض receipt/payment/payout fields.
- client bookings/sessions: عرض حالات `awaiting_payment`, `payment_review`, `payout_pending`.
- clinician inbox/operations: الاعتماد على `payment_confirmed`.

### 3.4 Firestore Reality

المكان الأخطر حاليا:

```text
firestore.rules
```

Current reality:

- يسمح لبعض المستخدمين بتحديث حقول payment proof في `booking_requests`.
- يستخدم custom claim/admin authority في مسارات admin.
- يحمي/يسمح بحقول registration/profile مثل `subscriptionStatus`, `sessionPriceText`, و `pricingReady`.

Risk:

أي حذف مباشر للحقول أو الصفحات قبل تعديل rules سيعمل permission mismatch أو runtime failure.

---

## 4. Target Service Ecosystem State

الحالة المستهدفة:

```text
Booking / Service Request != Payment Request
```

في النموذج الجديد:

- لا يوجد `payment proof` داخل request lifecycle.
- لا يوجد `confirm payment` داخل request lifecycle.
- لا يوجد `commission lifecycle`.
- لا يوجد `payout lifecycle`.
- لا يوجد `accounting lifecycle` مرتبط بالجلسة.
- الطلب يصبح علاقة اتصال/خدمة بين العميل ومقدم الخدمة.
- الدفع يتم خارج المنصة بين العميل ومقدم الخدمة، أو حسب اتفاقهما المباشر.
- المنصة لا تحفظ إثبات الدفع.
- المنصة لا تؤكد دفع العميل.
- المنصة لا تدير مستحقات provider.
- المنصة لا تدخل في نزاعات مالية بين العميل ومقدم الخدمة.

الدورة الجديدة المقترحة:

```text
Client request
-> Provider response
-> Session / Meeting coordination
-> Review / Comment
-> Complaint if needed
-> Archive
```

مسؤولية المنصة:

- Trust verification.
- License visibility.
- Ratings/comments.
- Complaint routing.
- Support continuity.
- Library and education.
- Marketing/visibility.
- Professional tools.
- Center tools.
- Analytics بدون accounting للجلسة.

---

## 5. Remove / Freeze / Rename / Quarantine / Keep Map

### REMOVE

عناصر ضد النموذج الجديد ويجب حذفها مستقبلا من active request flow بعد التأكد من dependencies:

- صفحة `/client/payment-proof`.
- action في client dashboard باسم Payment proof.
- رفع `paymentReceiptFileName`.
- رفع `paymentReceiptUrl`.
- `paymentStatus` كجزء من service lifecycle.
- `payment_confirmed` كشرط لتشغيل الجلسة.
- admin approve/reject payment actions.
- `confirmClinicianPayout`.
- `confirmCenterPayout`.
- `confirmCenterAccountingReview`.
- commission fields: `appCommissionPercent`, `appCommissionAmount`.
- platform net settlement fields: `netAmountDueToCenter`.
- payment quote flow في `AdminSessionDecisionAdapter.scheduleCenterResidency`.
- financial archive كجزء من session lifecycle النشط.

### FREEZE

عناصر تبقى مؤقتا لكي لا ينكسر النظام، لكن ممنوع التوسع فيها:

- كل حقول payment/payout/accounting الموجودة داخل `booking_requests`.
- `/admin/payments`.
- `/admin/accounting`.
- `/admin/archive/payments`.
- `/admin/archive/accounting`.
- payment/payout labels في `ValueLabelMapper`.
- health counters الخاصة بـ payment review و payout pending.
- tests التي تثبت flow قديم إلى حين كتابة tests للنموذج الجديد.
- docs/archive التي تسجل التاريخ القديم.

### RENAME

عناصر تحتاج تغيير معنى قبل أو أثناء التحول:

| Current name | Recommended future name | Reason |
|---|---|---|
| Booking Request | Service Request | أوسع من جلسة مدفوعة، ويناسب client/professional/center |
| Consultation Request | Secondary option | مناسب لو المنتج مركز على استشارة فقط |
| Connection Request | Secondary option | مناسب لو الهدف مجرد ربط العميل بالمقدم |
| `booking_requests` | `service_requests` future collection | بعد migration فقط، وليس الآن |
| `paymentStatus` | `legacyPaymentStatus` | لو بقت للقراءة التاريخية فقط |
| `payoutStatus` | `legacyPayoutStatus` | لو بقت للقراءة التاريخية فقط |
| `pricing` | `providerPriceInfo` أو `displayedServicePrice` | السعر للشفافية، وليس للتحصيل |
| Payment archive | Legacy financial archive | أرشيف تاريخي غير نشط |
| Booking domain description | Service request and coordination domain | إزالة وصف payment states |

التوصية الاسمية:

```text
Service Request
```

لأنها أوسع وأهدأ قانونيا من Booking Request، ولا تفترض أن المنصة تدير جلسة مدفوعة.

### QUARANTINE

عناصر خطيرة أو متشابكة يجب عزلها قبل الحذف:

- `AdminPaymentDecisionAdapter`.
- financial methods داخل `AdminBookingDecisionAdapter`.
- payment quote logic داخل `AdminSessionDecisionAdapter.scheduleCenterResidency`.
- `AdminPaymentsPage`.
- financial actions داخل `AdminSessionsPage`.
- `ClientPaymentProofPage`.
- `ClinicianInboxPage` transition إلى `awaiting_payment`.
- `ClinicianOperationsPage` اعتمادها على `payment_confirmed`.
- report/archive pages التي تقرأ payment/payout/accounting fields.
- `firestore.rules` allowlist الخاصة بـ payment proof fields.

### KEEP

عناصر تخدم Service Ecosystem ويجب الحفاظ عليها:

- ratings.
- comments/reviews.
- complaints.
- support requests.
- chat/escalations.
- trust verification.
- license visibility.
- clinician profile/dashboard.
- center profile/dashboard.
- displayed prices for transparency.
- library.
- educational resources.
- prevention content.
- marketing/content tools.
- provider visibility.
- AI tools.
- reports غير المالية.
- analytics غير accounting.
- support continuity.
- government/private complaint links.

---

## 6. Technical Transition Plan

### Phase 0 - Inventory Only

الهدف: حصر بدون تعديل.

Actions:

- تثبيت قائمة كل الملفات والroutes والحقول المالية.
- فصل price display عن payment lifecycle في التوثيق.
- تحديد كل imports التي تعتمد على payment adapters.
- تحديد كل pages التي تعرض `paymentStatus`, `payoutStatus`, `payment_confirmed`.
- تحديد كل rules التي تسمح أو تمنع حقول مالية.
- تحديد كل reports/archive التي تعتمد على financial fields.

Output:

- Inventory نهائي.
- No runtime changes.
- No rules changes.

### Phase 1 - Runtime Freeze

الهدف: منع توسع النموذج المالي القديم.

Actions:

- إعلان `payment/payout/accounting in booking flow` كـ frozen domain.
- منع أي feature جديد يستخدم `paymentStatus` أو `payoutStatus`.
- أي bug fix يكون minimal وغير توسعي.
- منع إضافة reports مالية جديدة.

Output:

- freeze policy.
- deprecated annotations مستقبلية، لكن ليس في هذا التقرير.

### Phase 2 - UI De-emphasis

الهدف: تقليل ظهور الدفع بدون حذف مباشر.

Actions future:

- إخفاء أو تقليل prominence لـ `/client/payment-proof`.
- إزالة CTA من dashboard بعد وجود alternative flow.
- جعل admin payment surfaces read-only أو legacy-only.
- تغيير copy من payment processing إلى provider direct arrangement.

Output:

- أقل confusion للعميل/provider.
- لا كسر للبيانات القديمة.

### Phase 3 - Flow Simplification

الهدف: تحويل lifecycle إلى خدمة واتصال.

Target flow:

```text
Client request
-> Provider response
-> Session / Meeting coordination
-> Review / Comment
-> Complaint if needed
```

Actions future:

- `awaiting_payment` يستبدل بحالة مثل `awaiting_provider_coordination`.
- `payment_review` يخرج من active lifecycle.
- `payout_pending` يخرج من active lifecycle.
- `payment_confirmed` لا يكون gate للجلسة.

### Phase 4 - Data Decoupling

الهدف: فصل الحقول المالية عن request lifecycle.

Actions future:

- القراءة التاريخية فقط من legacy fields.
- وقف writes الجديدة للحقول المالية.
- إبقاء displayed price كبيان شفافية فقط.
- أي old financial data يبقى legacy archive وليس operational source.

### Phase 5 - Legacy Burial

الهدف: دفن القديم بعد التأكد.

شروط الدفن:

- لا imports فعالة.
- لا routes نشطة.
- لا rules dependencies.
- لا tests تعتمد على flow القديم إلا legacy tests.
- لا reports critical تحتاج الحقول.
- Owner وافق على legal/product direction.

---

## 7. New Platform Responsibility Model

### Platform Does

- يتحقق من الثقة والهوية والتراخيص.
- يعرض مقدمي الخدمة والمراكز بشكل منظم.
- يوفر library وتعليم ووقاية ودعم.
- يسهل التواصل والاختيار والمقارنة.
- يوفر ratings/comments.
- يوفر complaint routing.
- يوفر support continuity.
- يوفر visibility and marketing spaces.
- يوفر professional tools.
- يوفر analytics تشغيلية غير مالية.
- يوفر AI assistant/tools في حدود واضحة.

### Platform Does Not

- لا تحصل أموال الجلسات.
- لا تستقبل payment proof.
- لا تؤكد الدفع.
- لا تحسب عمولة على الجلسات.
- لا تدير payouts.
- لا تدير settlements.
- لا تدخل في accounting الخاص بالجلسة.
- لا تحكم في نزاع مالي بين العميل ومقدم الخدمة.
- لا تضمن نتيجة علاجية أو تشخيصية.

### Trust Boundary

المنصة تضمن شفافية العرض والحوكمة والدعم والشكاوى.

المنصة لا تضمن:

- نتيجة الخدمة.
- التزام مالي بين الطرفين.
- جودة كل تعامل خارج المنصة.
- صحة أي اتفاق دفع يتم خارجها، إلا إذا كان متعلق ببلاغ أو شكوى أو مخالفة موثقة.

---

## 8. Client / Professional / Center Layers

### Client Layer

الحساب للعميل مجاني.

Responsibilities:

- library.
- support.
- education.
- prevention.
- search and comparison.
- رؤية الأسعار كبيانات معلنة من provider.
- رؤية التراخيص.
- رؤية ratings/comments.
- تقديم complaint.
- الوصول لخطوط شكاوى حكومية وخاصة بالمنصة.

Not included:

- لا payment proof.
- لا payment confirmation.
- لا platform wallet.
- لا dispute مالي داخل التطبيق.

### Professional Layer

الأخصائي يمكن أن يدفع subscription أو يستخدم tools مدفوعة.

Capabilities:

- digital clinic.
- profile visibility.
- client management.
- Zoom / Google Meet coordination.
- reports and measures.
- AI assistant.
- marketing/content tools.
- paid professional resources.
- ظهور داخل المنصة.
- مساحة إعلانية.
- courses and skill development.

Financial model:

- دخل المنصة يأتي من subscription/tools/visibility/resources، وليس عمولة جلسة.

### Center Layer

المركز يدفع مقابل الظهور والخدمات والأدوات والتسويق.

Capabilities:

- center profile.
- عرض الخدمات والأسعار.
- عرض التراخيص.
- reviews/comments.
- marketing/content.
- فرص وصول لعملاء.
- assessment أو diagnostic interviews.
- future courses/diplomas/educational spaces.

Financial model:

- subscription أو rented service space أو paid marketing/tools.
- لا platform-managed session payment.

### Platform Layer

Responsibilities:

- trust verification.
- visibility.
- complaint routing.
- support continuity.
- content/library governance.
- marketing spaces.
- AI translation future hook.
- multilingual market future hook.
- analytics.
- professional enablement.

---

## 9. Risks and Blockers

### Booking Flow Break Risk

`booking_requests` حاليا يعتمد على statuses مالية مثل:

- `awaiting_payment`
- `payment_review`
- `payout_pending`

أي حذف مباشر سيكسر UI logic وadmin logic وreports.

### Firestore Rules Mismatch

`firestore.rules` يسمح بحقول payment proof. لو اتغيرت UI بدون تعديل rules أو العكس، ممكن يحصل permission-denied أو بقايا حقول غير مستخدمة.

### UI Route Dependency

routes صريحة موجودة:

- `/client/payment-proof`
- `/admin/payments`
- `/admin/accounting`
- `/admin/archive/payments`
- `/admin/archive/accounting`

حذف route قبل إزالة navigation/imports سيكسر التطبيق.

### Reports Dependency

admin session report وarchive reports تعرض:

- receipt.
- paymentStatus.
- payoutStatus.
- accounting fields.
- payout dates.

لازم تتحول إلى legacy display أو تزال بعد migration.

### Admin Dashboard Dependency

admin section map يعرف payments/accounting/archive كأقسام. ده ممكن يخلق توقع تشغيلي خاطئ بعد التحول.

### Old Data Migration

البيانات القديمة داخل `booking_requests` قد تحتوي payment fields. لا يجب مسحها قبل قرار retention.

### User Confusion

لو بقيت كلمة payment ظاهرة في UI بعد إعلان النموذج الجديد، العميل هيفتكر إن المنصة مسؤولة ماليا.

### Provider Confusion

لو provider شاف payout أو commission statuses، هيفتكر إن المنصة هتحصل وتحول له أموال.

### Legal Wording Risk

لازم صياغة واضحة:

- المنصة لا تدير دفع الجلسة.
- المنصة لا تضمن نتيجة الخدمة.
- المنصة لا تفصل في النزاعات المالية.
- المنصة تستقبل complaints مرتبطة بالسلوك والثقة والشفافية، وليس كطرف مالي.

---

## 10. Recommended Codex Execution Packages

### Best First 10 Files To Inspect

1. `lib/features/client/presentation/pages/client_payment_proof_page.dart`
2. `lib/features/admin_surface/pages/admin_payments_page.dart`
3. `lib/features/admin_surface/data/services/admin_payment_decision_adapter.dart`
4. `lib/features/admin_surface/data/services/admin_booking_decision_adapter.dart`
5. `lib/features/admin_surface/data/services/admin_session_decision_adapter.dart`
6. `lib/features/admin_surface/pages/admin_sessions_page.dart`
7. `lib/features/booking/presentation/pages/my_bookings_page.dart`
8. `lib/features/booking/presentation/pages/clinician_inbox_page.dart`
9. `lib/features/admin_surface/pages/admin_session_report_page.dart`
10. `firestore.rules`

### Best First 10 Financial Fields To Freeze

1. `paymentStatus`
2. `payment_confirmed`
3. `paymentReceiptFileName`
4. `paymentReceiptUrl`
5. `paymentSubmittedAt`
6. `paymentClientNote`
7. `payoutStatus`
8. `payoutTransferredAt`
9. `accountingReviewStatus`
10. `appCommissionPercent`

Secondary freeze fields:

- `appCommissionAmount`
- `grossClientPaidAmount`
- `netAmountDueToCenter`
- `accountingReviewNotes`
- `accountingConfirmedAt`
- `accountingConfirmedBy`
- `paymentBreakdownText`
- `paymentQuotePreparedAt`
- `paymentQuotePreparedBy`

### Best First 10 Routes / Pages To Classify

1. `/client/payment-proof`
2. `/admin/payments`
3. `/admin/accounting`
4. `/admin/archive/payments`
5. `/admin/archive/accounting`
6. `/admin/sessions`
7. admin session report page
8. client bookings page
9. clinician inbox page
10. `/web/center/pricing`

ملاحظة: `/web/center/pricing` لا يجب حذفه تلقائيا. الأفضل تحويله إلى price transparency/service display بدل payment lifecycle.

### Do Not Touch Now

- لا تحذف routes.
- لا تغير Firestore rules.
- لا تمسح legacy fields.
- لا تعمل migration.
- لا تلغي admin pages.
- لا تغير tests قبل وجود target flow tests.
- لا تحذف archive documents.
- لا تغير `booking_requests` collection name الآن.

### Safe To Transform Later

- UI copy من payment processing إلى direct provider arrangement.
- labels التي تعرض payment statuses كـ legacy.
- dashboard CTA الخاص بـ payment proof بعد وجود request flow بديل.
- domain description من booking/payment إلى service coordination.
- reports بحيث تصبح legacy-only.
- pricing language بحيث تبقى displayed provider price.

### Needs Owner Decision Before Any Code Change

- الاسم الرسمي: `Service Request` أم `Connection Request` أم `Consultation Request`.
- هل الأسعار تظهر كـ fixed prices أم ranges أم "provider declared price".
- هل يوجد أي payment partner مستقبلا أم ممنوع تماما.
- شكل subscription للأخصائي.
- شكل subscription/visibility للمركز.
- legal disclaimer النهائي.
- retention policy للبيانات المالية القديمة.
- هل financial archive يبقى hidden أم read-only أم deleted بعد مدة.
- سياسة complaint links الحكومية والخاصة.
- حدود AI assistant للأخصائيين والعملاء.

### Suggested Execution Packages

Package 1 - Financial Dependency Inventory:

- Read-only scan لكل imports/routes/fields.
- Output: dependency map فقط.

Package 2 - Runtime Freeze Labels:

- لا تنفيذ الآن.
- مستقبلا: وضع deprecated/frozen markers في docs أو admin copy.

Package 3 - Service Request Naming Decision:

- Owner يختار الاسم الرسمي.
- بعد القرار فقط يبدأ rename plan.

Package 4 - UI De-emphasis Plan:

- إزالة prominence من payment proof بدون حذف.
- تحويل admin financial pages إلى legacy/admin-only.

Package 5 - New Request Lifecycle Design:

- حالات جديدة للطلب:
  - `submitted`
  - `provider_review`
  - `provider_accepted`
  - `coordination_pending`
  - `meeting_scheduled`
  - `completed`
  - `reviewed`
  - `complaint_opened`

Package 6 - Data Decoupling Plan:

- منع writes الجديدة للحقول المالية.
- إبقاء reads القديمة كـ legacy.

Package 7 - Legacy Burial Plan:

- يتم فقط بعد verification كامل.

---

## 11. Final Verdict

ما يوجد اليوم:

- Mental Smile لديها platform foundation واسعة.
- لديها trust/registration/support/library/admin/control concepts.
- لكنها runtime-wise لا تزال تحمل payment/commission/payout/accounting داخل booking lifecycle.

ما يعمل اليوم:

- طلبات booking/service.
- admin review.
- client payment proof.
- payment approval/rejection.
- payout confirmation.
- center pricing display.
- reports/archive تعرض financial fields.

ما يعمل جزئيا:

- accounting workspace.
- financial archive.
- booking health financial counts.
- center pricing as transparency vs payment quote.

ما يجب تجميده:

- كل منطق payment proof.
- كل confirm payment.
- كل payout.
- كل commission.
- كل accounting مرتبط بالجلسة.

ما يجب الحفاظ عليه:

- trust.
- licenses.
- ratings.
- comments/reviews.
- complaints.
- support.
- library.
- education.
- marketing/visibility.
- clinician tools.
- center tools.
- price transparency بدون platform payment.

ما هو pilot-safe:

- تشغيل المنصة كـ Service Ecosystem مع payment خارج المنصة، بشرط إزالة أو إخفاء توقعات الدفع من الواجهة تدريجيا.
- إبقاء legacy المالي مجمد ومحصور لحين decoupling.

ما لا يجب لمسه الآن:

- لا حذف routes.
- لا تغيير Firestore rules.
- لا migration.
- لا حذف fields.
- لا refactor.
- لا تغيير booking collection.

الطريق الآمن:

```text
Inventory
-> Freeze
-> Quarantine
-> UI De-emphasis
-> Flow Simplification
-> Data Decoupling
-> Legacy Burial
```

الخلاصة:

Mental Smile يجب أن تتحول من منصة حجز بظل مالي إلى Service Ecosystem Platform. الكود الحالي يحتوي آثار مالية نشطة، لذلك أي تحول مباشر سيكون خطر. أفضل قرار تقني الآن هو تجميد كل payment/payout/accounting logic، وعزلها، ثم بناء service request lifecycle جديد لا يعتمد على إثبات دفع أو عمولة أو تحويلات.

هذا التقرير لا ينفذ تغييرات.

هذا التقرير فقط يحدد الطريق الآمن للتحول.
