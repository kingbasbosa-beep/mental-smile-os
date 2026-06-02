# WEB-A2 Archive Information Architecture

## 1. Executive Summary

Archive يحتاج Information Architecture قبل أي Portal أو Repository لأن الأرشيف ليس مجرد مكان لتخزين ملفات. الأرشيف هو ذاكرة مؤسسية منظمة، ولو لم يتم تحديد naming، categories، metadata، access، وretention من البداية سيتحول بسرعة إلى folders عشوائية يصعب البحث فيها أو الاعتماد عليها.

هذه الوثيقة تحدد طريقة تنظيم الذاكرة المؤسسية لـ Mental Smile بعد Portal Phase 1، وبناءً على Sovereign / Operational Separation Doctrine. هي لا تنشئ UI، ولا Firebase، ولا Firestore، ولا Pages. هي فقط تحدد كيف سيتم تصنيف وحفظ واسترجاع عناصر الأرشيف مستقبلًا.

## 2. Archive Naming Doctrine

كل Archive Item يجب أن يحصل على Archive ID واضح وثابت.

صيغة عامة:

```text
<DOMAIN>-<YEAR>-<SEQUENCE>
```

أمثلة:

```text
OWNER-2026-001

LEGAL-2026-004

FIN-2026-012

REG-PROVIDER-2026-008

REG-CENTER-2026-009

LIB-2026-002

REPORT-2026-015
```

قواعد التسمية:

* `OWNER` لقرارات المالك والتقارير الدستورية.
* `FIN` للمستندات المالية.
* `LEGAL` للمستندات القانونية والامتثال.
* `REG-PROVIDER` لتسجيلات الأخصائيين.
* `REG-CENTER` لتسجيلات المراكز.
* `LIB` للمكتبة والمحتوى.
* `REPORT` للتقارير والمراجعات والخرائط المعمارية.

الـ sequence يكون تصاعدي داخل السنة، ولا يعاد استخدامه حتى لو تم إخفاء أو إلغاء عنصر.

## 3. Archive Categories

## Owner

يضم:

* strategic decisions
* constitutional reports
* expansion plans

الغرض: حفظ القرارات العليا وخطط التوسع وتقارير الحوكمة التي تشكل اتجاه المشروع.

## Finance

يضم:

* invoices
* receipts
* approvals

الغرض: حفظ الأدلة المالية الرسمية، الموافقات، والإيصالات بدون تحويل الـ Portal إلى نظام محاسبي تشغيلي.

## Legal

يضم:

* contracts
* licenses
* compliance

الغرض: حفظ العقود والتراخيص ووثائق الامتثال كذاكرة قانونية مستقلة عن runtime التطبيق.

## Registrations

### Providers

يضم طلبات intake/review الخاصة بمقدمي الخدمة.

### Centers

يضم طلبات intake/review الخاصة بالمراكز.

### Approval History

يحفظ مراحل المراجعة، قرارات القبول، الرفض، التعليق، أو طلب استكمال بيانات.

### Submitted Documents

يحفظ الوثائق المقدمة ضمن registration/intake، مع الإشارة إلى مسؤولية مقدم الطلب عن صحة الوثائق.

## Library

### Published Content

المحتوى المنشور رسميًا داخل Mental Smile Library.

### Assets

الصور، الملفات، الوسائط، وأصول المحتوى.

### Content Registry

سجل المحتوى، حالته، لغته، تصنيفه، وتاريخ نشره أو مراجعته.

## Reports

### Audits

تقارير المراجعة والتحليل.

### Freeze Reports

تقارير التجميد والتصنيف.

### Governance Reports

تقارير الحوكمة والقرارات المؤسسية.

### Technical Reports

التقارير التقنية والمعمارية وخطط التنفيذ.

## 4. Metadata Strategy

كل Archive Item يجب أن يحمل metadata أساسية:

* archive id
* title
* category
* owner
* created date
* approval status
* tags
* retention notes

تفسير الحقول:

* `archive id`: المعرف الثابت للعنصر.
* `title`: عنوان واضح قابل للبحث.
* `category`: Owner / Finance / Legal / Registrations / Library / Reports.
* `owner`: الجهة المالكة للعنصر.
* `created date`: تاريخ الإنشاء أو الاعتماد.
* `approval status`: draft / reviewed / approved / archived / hidden.
* `tags`: كلمات مفتاحية مثل trust, finance, provider, portal, legal.
* `retention notes`: هل يحتفظ به دائمًا، أو يخضع لمراجعة دورية، أو يمكن إخفاؤه لاحقًا.

