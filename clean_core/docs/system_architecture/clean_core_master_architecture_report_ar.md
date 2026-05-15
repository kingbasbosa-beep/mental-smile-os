# تقرير البنية المعمارية الشامل لـ clean_core

مرحلة ما بعد OS-9I / قبل تنفيذ الاستخراج الفعلي.

هذا التقرير يوثق الحالة المعمارية والاستراتيجية لمنظومة `clean_core` داخل Mental Smile. لا يعني هذا التقرير أن الاستخراج تم، ولا يعني أن Firebase أو مزودي الذكاء الاصطناعي أو أي Runtime تم تفعيله.

## 1. الملخص التنفيذي

وصلت `clean_core` إلى مرحلة نضج معماري تجعلها جاهزة للمراجعة اليدوية قبل الاستخراج المستقبلي. تم بناء طبقات الحوكمة، العقود، سياسات الأمان، نماذج السلطة الخلفية، خطط الفصل، واستراتيجية الربط اللاحق بشكل منظم.

النتيجة الأساسية: `clean_core` أصبحت نواة محكومة وليست مجرد مجموعة ملفات Flutter. هي مصممة لتكون طبقة عقود وسياسات آمنة، قابلة للاستخراج لاحقا، مع منع أي تفعيل مبكر للذكاء الاصطناعي أو المزودين أو Firebase Runtime أو Cloud Functions.

## 2. الرؤية والفلسفة

فلسفة Mental Smile تقوم على أن السلامة والحوكمة يجب أن تسبقا الذكاء والتنفيذ. المنظومة لا تتعامل مع الذكاء الاصطناعي كميزة يمكن تشغيلها مباشرة، بل كقدرة حساسة يجب أن تمر عبر موافقات، سياسات، مراجعة بشرية، وسلطة خلفية موثوقة.

لهذا تم تصميم `clean_core` كنواة محكومة:

- العقود قبل التنفيذ.
- الحوكمة قبل التشغيل.
- السلطة الخلفية قبل قرارات العميل.
- العزل قبل التكامل.
- الفشل الآمن قبل الراحة.

## 3. البنية المعمارية القائمة على الحوكمة أولا

تم بناء طبقات حوكمة متعددة تشمل:

- الحوكمة القانونية والموافقة.
- حوكمة سلامة الذكاء الاصطناعي.
- حوكمة السياسات.
- حوكمة المراجعة البشرية والتصعيد.
- حوكمة المزودين.
- حوكمة التشغيل المؤجل.
- حوكمة التغذية الراجعة وغرفة التحكم.
- حوكمة السلطة الخلفية والعمليات الموقعة.

هذه الطبقات لا تنفذ Runtime، لكنها تحدد القواعد التي يجب أن تحكم أي Runtime مستقبلي.

## 4. فلسفة Fail-Closed وDeny-by-Default

كل طبقة تم تصميمها على أساس أن الغموض يعني المنع أو المراجعة، وليس السماح.

إذا غابت السلطة، أو فشل الربط، أو لم يوجد رابط تدقيق، أو كان المزود غير معتمد، فالنتيجة يجب أن تكون:

- حظر.
- وضع fallback-only.
- مراجعة مطلوبة.
- عدم تنفيذ أي عملية حساسة.

هذا مهم لأن Mental Smile يتعامل مع مساحات نفسية وحساسة، وأي خطأ في الثقة قد يؤدي إلى مخاطر تشغيلية أو قانونية أو إنسانية.

## 5. خط تطور clean_core

بدأت `clean_core` كمسار تنظيف وفصل، ثم تطورت إلى نواة معمارية كاملة. عبر المراحل OS-2B إلى OS-9I تم بناء:

- عقود قانونية.
- حوكمة AI Safety.
- حدود Backend.
- عقود Audit.
- حوكمة Runtime.
- خطط استخراج.
- خطط Adapter.
- خرائط App-owned.
- تقارير جاهزية.
- نماذج السلطة الخلفية.
- Roadmap للتشغيل المستقبلي.

## 6. مراحل الحضارة المعمارية

يمكن تلخيص الحضارة المعمارية في خمس طبقات:

