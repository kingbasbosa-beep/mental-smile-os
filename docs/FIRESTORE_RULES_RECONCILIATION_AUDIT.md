# FIRESTORE RULES RECONCILIATION AUDIT

## Mental Smile - Service Ecosystem Rules Alignment

هذا التقرير لا يعدل الرولز.

هذا التقرير فقط يحدد الفجوة وخطة التحول.

---

## 1. Executive Summary

Mental Smile تتحول من Commission-Based Booking Flow إلى Service Ecosystem Platform. معنى ذلك أن request lifecycle الجديد لا يجب أن يحتوي على:

- payment proof.
- payment confirmation.
- commission.
- payout.
- accounting.
- settlement.
- financial archive داخل request lifecycle.

فحص `firestore.rules` يوضح أن rules الحالية ما زالت تسمح بجزء من النموذج القديم، خصوصا داخل:

```text
match /booking_requests/{requestId}
```

أهم نتيجة:

- العميل/صاحب الطلب مسموح له بتحديث payment proof fields داخل `booking_requests`.
- admin مسموح له بتحديث أي field داخل `booking_requests` بدون allowlist خاص، وبالتالي كل financial legacy fields يمكن كتابتها بواسطة admin.
- باقي collections مثل `support_requests`, `chat_threads`, `chat_escalations`, `sessionRatings`, `resources`, و `external_follow_up_*` أقرب للنموذج الجديد ويجب الحفاظ عليها.
- لا توجد rule منفصلة واضحة لـ `library`; الموجود فعليا هو `resources`.
- لا توجد financial collection منفصلة في rules؛ الخطر المالي متركز داخل `booking_requests` و admin authority.

القرار الآمن:

لا يتم تعديل `firestore.rules` الآن. أول خطوة هي freeze audit ثم tests، لأن أي تعديل سريع قد يكسر client booking flow أو admin flows أو data القديمة.

---

## 2. Current Rules Reality

### Core Authority Doctrine

الرولز تبدأ بعقيدة مهمة:

```text
Firestore authorization depends on custom claims, not UI role documents.
```

المعنى:

- `isAdmin()` يعتمد على `request.auth.token.role == 'admin'`.
- `isClient()` يعتمد على custom claim `client`.
- `isClinician()` يعتمد على custom claim `clinician`.
- `isCenter()` يعتمد على custom claim `center`.
- UI role documents ليست مصدر authority.

هذا متوافق مع Service Ecosystem بشرط عدم استخدام admin authority الواسع لتشغيل finance lifecycle قديم.

### Account Collections

| Collection | Current rule | Target fit | Classification |
|---|---|---|---|
| `clients` | admin أو owner يقرأ، client create/update محدود | مناسب لحساب مجاني ودعم العميل | KEEP |
| `clinicians` | public-ish read لو approved/active، self registration قبل approval، admin authority | مناسب للظهور والثقة | KEEP |
| `centers` | public-ish read لو approved/active، self registration قبل approval، admin authority | مناسب للظهور والثقة | KEEP |
| `admins` | read/write admin فقط | مناسب للسيطرة الداخلية | KEEP / NEEDS STRICT GOVERNANCE |

### Service / Support Collections

| Collection | Current rule | Target fit | Classification |
|---|---|---|---|
| `support_requests` | user creates own support request، admin updates | أساسي للنموذج الجديد | KEEP |
| `chat_threads` | owner/admin/assigned clinician read، owner/admin update | مناسب للدعم والتواصل | KEEP |
| `chat_threads/{threadId}/messages` | participants/admin read، أي signed-in create لو thread موجود | يحتاج test وحدود أقوى لاحقا | KEEP / NEEDS OWNER DECISION |
| `chat_escalations` | admin أو assigned clinician read، signed-in create، admin update | مناسب للشكاوى/escalations | KEEP |
| `chat_escalations/{id}/reports` | admin/assigned clinician read، signed-in create | مناسب لكن يحتاج validation لاحقا | KEEP / NEEDS OWNER DECISION |
| `sessionRatings` | participant/admin read، reviewer create/update own rating | أساسي للتقييمات | KEEP |
| `resources` | signed-in read، admin write | مناسب للمكتبة | KEEP |
| `external_follow_up_*` | admin read/write only | مناسب للمتابعة الخارجية | KEEP / FREEZE UNTIL GOVERNANCE |

### System / Analytics / Admin Collections

