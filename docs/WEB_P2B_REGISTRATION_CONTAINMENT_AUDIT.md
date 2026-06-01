# WEB_P2B_REGISTRATION_CONTAINMENT_AUDIT

## 1. Executive Summary

هذا الـ Audit يقيّم هل يمكن ربط Portal routes:

* `/register/provider`
* `/register/center`

بالـ web registration flows الحالية:

* `/web/clinician/register`
* `/web/center/register`

بدون كسر العقيدة:

```text
Web = Sovereign Intake
App = Operational Runtime
```

الحكم المختصر:

```text
Do not link directly now.

Link after copy containment + owner approval + rules/auth review.
```

السبب أن التسجيلات الحالية ليست مجرد intake placeholders. هي flows نشطة تعتمد على Firebase Auth وFirestore وتقوم بإنشاء user وكتابة بيانات داخل `clinicians` و`centers`.

---

## 2. هل التسجيل الحالي Registration أم Intake؟

### Provider Flow

التسجيل الحالي أقرب إلى:

```text
Active Firebase-backed Registration Flow
```

وليس:

```text
Email-driven Sovereign Intake
```

لأنه ينشئ auth user ويكتب document داخل `clinicians` ثم ينتقل إلى خطوات profile/sessions/documents.

### Center Flow

التسجيل الحالي أيضًا أقرب إلى:

```text
Active Firebase-backed Registration Flow
```

وليس مجرد intake.

لأنه ينشئ auth user ويكتب document داخل `centers` ثم ينتقل إلى profile/media/pricing/documents.

### Constitutional Meaning

يمكن تحويل اللغة لاحقًا إلى Intake/Review Request، لكن السلوك الحالي له side effects حقيقية، لذلك لا يجب تقديمه للـ Portal كأنه مجرد طلب مراجعة بسيط بدون containment.

---

## 3. Auth Behavior

### Provider Registration

Auth behavior المتوقع من flow الحالي:

* ينشئ user باستخدام Firebase Auth.
* يعتمد على `FirebaseAuth.instance.currentUser` في الخطوات التالية.
* قد يستخدم `signOut` قبل أو أثناء إعادة توجيه المستخدم.
* يعتمد على استمرار session أثناء خطوات profile/sessions/documents.

Risk:

لو فشل Firestore بعد إنشاء user، قد يظهر orphan auth user أو تسجيل غير مكتمل.

### Center Registration

Auth behavior المتوقع:

* ينشئ user باستخدام Firebase Auth.
* يعتمد على `currentUser`.
* يستخدم `signOut` في مسارات معينة.
* يعتمد على session لاستكمال profile/media/pricing/documents.

Risk:

نفس مخاطر incomplete registration وorphan auth user وpermission mismatch.

---

## 4. Firestore Behavior

### Provider Collections

المجموعة الأساسية:

```text
clinicians
```

Writes/updates:

* create/set clinician document عند التسجيل.
* update profile fields.
* update session/service delivery fields.
* update documents submitted flags/references.

Sensitive fields likely involved:

* email.
* phone.
* name.
* specialty.
* license/certificate references.
* service/session preferences.
* documents submitted state.

### Center Collections

المجموعة الأساسية:

```text
centers
```

Writes/updates:

* create/set center document عند التسجيل.
* update profile fields.
* update media fields.
* update pricing/services fields.
* update documents submitted flags/references.

Sensitive fields likely involved:

* center name.
* owner/manager data.
* phone/email.
* address/city.
* license reference.
* service categories.
* social/media links.
* pricing/service disclosures.
* documents submitted state.

### Firestore Conclusion

هذه flows تعتمد على Firestore writes/updates، لذلك ربطها بالـ Portal ليس مجرد navigation. هو تفعيل intake فعلي يحتاج rules review وcopy containment.

---

## 5. Route Behavior

### Provider Sequence

Current route sequence:

```text
/web/clinician/register
↓
/web/clinician/profile
↓
/web/clinician/sessions
↓
/web/clinician/documents
↓
/web/register/success
```

Success route:

```text
/web/register/success
```

Portal return:

