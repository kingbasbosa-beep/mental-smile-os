# WEB-A1 Archive Blueprint

## 1. Executive Summary

Archive في Mental Smile يجب أن يكون Web First لأنه جزء من السيادة المؤسسية وليس جزء من التشغيل اليومي. الأرشيف يحفظ ذاكرة المؤسسة: القرارات، العقود، التراخيص، الإيصالات، التسجيلات، المحتوى المنشور، وتقارير الحوكمة.

Control Room وظيفته مراقبة runtime والتصعيد والمتابعة التشغيلية. لذلك وضع Archive داخل Control Room يخلط بين institutional memory وruntime monitoring، ويزود التعقيد والصلاحيات داخل التطبيق التشغيلي.

القرار المعماري المقترح:

```text
Archive = Sovereign Web System
Control Room = Operational App System
```

## 2. Archive Doctrine

العقيدة الرسمية:

```text
Archive
≠
Logs

Archive
≠
Runtime Monitoring

Archive
=
Institutional Memory
```

الأرشيف ليس مكانًا لمراقبة اللحظة الحالية، ولا هو بديل للـ logs أو dashboards. الأرشيف هو مساحة مرجعية تحفظ ما تم اعتماده أو نشره أو مراجعته أو الموافقة عليه.

## 3. Sovereign Archive Domains

### Owner Archive

يملك:

* strategic decisions
* constitutional decisions
* expansion plans
* governance reports

الغرض منه حفظ قرارات الـ Owner والاتجاهات العليا للمشروع، بحيث لا تضيع القرارات المعمارية أو التشغيلية مع الوقت.

### Finance Archive

يملك:

* receipts
* invoices
* subscriptions
* financial approvals

الغرض منه حفظ المستندات المالية الرسمية، وليس تشغيل payment أو payout داخل التطبيق.

### Legal Archive

يملك:

* contracts
* licenses
* compliance documents
* legal approvals

الغرض منه فصل الوثائق القانونية والامتثالية عن operational runtime، مع قابلية التطور لاحقًا إلى legal portal مستقل.

### Registration Archive

يملك:

* provider registrations
* center registrations
* approval history
* submitted documents

الغرض منه حفظ تاريخ intake/review/approval للتسجيلات، مع عدم تحويله إلى workflow engine في السنة الأولى.

### Library Archive

يملك:

* published content
* library assets
* future content registry

الغرض منه حفظ المحتوى المنشور وأصول المكتبة وسجل الإصدارات المستقبلية.

## 4. Operational Archive Domains

الأشياء التالية يجب أن تبقى خارج Web Archive السيادي:

* support logs
* escalation logs
* monitoring logs
* runtime events

هذه تظل تابعة لـ Control Room لأنها تشغيلية، زمنية، ومرتبطة بالمراقبة والمتابعة اليومية. يمكن لاحقًا تصدير ملخصات أو تقارير معتمدة منها إلى Web Archive، لكن الـ raw operational logs لا تصبح ملك الأرشيف السيادي.

## 5. Archive Topology

التكوين المقترح:

```text
Archive

├── Owner
├── Finance
├── Legal
├── Registrations
├── Library
├── Reports
```

كل فرع يملك نوعًا واضحًا من الذاكرة المؤسسية. لا يوجد فرع واحد يحمل كل شيء، ولا يجب أن يتحول Archive إلى collection أو portal عشوائي يجمع كل domains.

## 6. Year One Reality

واقع السنة الأولى:

```text
Founder Operated

Manual Management

No Dedicated Archive Team

No Archive Automation
```

هذا يعني أن الأرشيف يبدأ كتصميم وانضباط إداري قبل أن يصبح نظامًا آليًا. يمكن استخدام ملفات منظمة، Google Drive، أو document repository يدوي في البداية، بشرط الالتزام بالملكية والتصنيف.

## 7. Future Evolution

مسار التطور:

```text
Manual Archive

↓

Document Repository

↓

Archive Registry

↓

Federated Archive System
```

الانتقال يجب أن يتم تدريجيًا. لا يتم بناء Federated Archive System قبل وضوح domains، naming، retention policy، وصلاحيات الوصول.

## 8. Archive vs Owner Room

Owner Room هو مساحة القرار، الرؤية، التخطيط، والمراجعة العليا.

Archive هو ذاكرة القرارات والوثائق بعد اعتمادها أو تسجيلها.

الفرق:

* Owner Room ينتج قرارات.
* Archive يحفظ القرارات.
* Owner Room يفكر ويقرر.
* Archive يوثق ويحافظ.

لذلك Owner Room وArchive مرتبطان، لكنهما ليسا نفس النظام.

## 9. Archive vs Control Room

Control Room يراقب التشغيل:

* incidents
* escalations
* support visibility
* operational exceptions
* runtime status

Archive يحفظ الذاكرة المؤسسية:

* decisions
* approvals
* contracts
* receipts
* registrations
* published records

القاعدة:

```text
Control Room sees what is happening.
Archive remembers what was officially kept.
```

## 10. Final Recommendation

نعم، Archive يجب أن يسبق:

* Finance Portal
* Legal Portal
* Owner Room

ليس كـ UI كامل أو نظام آلي، لكن كـ blueprint وتصنيف وfolder/document discipline.

السبب:

* Finance Portal يحتاج receipts/invoices archive.
* Legal Portal يحتاج contracts/licenses archive.
* Owner Room يحتاج decision archive.
* التسجيلات تحتاج submitted documents وapproval history archive.

بناء الأرشيف كعقيدة مبكرة يمنع تحول Finance/Legal/Owner systems إلى جزر منفصلة بلا ذاكرة مشتركة.

هذا Blueprint يوثق فقط.
هذا Blueprint لا ينشئ Archive.
هذا Blueprint لا يضيف Firebase.
هذا Blueprint لا يضيف Firestore.
هذا Blueprint لا يغير Runtime.