| Collection | Current rule | Target fit | Classification |
|---|---|---|---|
| `system_health` | admin read، client write denied | مناسب للرصد | KEEP |
| `system_alerts` | admin read، writes denied للclient/app | مناسب للتنبيهات التشغيلية | KEEP |
| `analytics_summaries` | admin read، writes denied للclient/app | مناسب للتحليلات | KEEP |
| `system_domains` | admin read/write | مناسب لكن authority واسع | KEEP / NEEDS GOVERNANCE |
| `ai_policies` | admin read/write | مناسب لحوكمة AI | KEEP |
| `debug` | read/write false | مناسب | KEEP |
| catch-all | read/write false | مناسب | KEEP |

---

## 3. Booking Requests Rules Inventory

### Current Match

```text
match /booking_requests/{requestId} {
  allow get, list: if isAdmin() || isOwnBooking();
  allow create: if bookingCreateValid() || isAdmin();
  allow update: if isAdmin() || bookingUserUpdateValid();
  allow delete: if false;
}
```

### Read Access

| Actor | Access | Notes | Classification |
|---|---|---|---|
| Admin | get/list | كامل | KEEP مع governance |
| Client owner | get/list | لو `clientId == uid()` | KEEP |
| Clinician owner/assigned | get/list | `clinicianId`, `clinicianUid`, `assignedClinicianId`, `assignedClinicianUid` | KEEP |
| Center owner | get/list | `centerId == uid()` | KEEP |
| Other users | denied | مناسب | KEEP |

### Create Access

`bookingCreateValid()` يسمح لأي signed-in user بإنشاء request لو أحد هذه الحقول يساوي uid:

- `clientId`
- `clinicianId`
- `clinicianUid`
- `centerId`

Classification:

- KEEP مبدئيا، لأنه يدعم service request.
- RENAME LATER لأن الاسم `booking` لم يعد أدق اسم للنموذج الجديد.
- NEEDS OWNER DECISION: هل يسمح للأخصائي/المركز بإنشاء request لنفسه، أم client-only مع provider response؟

### Update Access

المشكلة الرئيسية:

```text
allow update: if isAdmin() || bookingUserUpdateValid();
```

ده معناه:

- admin يستطيع تعديل أي field في `booking_requests`.
- صاحب الطلب يستطيع تعديل fields محددة في allowlist.

### bookingUserUpdateValid Allowlist

الـ user allowlist حاليا يسمح بـ:

- notes/thread/contract.
- payment proof fields.
- center availability.
- arrival confirmation.
- review submission fields.
- session/review status.
- final review percentage.
- updatedAt.

تصنيف عام:

- service/support/review fields: KEEP.
- payment fields: FREEZE ثم REMOVE LATER.
- session status user writes: QUARANTINE لأن lifecycle الجديد يحتاج validation أدق.

### Legacy Blocked Collection

```text
match /bookingRequests/{requestId} {
  allow read, write: if false;
}
```

Classification:

- KEEP.
- هذا يمنع legacy camelCase collection من الاستخدام.
- لا يجب لمسه الآن.

---

## 4. Financial Fields Rules Exposure

### Direct User Write Exposure

داخل `bookingUserUpdateValid()`، هذه الحقول المالية مسموح بها مباشرة لصاحب الطلب:

| Field | Exposure | Current risk | Classification |
|---|---|---:|---|
| `paymentStatus` | user can update if own booking | يمكن للعميل/المالك دفع lifecycle المالي | QUARANTINE / REMOVE LATER |
| `payment_confirmed` | user can update if own booking | خطر authority mismatch لأن confirmation يجب ألا تكون user-controlled | QUARANTINE / REMOVE LATER |
| `paymentReceiptFileName` | user can update | يسمح payment proof داخل request | FREEZE / REMOVE LATER |
| `paymentReceiptUrl` | user can update | يسمح payment proof URL داخل request | FREEZE / REMOVE LATER |
| `paymentSubmittedAt` | user can update | يسمح timestamp مالي من client | FREEZE / REMOVE LATER |
| `paymentClientNote` | user can update | يسمح note مالية داخل lifecycle | FREEZE / REMOVE LATER |

### Admin Broad Write Exposure

لأن `isAdmin()` يسمح update كامل بدون affectedKeys allowlist، كل الحقول التالية قابلة للكتابة بواسطة admin لو موجودة في التطبيق:

