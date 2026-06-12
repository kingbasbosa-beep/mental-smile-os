# SURFACE LANGUAGE VALIDATION RULES

## الغرض

هذه القواعد تحدد كيف يقرر المطور أو الذكاء الاصطناعي صلاحية كلمة أو عبارة
بعد حل معناها من Language Registry.

الحكم النهائي ليس حكمًا على الكلمة وحدها. هو حكم على:

```text
Term
+ Surface
+ Source Owner
+ Text Owner
+ Output Type
+ Intended Meaning
= Permission Decision
```

## خطوات التحقق

### 1. حدد نوع السطح

اختر واحدًا:

- `RESIDENTIAL`
- `COMMERCIAL`
- `ADMINISTRATIVE`

إذا كان السطح مركبًا، احكم على الجزء الذي سيظهر فيه النص فعليًا.

### 2. حدد مالك النص

من المسؤول عن المعنى؟

- Mental Smile
- العميل
- مقدم الخدمة
- المركز
- مصدر خارجي
- تقرير آلي
- مراقب أو مالك في سياق حوكمة

### 3. حدد مصدر النص

هل النص:

- لغة منصة؟
- إقرار من مقدم خدمة؟
- إقرار من مركز؟
- محتوى مستخدم؟
- بيانات تقرير؟
- اقتباس تاريخي؟
- إعلان ممول؟

النص المعلن من مقدم الخدمة لا يصبح تلقائيًا لغة للمنصة.

### 4. حدد نوع المخرج

- زر
- تاب
- عنوان
- اسم قسم
- وصف
- فيلد بيانات
- كارت
- إعلان
- تقرير
- تحليل
- Tooltip
- Notification
- Error
- Empty State

العناوين والأزرار والتابات تخضع لأشد القيود لأنها تعلن وظيفة النظام.

### 5. طبق سياسة السطح

- Residential -> `RESIDENTIAL_LANGUAGE_POLICY.md`
- Commercial -> `COMMERCIAL_LANGUAGE_POLICY.md`
- Administrative -> `ADMINISTRATIVE_LANGUAGE_POLICY.md`

ثم راجع `SURFACE_TERM_PERMISSION_MATRIX.md`.

### 6. المصطلح العلاجي في السكني

إذا كان المصطلح علاجيًا أو طبيًا في لغة المنصة داخل Residential:

**BLOCK**

لا يتم تخفيفه بصياغة ألطف مع إبقاء نفس المعنى العلاجي.

### 7. المصطلح العلاجي في التجاري

إذا كان المصطلح:

- بيانات معلنة من مقدم الخدمة أو المركز؛
- داخل وصف أو فيلد معلومات؛
- لا يتضمن حجزًا أو اعتمادًا أو وعدًا من المنصة؛

فالنتيجة:

**LIMITED ALLOW**

وإلا:

**BLOCK**

### 8. المصطلح العلاجي في الإدارة

إذا كان داخل:

- تقرير؛
- تحليل؛
- تصنيف؛
- اقتباس؛
- قراءة نمط؛

فالنتيجة:

**LIMITED ALLOW**

إذا أصبح عنوان تاب أو زرًا أو سلطة تشغيلية:

**BLOCK**

### 9. ادعاء المنصة

إذا أوحى النص بأن Mental Smile:

- تعالج؛
- تشخص؛
- تحجز؛
- تدير جلسة؛
- تعتمد مختصًا علاجيًا؛
- تعين مقدم خدمة؛
- تملك حالة؛
- تدير رحلة التعافي؛

فالنتيجة في كل الأسطح:

**BLOCK**

## شجرة القرار

```text
هل المصطلح عقائدي أو علاجي؟
|
+-- لا -> طبّق Language Engine والقالب المعتاد
|
+-- نعم
    |
    +-- Residential؟
    |   +-- لغة منصة -> BLOCK
    |   `-- إعلان منسوب لمصدر ويؤدي لصفحة عامة -> LIMITED
    |
    +-- Commercial؟
    |   +-- بيانات معلنة من مقدم/مركز -> LIMITED
    |   `-- وعد أو إجراء من المنصة -> BLOCK
    |
    `-- Administrative؟
        +-- تقرير/تحليل/اقتباس -> LIMITED
        `-- زر/تاب/سلطة تشغيلية -> BLOCK
```

## نتائج التحقق

### ALLOWED

المعنى والمصدر والموضع متوافقون مع سياسة السطح.

### LIMITED_ALLOW

المصطلح مسموح فقط مع شروط المصدر والموضع والنسب.

يجب تسجيل:

- السطح؛
- المصدر؛
- نوع المخرج؛
- سبب السماح؛
- الحدود.

### BLOCK

المعنى أو سلطة النص تتعارض مع سياسة السطح.

### ESCALATE_TO_REGISTRY

يستخدم عندما:

- نوع السطح غير معروف؛
- ملكية النص متنازع عليها؛
- المصطلح غير مسجل؛
- الإعلان يخلط بين لغة المنصة ولغة مقدم الخدمة؛
- التقرير يتحول إلى إجراء.

## عقد التحقق للذكاء الاصطناعي

قبل توليد أي نص، يعيد AI:

| Field | Required Value |
|---|---|
| Surface Type | Residential / Commercial / Administrative |
| Text Owner | Declared owner |
| Source | Platform / Provider / Center / User / Report / Historical |
| Output Type | Button / Title / Description / Field / Report / Other |
| Term IDs | Registry references |
| Surface Decision | ALLOWED / LIMITED_ALLOW / BLOCK |
| Conditions | Required for LIMITED_ALLOW |
| Arabic | Governed output |
| English | Governed output |
| Parity | PASS / FAIL |

## أمثلة

### Example 1

- Surface: Residential
- Text: `احجز جلسة`
- Owner: Mental Smile
- Output: Button
- Decision: **BLOCK**
- Replacement: `اعرض معلومات مقدم الخدمة`

### Example 2

- Surface: Commercial
- Text: `مدة الجلسة: 45 دقيقة`
- Owner: Provider
- Output: Declared field
- Decision: **LIMITED_ALLOW**

### Example 3

- Surface: Administrative
- Text: `تحليل الصفحات التي تعرض أسعار الجلسات`
- Owner: Monitoring
- Output: Report
- Decision: **LIMITED_ALLOW**

### Example 4

- Surface: Administrative
- Text: `تعيين مختص`
- Owner: Platform
- Output: Button
- Decision: **BLOCK**

## قاعدة عدم التحايل

استبدال كلمة ممنوعة بمرادف لا يغير الحكم إذا بقيت السلطة نفسها.

`اربط العميل تلقائيًا بمختص`

تظل Assignment Doctrine حتى لو لم تستخدم كلمة `إسناد`.