1. طبقة الأساس: عقود قانونية، سلامة، Backend، Audit.
2. طبقة الحوكمة: Policy، Human Review، Provider Governance.
3. طبقة Runtime المؤجل: Activation، Wiring، Enablement، Routing، Rollback، Observability، Isolation، Release، Bootstrap.
4. طبقة الاستخراج: Export readiness، Boundary maps، Adapter blueprints، Freeze gates.
5. طبقة التشغيل المستقبلي: AI Safety Runtime، Feedback Intelligence، Control Room، Backend Authority.

## 7. جاهزية التصدير والاستخراج

الاستخراج لم يتم بعد. لكن تم إعداد الوثائق اللازمة لمراجعته:

- تدقيق التلوث المعماري.
- تدقيق import graph.
- تصنيف العقود القابلة للتصدير.
- تحديد app-owned dependencies.
- استراتيجية public API.
- خطط rollback/reconnect.
- شروط الإيقاف.
- signoff قبل الاستخراج.

النتيجة: جاهزية للمراجعة اليدوية، وليس إذنا تلقائيا بالاستخراج.

## 8. استراتيجية Public API والعقود

السطح العام المستقبلي يجب أن يكون curated وليس export-all.

مرشح للتصدير:

- عقود Legal.
- عقود Safety.
- عقود Audit.
- عقود Policy.
- عقود Backend Boundary.
- عقود Review/Escalation.
- عقود Provider Governance بعد مراجعة.

غير مناسب للتصدير الأول:

- Flutter UI.
- Firebase Runtime.
- Routing.
- Generated files.
- Assets.
- Provider SDKs.
- Runtime execution.

## 9. استراتيجية حدود Adapters

Adapters هي الجسر بين `clean_core` والأنظمة المملوكة للتطبيق أو الخلفية.

`clean_core` يملك العقود فقط. التطبيق أو الخلفية يملكان التنفيذ.

المناطق التي تحتاج Adapter:

- Firebase.
- Auth/session.
- Routing.
- Localization.
- Environment/config.
- Observability.
- Provider bridge.
- Backend bridge.
- Emulator/test harness.

## 10. نموذج سلطة Backend

السلطة الحقيقية يجب أن تكون في الخلفية. العميل يستطيع تقديم طلب أو نية، لكنه لا يقرر:

- موافقة إدارية.
- حالة دفع.
- حالة تصعيد.
- نتيجة مراجعة.
- تفعيل Runtime.
- تفعيل مزود.
- نشر سياسة.

هذا يحمي Firestore من privileged client writes ويحافظ على الحوكمة.

## 11. حوكمة سلامة الذكاء الاصطناعي

تم تصميم AI Safety كمنظومة حوكمة قبل أي تنفيذ:

- فلترة الإدخال.
- كشف prompt injection.
- تصنيف المخاطر.
- اختيار response mode.
- بناء safe context.
- فحص إذن المزود.
- التحقق من المخرجات.
- fallback أو تصعيد أو مراجعة.

لا يوجد تنفيذ AI فعلي. كل شيء Blueprint فقط.

## 12. حوكمة المراجعة البشرية والتصعيد

المراجعة البشرية موجودة لأن بعض الحالات لا يجب أن تحسمها الآلة:

- حالات أزمة.
- مخرجات غير آمنة.
- فشل سياسة.
- فشل مزود.
- محاولات إساءة أو bypass.
- حالات Feedback حساسة.

المراجعة يجب أن تكون audit-linked وbackend-governed.

## 13. Feedback Intelligence وغرفة التحكم

تم إدخال feedback كطبقة تشغيلية دائمة وليست أداة اختبار قبل الإطلاق فقط.

الأهداف:

- تحسين UX/UI.
- تحسين المحتوى.
- تحسين الوصول.
- تحسين جودة الخدمات والمزودين.
- تحسين الاستقرار التقني.
- دعم قرارات التسويق والتصميم.
- توجيه الملاحظات إلى فرق تشغيلية داخل control room مستقبلية.

هذه الطبقة لا تنفذ Dashboards الآن، لكنها تحدد الحوكمة والمسارات.

## 14. فلسفة تأجيل Runtime

تم تأجيل Runtime عمدا لأن التنفيذ قبل الحوكمة خطر.

الأسباب:

- حماية المستخدم.
- حماية البيانات الحساسة.
- منع authority drift في العميل.
- ضمان أن المزودين لا يعملون قبل الاعتماد.
- ضمان rollback وshutdown وaudit قبل التشغيل.
- فصل الاستخراج عن التفعيل.