| Field | Rule exposure | Target model status | Classification |
|---|---|---|---|
| `paymentApprovedAt` | admin unrestricted update | لا يجب أن يكون في active request lifecycle | FREEZE / REMOVE LATER |
| `paymentRejectedAt` | admin unrestricted update | لا يجب أن يكون في active request lifecycle | FREEZE / REMOVE LATER |
| `paymentApprovedBy` | admin unrestricted update | لا يجب أن يكون في active request lifecycle | FREEZE / REMOVE LATER |
| `payoutStatus` | admin unrestricted update | payout خارج مسؤولية المنصة | QUARANTINE / REMOVE LATER |
| `payoutTransferredAt` | admin unrestricted update | payout خارج مسؤولية المنصة | QUARANTINE / REMOVE LATER |
| `payoutTransferredBy` | admin unrestricted update | payout خارج مسؤولية المنصة | QUARANTINE / REMOVE LATER |
| `accountingReviewStatus` | admin unrestricted update | accounting لا يكون جزء من request | QUARANTINE / REMOVE LATER |
| `grossClientPaidAmount` | admin unrestricted update | المنصة لا تدير دفع الجلسة | QUARANTINE / REMOVE LATER |
| `appCommissionPercent` | admin unrestricted update | ضد النموذج الجديد | REMOVE LATER |
| `appCommissionAmount` | admin unrestricted update | ضد النموذج الجديد | REMOVE LATER |
| `netAmountDueToCenter` | admin unrestricted update | settlement/payout خارج المنصة | REMOVE LATER |
| `accountingReviewNotes` | admin unrestricted update | legacy-only إن بقي | FREEZE / REMOVE LATER |
| `accountingConfirmedAt` | admin unrestricted update | legacy-only | FREEZE / REMOVE LATER |
| `accountingConfirmedBy` | admin unrestricted update | legacy-only | FREEZE / REMOVE LATER |
| `paymentBreakdownText` | admin unrestricted update | quote مالي داخل request | QUARANTINE / REMOVE LATER |
| `paymentQuotePreparedAt` | admin unrestricted update | quote مالي داخل request | QUARANTINE / REMOVE LATER |
| `paymentQuotePreparedBy` | admin unrestricted update | quote مالي داخل request | QUARANTINE / REMOVE LATER |
| `stayTaxPercent` | admin unrestricted update | tax داخل payment quote | QUARANTINE / REMOVE LATER |
| `stayTaxAmount` | admin unrestricted update | tax داخل payment quote | QUARANTINE / REMOVE LATER |
| `stayTotalAmount` | admin unrestricted update | total payment amount | QUARANTINE / REMOVE LATER |

### Important Distinction

الرولز لا تذكر كل financial fields صراحة. لكنها تسمح بها بطريقة غير مباشرة من خلال:

```text
allow update: if isAdmin()
```

هذا لا يعني أن admin authority خطأ في حد ذاته، لكنه يعني أن business model الجديد يحتاج admin update allowlist أو service-specific validation لاحقا.

---

## 5. Service Ecosystem Target Rules

### Target Principle

```text
Service Request does not carry payment lifecycle.
```

### Target Booking / Service Request Rules

الـ request الجديد يجب أن يسمح بـ:

- إنشاء طلب خدمة.
- رد provider أو center.
- coordination.
- meeting/session scheduling metadata.
- completion.
- review/comment.
- complaint link أو complaint status.

ولا يسمح بـ:

- client payment proof writes.
- payment confirmation.
- commission calculation.
- payout confirmation.
- accounting review داخل request.
- settlement data.

### Suggested Lifecycle Fields

بدل financial statuses، lifecycle fields المقترحة:

| Field | Suggested values | Purpose |
|---|---|---|
| `requestStatus` | `submitted`, `provider_review`, `provider_accepted`, `coordination_pending`, `meeting_scheduled`, `completed`, `reviewed`, `complaint_opened`, `cancelled` | الحالة الرئيسية للطلب |
| `providerResponseStatus` | `pending`, `accepted`, `declined`, `needs_more_info` | رد provider |
| `coordinationStatus` | `not_started`, `pending`, `scheduled`, `reschedule_requested`, `completed` | تنسيق الموعد |
| `meetingMode` | `online`, `in_person`, `phone`, `external` | طريقة الخدمة |
| `meetingLinkType` | `zoom`, `google_meet`, `phone`, `external_link`, `none` | نوع الرابط |
| `reviewStatus` | `not_started`, `client_submitted`, `provider_submitted`, `completed` | تقييمات وتعليقات |
| `complaintStatus` | `none`, `opened`, `under_review`, `resolved`, `closed` | الشكاوى |
| `supportStatus` | `none`, `requested`, `active`, `closed` | الدعم |
| `displayedProviderPriceSnapshot` | object/string | للشفافية فقط، ليس للتحصيل |
| `platformPaymentInvolvement` | `none` | حقل وضوح قانوني اختياري |