## 5. Access Doctrine

الأدوار المقترحة:

## Owner

صلاحية كاملة على كل الأرشيف، خاصة Owner وReports والقرارات الدستورية.

## Finance

صلاحية على Finance Archive، وقراءة محدودة للعناصر المرتبطة بالعقود أو الاشتراكات عند الحاجة.

## Legal

صلاحية على Legal Archive، وقراءة محدودة لعناصر registration/documents عند الحاجة للامتثال.

## Archive Admin

مسؤول تنظيم وتصنيف metadata، لكنه لا يملك قرارًا سياديًا إلا إذا فوضه Owner.

## Future Read Only Roles

أدوار قراءة فقط مستقبلية للمراجعين أو الأقسام، بدون صلاحية تعديل أو حذف.

القاعدة:

```text
Access enables visibility.

Access does not transfer ownership.
```

## 6. Retention Strategy

ما يحتفظ به دائمًا:

* constitutional decisions
* legal contracts
* licenses
* financial receipts and invoices
* approval history
* governance reports

ما يمكن أرشفته:

* outdated reports
* old registration versions
* replaced content assets
* completed review packages

ما يمكن إخفاؤه:

* drafts غير المعتمدة
* duplicates
* documents superseded by approved versions
* sensitive items لا يجب ظهورها في read-only views

الإخفاء لا يعني الحذف. الحذف يحتاج policy لاحقة وموافقة Owner.

## 7. Archive Registry Vision

الرؤية المستقبلية:

```text
Archive Item

↓

Archive Registry

↓

Search

↓

Federated Archive
```

في البداية قد يكون Archive Registry عبارة عن spreadsheet أو document index يدوي. لاحقًا يمكن أن يتحول إلى read model أو registry system مستقل، لكن بدون استعجال بناء system قبل نضج التصنيف.

## 8. Year One Reality

واقع السنة الأولى:

```text
Google Drive

Folders

Manual Organization

Manual Naming

Founder Operated
```

لا يوجد Archive Team مستقل في البداية. لذلك يجب أن تكون القواعد بسيطة وواضحة، ويمكن تنفيذها يدويًا بدون تكلفة تشغيلية عالية.

## 9. Archive and Future Owner Room

Owner Room سيحتاج Archive كمرجع للقرارات السابقة، التقارير الدستورية، خطط التوسع، ومراحل التنفيذ.

العلاقة:

* Owner Room ينتج قرارات وخطط.
* Archive يحفظ النسخ المعتمدة.
* Owner Room يقرأ history.
* Archive يحمي institutional memory.

لذلك إنشاء Archive Structure قبل Owner Room يقلل الفوضى عندما تبدأ القرارات والملفات في التزايد.

## 10. Archive and Future Finance/Legal

Finance وLegal سيستخدمان نفس الأرشيف لكن بصلاحيات وcategories منفصلة.

Finance يحتاج:

* receipts
* invoices
* approvals
* subscription records

Legal يحتاج:

* contracts
* licenses
* compliance documents
* legal approvals

استخدام Archive IA موحدة يمنع تكرار نفس الوثائق في أماكن متعددة، ويسمح بفصل Finance/Legal لاحقًا بدون فقدان الذاكرة المؤسسية.

## 11. Final Recommendation

نعم، يجب إنشاء Archive Structure قبل Owner Room.

السبب:

* Owner Room سيحتاج ذاكرة قرارات جاهزة.
* Finance وLegal سيحتاجان تصنيف وثائق منظم.
* التسجيلات والمحتوى سيزدادان بسرعة بعد Portal Phase 1.
* بناء IA مبكرًا أرخص من تنظيف فوضى أرشيفية لاحقًا.

التوصية العملية:

ابدأ بـ Google Drive + Folder Structure + Naming Doctrine + Manual Archive Registry، ثم تطور لاحقًا إلى Archive Registry وفيدرالية أرشيفية حسب الحاجة.

هذا تقرير معماري فقط.
هذا التقرير لا ينشئ UI.
هذا التقرير لا ينشئ Firebase.
هذا التقرير لا ينشئ Firestore.
هذا التقرير لا يغير Runtime.