غير واضح كـ Portal-first behavior حاليًا. يحتاج containment لاحقًا حتى يعرف المستخدم كيف يرجع للبوابة بدل App shell.

### Center Sequence

Current route sequence:

```text
/web/center/register
↓
/web/center/profile
↓
/web/center/media
↓
/web/center/pricing
↓
/web/center/documents
↓
/web/register/success
```

Success route:

```text
/web/register/success
```

Portal return:

غير واضح كـ Portal-first behavior حاليًا. يحتاج copy/navigation review قبل الربط.

---

## 6. Portal Suitability

### Provider

هل يصلح direct link؟

```text
Not now.
```

يحتاج:

* warning/copy containment.
* approval disclaimer.
* Auth/Firestore rules review.
* Owner approval.

### Center

هل يصلح direct link؟

```text
Not now.
```

يحتاج:

* warning/copy containment.
* approval disclaimer.
* pricing/documents copy containment.
* Auth/Firestore rules review.
* Owner approval.

---

## 7. Required Containment Before Linking

قبل ربط Portal CTAs بالتسجيلات الحالية:

### Copy Containment

تحويل اللغة:

```text
Registration
↓
Intake / Review Request
```

### Required Disclaimers

يجب توضيح:

* إرسال البيانات لا يعني قبولًا تلقائيًا.
* إنشاء حساب لا يعني تفعيل provider/center.
* التسجيل يخضع للمراجعة.
* لا يوجد promise بالحجز.
* لا يوجد payment promise.
* لا يوجد approval guarantee.
* البيانات والتراخيص المقدمة مسؤولية مقدم الطلب.

### Flow Containment

يجب التأكد من:

* ماذا يحدث لو فشل Firestore بعد Auth.
* ماذا يحدث لو فقد المستخدم session.
* ماذا يحدث لو ترك flow في المنتصف.
* success page تعود للـ Portal أو تشرح الخطوة التالية.

---

## 8. Risks

### Account Creation Side Effects

الـ Portal CTA قد ينشئ auth user، وهذا أكبر من مجرد intake.

### Incomplete Registration

المستخدم قد يبدأ flow ولا يكمله، فتظهر بيانات ناقصة.

### Permission Denied

Firestore rules قد تمنع update في خطوة لاحقة.

### Orphan Auth User

قد ينشأ user بدون document مكتمل.

### User Expectation Mismatch

المستخدم قد يعتقد أنه تم قبوله أو تفعيله بمجرد التسجيل.

### Runtime Coupling

ربط Portal بتسجيل Firebase-backed يجعل Portal يعتمد على app auth/data lifecycle مبكرًا.

---

## 9. Safe Integration Decision

### Provider

Decision:

```text
Link After Copy Containment
```

ليس Link Now.

ليس Keep Placeholder للأبد.

السبب:

الflow قابل لإعادة الاستخدام، لكنه يحتاج containment قبل عرضه كبوابة سيادية.

### Center

Decision:

```text
Link After Copy Containment
```

السبب:

الflow غني ومفيد، لكنه يتضمن media/pricing/documents وFirestore writes، ويحتاج وضوح أكبر حول intake/review والقبول.

---

## 10. Final Recommendation

### Provider Recommendation

لا تربط `/register/provider` الآن مباشرة بـ `/web/clinician/register`.

الخطوة التالية الآمنة:

* Copy containment package.
* Success page containment.
* Auth/Firestore failure behavior review.
* Owner approval.

بعد ذلك يمكن ربط:

```text
/register/provider
↓
/web/clinician/register
```

### Center Recommendation

لا تربط `/register/center` الآن مباشرة بـ `/web/center/register`.

الخطوة التالية الآمنة:

* Copy containment package.
* Pricing/documents language review.
* Success page containment.
* Auth/Firestore failure behavior review.
* Owner approval.

بعد ذلك يمكن ربط:

```text
/register/center
↓
/web/center/register
```

### Final Verdict

```text
Provider and Center registration flows are reusable but not yet portal-safe as direct links.

They should be linked only after containment, disclaimers, and owner approval.
```

هذا Audit لا يغير Runtime.

هذا Audit لا يغير Rules.

هذا Audit لا يربط التسجيلات بعد.