### Price Transparency Rule

السعر يمكن أن يبقى للعرض:

- `sessionPriceText` في clinician profile.
- center pricing/services.
- price snapshot لو Owner وافق.

لكن لا يجب أن يتحول إلى:

- payment due.
- payment proof required.
- platform confirmation.
- commission base.
- payout base.

---

## 6. Keep / Freeze / Quarantine / Remove Later Map

### KEEP

Rules يجب الحفاظ عليها لأنها تخدم النموذج الجديد:

- `clients` create/read/update المحدود.
- `clinicians` approved active read.
- `centers` approved active read.
- `support_requests`.
- `chat_threads`.
- `chat_escalations`.
- `sessionRatings`.
- `resources`.
- `external_follow_up_registry`.
- `external_follow_up_message_templates`.
- `external_follow_up_campaigns`.
- `system_health`, `system_alerts`, `analytics_summaries`.
- catch-all deny.
- disabled `bookingRequests`.

### FREEZE

Rules يجب عدم توسيعها:

- `booking_requests` user update allowlist.
- admin broad update داخل `booking_requests`.
- `system_domains` admin write.
- `ai_policies` admin write.
- external follow-up admin-only writes إلى حين governance تفصيلي.

### QUARANTINE

Rules أو rule effects تحتاج عزل قبل التغيير:

- `paymentStatus` user writes.
- `payment_confirmed` user writes.
- `paymentReceiptFileName` user writes.
- `paymentReceiptUrl` user writes.
- `paymentSubmittedAt` user writes.
- `paymentClientNote` user writes.
- admin unrestricted write لكل financial legacy fields.
- user ability to write `sessionStatus` و `reviewStatus` داخل request بدون transition validation.

### REMOVE LATER

بعد route/import/test verification:

- client write access لـ payment proof fields.
- active admin writes لـ payment approval/rejection.
- active admin writes لـ payout/accounting/commission fields.
- any request lifecycle field that implies platform-managed money.

### RENAME LATER

- `booking_requests` إلى `service_requests` فقط بعد migration plan.
- `bookingUserUpdateValid` إلى service request update validation.
- `paymentStatus` لو بقي تاريخيا: `legacyPaymentStatus`.
- `payoutStatus` لو بقي تاريخيا: `legacyPayoutStatus`.
- price fields إلى provider/service price display language.

### NEEDS OWNER DECISION

- هل `Service Request` هو الاسم الرسمي؟
- هل السعر mandatory أم optional؟
- هل platform تسمح بذكر price snapshot داخل request؟
- هل admin يحتفظ برؤية legacy finance؟
- مدة الاحتفاظ بالfinancial legacy data.
- هل complaint flow يغطي النزاعات المالية كبلاغ سلوك فقط أم لا يغطيها تماما؟

---

## 7. Permission-Denied Risk Map

لو أزلنا UI payment قبل تعديل rules، المخاطر ليست فقط permission-denied. في الغالب سيحدث العكس: rules ستظل تسمح بشيء لم يعد UI يستخدمه. لكن permission-denied يظهر في السيناريوهات الآتية:

| Scenario | Expected risk | Why |
|---|---|---|
| إزالة payment fields من UI لكن code قديم ما زال يكتبها في hidden path | Low/Medium permission risk الآن | rules ما زالت تسمح للowner بستة payment fields |
| إزالة fields من allowlist قبل إزالة `ClientPaymentProofPage` | High permission-denied | submit proof سيحاول كتابة fields ممنوعة |
| إزالة `payment_confirmed` قبل تعديل clinician/session gates | High runtime/permission risk | أجزاء من flow قد تكتب أو تقرأ field كشرط تشغيل |
| منع admin من financial fields قبل تعديل admin pages | High permission-denied | `/admin/payments` وadmin adapters ستفشل updates |
| تغيير statuses من `awaiting_payment` قبل تعديل tests/UI | Medium/High | queries/transitions قد لا تطابق lifecycle |
| حذف payment route بدون إزالة dashboard action | UI navigation failure | route missing وليس Firestore permission فقط |
| منع write لـ `sessionStatus` قبل lifecycle جديد | Medium | user review/session completion paths قد تفشل |