## 15. جاهزية Firebase والBackend

Firebase يظل app/backend-owned:

- initialization.
- options.
- auth.
- Firestore runtime.
- Functions runtime.
- Storage.
- Analytics.
- Emulator.

`clean_core` لا يملك Firebase SDK setup. يملك فقط العقود ونموذج السلطة.

## 16. استراتيجية Rollback وReconnect

تم توثيق dual-link transition:

- التطبيق قد يحتفظ بالمسارات القديمة مؤقتا.
- الحزمة المستخرجة تعرض عقود curated فقط.
- الربط يتم تدريجيا عبر adapters.
- rollback متاح في كل مرحلة.

Reconnect يبدأ بالبيئة، ثم auth، ثم Firebase، ثم backend bridge، ثم provider bridge، ثم localization/observability.

## 17. مبادئ الأمن والسلطة

المبادئ الحاكمة:

- Backend authority over client convenience.
- Security > convenience.
- Governance before execution.
- No hidden activation.
- No privileged client writes.
- Review-required يعني review-required فعلا.

## 18. مبادئ الخصوصية والبيانات الحساسة

المنظومة تمنع:

- تخزين raw crisis content افتراضيا.
- التشخيص.
- ملفات نفسية دائمة.
- full raw conversations.
- medication guidance.
- hidden profiling.

وتفضل:

- sanitized previews.
- audit references.
- policy references.
- session-scoped markers.
- retention boundaries.

## 19. خارطة التشغيل

مستقبلا يمكن بناء:

- Control room.
- Review queues.
- Feedback intelligence dashboards.
- Provider quality operations.
- Release impact tracking.
- Safety observability.
- Audit dashboards.

لكن كل ذلك مؤجل حتى يتم الاستخراج والمراجعة.

## 20. خارطة Runtime المستقبلية

Runtime المستقبلي يجب أن يمر عبر:

1. Policy governor.
2. Safety decision engine.
3. Runtime activation gateway.
4. Provider governance.
5. Backend bridge.
6. Audit/observability.
7. Human review readiness.
8. Rollback/shutdown readiness.

## 21. خارطة AI Runtime المستقبلية

قبل أي AI Runtime:

- موافقات قانونية.
- Policy snapshots.
- Safe context builder.
- Output validator.
- Provider onboarding.
- Backend authority.
- Circuit breaker.
- Human review.

لا يوجد OpenAI/Gemini integration حاليا.

## 22. استراتيجية الإطلاق والتجربة Pilot

الإطلاق المستقبلي يجب أن يكون مرحليا:

- عقود فقط.
- ثم adapters.
- ثم emulator/security tests.
- ثم pilot محدود.
- ثم مراقبة feedback/control-room.
- ثم تشغيل تدريجي إن تمت الموافقة.

## 23. تحليل المخاطر

أهم المخاطر:

- تسرب Firebase إلى core.
- provider SDK leakage.
- runtime activation مبكر.
- generated-file coupling.
- BuildContext contamination.
- privileged client writes.
- weaken fail-closed posture.

تم توثيق stop conditions لكل ذلك.

## 24. المناطق المؤجلة

المؤجل عمدا:

- Runtime execution.
- Provider execution.
- Firebase runtime.
- Cloud Functions.
- Networking.
- AI execution.
- Analytics runtime.
- Release/deployment activation.
- Live escalation runtime.

## 25. جاهزية تنفيذ الاستخراج

الحالة: جاهز لمراجعة يدوية قبل الاستخراج.

لا يبدأ الاستخراج قبل:

- manual import scan.
- export review.
- rollback checkpoints.
- app-owned verification.
- adapter-only verification.
- runtime-deferral verification.
- security review.

## 26. التقييم الاستراتيجي النهائي

`clean_core` أصبح Kernel محكوما، قابلا للاستخراج مستقبلا، ومبنيا على حوكمة قوية قبل التشغيل. هذا الاختيار يجعل Mental Smile أكثر أمنا وقابلية للنمو، لأنه يمنع خلط UI وFirebase وAI Runtime وProvider SDKs مع العقود الحساسة.

الخلاصة: المنظومة جاهزة معماريا للمراجعة قبل الاستخراج، لكنها ليست Runtime-ready بعد. وهذا مقصود وصحيح استراتيجيا.
