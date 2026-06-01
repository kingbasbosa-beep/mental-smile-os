# WEB-P4 Firebase Hosting Deployment Plan

## 1. Executive Summary

Firebase Hosting مناسب كأول اختيار لنشر Mental Smile Web Portal Phase 1 لأنه بسيط، سريع، وملائم لتطبيق Flutter Web ثابت بدون Backend إلزامي. في المرحلة الحالية الـ Portal يعمل كواجهة Web Sovereign Intake تعتمد على صفحات ثابتة، routing داخل Flutter، وGmail-first intake drafts، لذلك لا نحتاج Cloud Functions أو Firestore أو Auth أو أي workflow engine قبل أول نشر.

الهدف من هذه الخطة هو تجهيز مسار نشر آمن ومحدود: build محلي لـ Flutter Web، ثم نشر output على Firebase Hosting، مع اختبار routes والـ Gmail draft links قبل أي ربط domain.

## 2. Current Portal Scope

النطاق الحالي للـ Portal يشمل:

* Home
* About
* Library integration
* Provider intake route
* Center intake route
* Service Request
* Package Request
* Contact
* Gmail-first intake drafts
* Portal ↔ App navigation

هذا النطاق يظل Phase 1 Portal Scope فقط. لا يوجد Backend submission، ولا Firestore intake records، ولا Auth gate للـ Portal.

## 3. Hosting Strategy

الاستراتيجية المقترحة:

* Firebase Hosting كاستضافة أولى للـ Portal.
* Namecheap كـ domain registrar فقط في البداية.
* Cloudflare Pages يبقى بديل لاحق لو احتجنا فصل hosting أو CDN strategy مختلفة.

Firebase Hosting يكفي الآن لأن الـ Portal عبارة عن Flutter Web static build، ومرحلة Year One تعتمد على email/manual review بدل backend workflows.

## 4. Build Output Strategy

Flutter Web يحتاج build قبل النشر:

```powershell
flutter build web
```

Firebase Hosting يخدم محتوى build output الناتج من Flutter Web. غالبًا مجلد النشر يكون:

```text
build/web
```

يجب التأكد قبل deploy أن Firebase Hosting public directory يشير إلى build output الصحيح، وليس root المشروع أو مجلد قديم.

## 5. Routing Strategy

بما أن التطبيق يستخدم Flutter hash routing، فالروابط المتوقعة بعد النشر ستظهر بصيغة:

```text
/#/...
```

يجب اختبار routes التالية يدويًا قبل أول deploy وبعده:

* `/#/`
* `/#/library`
* `/#/register/provider`
* `/#/register/center`
* `/#/request/service`
* `/#/request/package`
* `/#/contact`
* `/#/splash`

Hash routing يقلل مخاطر server rewrites مقارنة بـ path routing، لكن يجب مع ذلك ضبط Firebase Hosting لخدمة Flutter Web build بشكل صحيح.

## 6. Firebase Hosting Risks

أهم المخاطر:

* wrong public directory: اختيار مجلد غير `build/web`.
* missing rewrite: لو تم استخدام path routing مستقبلًا قد تحتاج rewrite إلى `index.html`.
* hash vs path routing: يجب توثيق أن الروابط الحالية hash-based.
* deploying wrong build: نشر build قديم أو build من branch غير صحيح.
* exposing unfinished routes: بعض routes قد تكون موجودة لكن ليست جاهزة تجاريًا.
* Firebase project mismatch: deploy على project خاطئ.
* domain DNS misconfiguration: ربط domain من Namecheap قبل اختبار Firebase default URL قد يصعب التشخيص.

## 7. Pre-Deploy Checklist

قبل أي deploy فعلي:

* `flutter analyze` clean enough.
* manual route QA passed.
* Gmail drafts open correctly.
* splash ↔ portal navigation works.
* library return route works.
* registration routes open.
* no Firestore/rules changes required.
* confirm Firebase project.
* confirm hosting target.
* confirm build output directory.
* confirm no unintended backend/Auth dependency in Portal flow.

## 8. Deployment Steps - Proposed Only

الأوامر التالية مقترحة فقط ولا يتم تشغيلها ضمن هذه الخطة:

```powershell
flutter build web
firebase login
firebase use <project-id>
firebase init hosting
firebase deploy --only hosting
```

ملاحظات:

* لا يتم تشغيل deploy الآن.
* لا يتم تعديل Firebase config الآن.
* لا يتم إنشاء hosting target الآن.
* قبل `firebase init hosting` يجب تحديد project وpublic directory بعناية.
* في حالة وجود Firebase config سابق، يجب مراجعته بدل إعادة تهيئته عشوائيًا.

## 9. Domain Plan

المرحلة الأولى:

* استخدام Firebase default hosting URL.
* اختبار كل routes والـ Gmail drafts والـ Portal ↔ App bridge.

المرحلة الثانية:

* connect custom domain من Namecheap.
* لا يتم تعديل DNS الآن.
* ربط الدومين يتم فقط بعد نجاح أول deploy على Firebase default URL.

هذا يقلل المخاطر لأن مشاكل build/hosting يتم عزلها عن مشاكل DNS/domain.

## 10. Rollback Plan

خطة الرجوع:

* استخدام Firebase Hosting release rollback عند الحاجة.
* restore previous deploy من Firebase Hosting console.
* إنشاء git tag قبل أول deploy فعلي.
* الاحتفاظ بسجل واضح للـ build/commit الذي تم نشره.

لا يجب تنفيذ تغييرات كبيرة في runtime أو routes في نفس دفعة أول deploy.

## 11. First Deploy Recommendation

نعم، التوصية هي البدء بـ Firebase default URL قبل ربط الدومين.

السبب:

* اختبار hosting مستقل عن DNS.
* تقليل وقت التشخيص.
* التأكد من Flutter hash routing.
* التأكد من Gmail draft links.
* التأكد من أن `/splash` وPortal navigation يعملان بعد build.

بعد نجاح Firebase default URL يمكن الانتقال إلى custom domain من Namecheap.

## 12. Final Verdict

المشروع جاهز لخطة deploy أولية بعد QA والكوميت، بشرط عدم تنفيذ deploy قبل:

* نجاح manual QA.
* تأكيد Firebase project.
* تأكيد hosting target.
* تأكيد build output.
* التأكد أن Portal Phase 1 لا يعتمد على Firestore/Auth/Backend.

Firebase Hosting هو المسار الأنسب لأول نشر للـ Web Portal، مع إبقاء Namecheap للدومين وCloudflare Pages كبديل مستقبلي فقط.

هذا Plan لا ينفذ deploy.
هذا Plan لا يغير Firebase config.
هذا Plan لا يغير Runtime.
هذا Plan لا يغير Rules.