الخلاصة:

لا يجب تضييق rules قبل إغلاق UI/service writes القديمة أو وضع feature flag/legacy path واضح.

---

## 8. Authority Mismatch Risk Map

لو فضلنا rules المالية موجودة بعد تغيير business model، المخاطر أكبر على الحوكمة والثقة:

| Risk | Description | Severity |
|---|---|---:|
| Client can still submit payment proof | حتى لو UI اختفى، أي client app path قد يكتب proof fields | Critical |
| Client can write `payment_confirmed` | owner write allowlist يسمح بحقل confirmation، وهذا ضد target authority | Critical |
| Admin can still confirm payment | broad admin update يسمح بإحياء lifecycle القديم | Critical |
| Admin can still confirm payout | rules لا تمنع payout fields | Critical |
| Commission fields remain writable | ضد تصريح أن المنصة ليست commission platform | Critical |
| Accounting inside request remains possible | يعيد platform إلى financial intermediary pattern | High |
| Legal wording mismatch | rules تسمح بسلوك مالي بينما المنتج يعلن عدم التدخل المالي | High |
| Data leakage through own booking reads | أصحاب الطلب يرون legacy financial fields داخل docs | Medium/High |
| Reporting drift | analytics/admin reports قد تستمر في حساب finance stats | Medium |
| Support confusion | complaints قد تتحول لنزاعات مالية لأن البيانات المالية ظاهرة | Medium |

الخلاصة:

ترك rules كما هي للأبد غير مناسب. لكنها يجب أن تتغير بعد tests وتعديل runtime، وليس قبله.

---

## 9. Proposed Rules Transition Phases

### Phase 0 - No Change / Audit Only

الحالة الحالية لهذا التقرير.

Actions:

- لا تعديل في `firestore.rules`.
- لا تعديل في `storage.rules`.
- لا تعديل collections.
- توثيق كل exposure.
- كتابة tests مقترحة.

### Phase 1 - Freeze Financial Writes

هدف المرحلة:

- منع أي توسع جديد في payment/payout/accounting داخل request.

Rules direction لاحقا:

- إبقاء rules كما هي مؤقتا.
- إضافة policy داخل docs/development: ممنوع إضافة financial fields جديدة في `booking_requests`.
- أي writes مالية تعتبر legacy-only.

### Phase 2 - Make Legacy Financial Fields Admin-Read / No New User Writes

هدف المرحلة:

- إزالة user write access لحقول payment proof.

Rules direction لاحقا:

- remove من `bookingUserUpdateValid()`:
  - `paymentStatus`
  - `payment_confirmed`
  - `paymentReceiptFileName`
  - `paymentReceiptUrl`
  - `paymentSubmittedAt`
  - `paymentClientNote`

شرط قبل التنفيذ:

- إيقاف `/client/payment-proof`.
- إزالة أو تعطيل أي client write path.
- test يثبت أن client لا يستطيع كتابة payment fields.

### Phase 3 - Remove Client Payment Proof Writes

هدف المرحلة:

- user cannot create or update payment proof in service request.

Rules direction:

- client/owner updates تقتصر على:
  - note.
  - thread coordination.
  - review fields.
  - complaint/support fields.
  - allowed lifecycle fields الجديدة.

### Phase 4 - Introduce Service Request Lifecycle Fields

هدف المرحلة:

- replace payment status dependency.

Rules direction:

- allowlist جديدة مثل:
  - `requestStatus`
  - `providerResponseStatus`
  - `coordinationStatus`
  - `meetingMode`
  - `meetingLinkType`
  - `reviewStatus`
  - `complaintStatus`
  - `supportStatus`
  - `displayedProviderPriceSnapshot`
  - `updatedAt`

Needs validation:

- client لا يقدر يفرض `provider_accepted`.
- provider لا يقدر يكتب review باسم client.
- admin يقدر يتدخل للsupport/escalation فقط.

### Phase 5 - Legacy Burial After Route/Import/Test Verification

هدف المرحلة:

- دفن financial legacy safely.

شروط:

- لا route active يعتمد على payment.
- لا adapter active يكتب payment/payout/accounting.
- لا tests قديمة غير مصنفة legacy.
- لا reports critical تحتاج financial fields.
- Owner وافق على retention/burial.

Rules direction:

- منع writes لكل financial legacy fields.
- admin read-only أو archive-only حسب القرار.
- ربما move إلى legacy collection فقط لو migration معتمدة.

---

## 10. Required Tests Before Any Rules Change

### Tests Before Removing Client Payment Writes

1. client cannot update `paymentStatus`.
2. client cannot update `payment_confirmed`.
3. client cannot update `paymentReceiptFileName`.
4. client cannot update `paymentReceiptUrl`.
5. client cannot update `paymentSubmittedAt`.
6. client cannot update `paymentClientNote`.
7. client can still update allowed service request note/coordination fields.
8. client can still submit review fields allowed by target model.

### Tests Before Restricting Admin Financial Writes

1. admin can read legacy financial fields.
2. admin cannot create new payment confirmation after freeze phase.
3. admin cannot create payout confirmation after freeze phase.
4. admin can still update trust/support/admin operational fields.
5. admin can still resolve complaint/support escalation.

### Tests For New Service Request Lifecycle

1. client can create service request with `requestStatus = submitted`.
2. clinician/center can read assigned/owned service request.
3. provider can set `providerResponseStatus = accepted` only for own request.
4. client cannot set provider accepted status.
5. provider cannot submit client review.
6. client can open complaint linked to request.
7. support/admin can update complaint/support status.
8. `displayedProviderPriceSnapshot` cannot be used as payment confirmation.
9. request can move to `meeting_scheduled` through allowed actor only.
10. request can move to `completed` without any payment fields.

### Tests For Collections That Must Stay Working

1. `support_requests` create by signed-in owner still works.
2. `chat_threads` owner/assigned clinician read still works.
3. `chat_escalations` create by signed-in user still works.
4. `sessionRatings` create/update by reviewer still works.
5. `resources` read by signed-in user still works.
6. `resources` write by admin still works.
7. `external_follow_up_*` admin-only access still works.
8. catch-all deny still denies unknown collections.

### First Rules Not To Touch Now

- `clients`.
- `clinicians`.
- `centers`.
- `support_requests`.
- `chat_threads`.
- `chat_escalations`.
- `sessionRatings`.
- `resources`.
- `external_follow_up_*`.
- catch-all deny.
- disabled `bookingRequests`.

### First Rules To Freeze

- `bookingUserUpdateValid()` payment fields.
- admin broad update on `booking_requests`.
- any future expansion of `paymentStatus`.
- any future expansion of `payoutStatus`.
- any future accounting fields inside request docs.

### First Rules That Need Redesign

- `booking_requests` update validation.
- actor-specific lifecycle transitions.
- provider response writes.
- complaint/support fields inside or linked to request.
- price display snapshot validation.
- admin authority boundaries for service requests.

### Needs Owner Decision

- official collection naming: keep `booking_requests` or migrate later to `service_requests`.
- official status names.
- whether price snapshot exists in request.
- whether old financial fields remain visible to users.
- whether admin keeps read-only financial archive.
- whether financial complaint is accepted as platform complaint or redirected outside.
- retention period for legacy financial data.

---

## 11. Final Verdict

Current rules reality:

- Firestore rules are generally conservative and custom-claims based.
- Most support/trust/library/chat/rating collections align with Service Ecosystem.
- The main mismatch is `booking_requests`.
- `booking_requests` currently allows owner writes to payment proof fields.
- Admin can write all financial legacy fields because admin update is unrestricted.

Service Ecosystem gap:

- Service Request should not contain payment proof.
- Client should not submit payment proof.
- Admin should not confirm payment.
- Admin should not confirm payout.
- Accounting/commission should not live inside request lifecycle.

Safe direction:

```text
Audit only
-> Freeze financial writes
-> Remove user payment writes
-> Add service lifecycle fields
-> Restrict admin financial writes
-> Legacy burial after verification
```

Immediate recommendation:

- Do not edit `firestore.rules` yet.
- Write rules tests first.
- Freeze financial field expansion immediately.
- Treat payment/payout/accounting inside `booking_requests` as legacy.
- Keep support, complaints, ratings, resources, trust, and follow-up rules active.

هذا التقرير لا يعدل الرولز.

هذا التقرير فقط يحدد الفجوة وخطة التحول.
