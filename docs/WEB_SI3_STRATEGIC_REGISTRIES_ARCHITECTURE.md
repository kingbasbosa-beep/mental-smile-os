# WEB-SI3 Strategic Registries Architecture

## 1. Executive Summary

Registries هي العمود الفقري لـ Strategic Intelligence لأنها تحول المعرفة المؤسسية من ملفات متفرقة إلى معرفة منظمة قابلة للربط والتحليل. بدون Registries، سيبقى Archive مجرد مستودع، وستبقى القرارات والدروس والتجارب منفصلة عن بعضها.

Strategic Intelligence يحتاج Registries حتى يستطيع أن يرى:

* كيف تطور المشروع.
* لماذا تم اتخاذ قرارات معينة.
* ما الذي فشل ولماذا.
* هل التوقعات كانت صحيحة.
* ما الذي يحدث في السوق.
* كيف يتحرك المنافسون.
* ما الانحرافات المتكررة.

هذه الوثيقة لا تنشئ UI أو Firebase أو Firestore. هي تحدد الشاسيه المعرفي الذي يمكن أن يبدأ يدويًا ثم يتطور لاحقًا.

## 2. Registry Doctrine

العقيدة:

```text
Registry
≠
Folder

Registry
=
Structured Institutional Knowledge
```

Folder يحفظ ملفات.

Registry يحفظ معرفة منظمة بعلاقات وmetadata وIDs ومراجع متبادلة.

كل Registry يجب أن يجيب عن سؤال مؤسسي واضح، لا أن يكون مجرد مكان لتجميع documents.

## 3. Registry Topology

التكوين المقترح:

```text
Historical Journey Registry

Decision Registry

Failure Registry

Feasibility Registry

Market Registry

Competitor Registry

Strategic Review Registry

Case & Resolution Registry
```

هذه registries تعمل معًا كشبكة معرفة استراتيجية، وليست جزر منفصلة.

## 4. Historical Journey Registry

يحفظ:

* eras
* milestones
* migrations
* freezes
* pivots

الغرض: تسجيل رحلة المشروع من الفكرة الأولى حتى Portal Era وما بعدها، حتى لا يفقد Mental Smile سياقه التاريخي.

أمثلة metadata:

* era id
* title
* start date
* end date
* key decisions
* related reports
* strategic meaning

## 5. Decision Registry

يحفظ:

* decision id
* rationale
* alternatives
* expected outcome
* actual outcome

الغرض: حفظ منطق القرار، وليس القرار فقط. هذا يمنع تكرار نفس النقاش بدون معرفة لماذا تم اختيار مسار معين.

أمثلة metadata:

* decision id
* date
* owner
* domain
* alternatives considered
* risk level
* linked feasibility study
* linked case ids

## 6. Failure Registry

يحفظ:

* incident
* root cause
* lesson learned
* recommendation

الغرض: تحويل الأخطاء إلى أصول معرفية. الفشل لا يدخل هنا كاتهام، بل كتعلم مؤسسي.

أمثلة metadata:

* failure id
* related case id
* domain
* root cause
* impact
* lesson learned
* prevention recommendation

## 7. Feasibility Registry

يحفظ:

* study id
* assumptions
* forecasts
* actual results

الغرض: حفظ الافتراضات قبل التنفيذ ومقارنتها بالنتائج لاحقًا. هذا يحسن دقة التخطيط مع الوقت.

أمثلة metadata:

* feasibility id
* initiative
* assumptions
* forecast period
* expected cost
* expected impact
* actual result
* follow-up decision

## 8. Market Registry

يحفظ:

* market observations
* trends
* opportunities
* threats

الغرض: حفظ إشارات السوق بطريقة منظمة، حتى لا يكون التخطيط مبنيًا على انطباعات مؤقتة.

أمثلة metadata:

* market id
* observation date
* geography
* segment
* trend
* opportunity
* threat
* confidence level

## 9. Competitor Registry

يحفظ:

* competitor profiles
* comparisons
* strengths
* weaknesses

الغرض: فهم التموضع التنافسي لـ Mental Smile بدون نسخ competitors أو كسر الدستور المعماري للمشروع.

أمثلة metadata:

* competitor id
* competitor name
* market segment
* strengths
* weaknesses
* pricing signals
* positioning notes
* differentiation opportunity

## 10. Strategic Review Registry

يحفظ:

* periodic reviews
* alignment reviews
* deviation reviews
* corrective actions

الغرض: مراجعة هل Mental Smile لا يزال يتحرك وفق العقيدة الدستورية والخطة الاستراتيجية، أم بدأ ينحرف بسبب ضغط التشغيل أو السوق.

أمثلة metadata:

* review id
* review date
* scope
* alignment score
* deviations found
* corrective actions
* owner decision required

## 11. Registry Relationships

الـ Registries ترتبط ببعضها عبر IDs ومراجع متبادلة.

أمثلة:

```text
Decision
↓
Failure
↓
Lesson

Decision
↓
Feasibility
↓
Outcome

Case
↓
Failure
↓
Strategic Review
```

أمثلة تفصيلية:

* Decision Registry قد يشير إلى Feasibility Registry قبل القرار.
* Failure Registry قد يشير إلى Case & Resolution Registry.
* Strategic Review Registry قد يجمع عدة failures وdecisions.
* Historical Journey Registry قد يشير إلى قرارات كبرى أو migration waves.
* Market Registry قد يغذي Feasibility Registry.
* Competitor Registry قد يغذي Strategic Review Registry.

القاعدة:

```text
Registry links create institutional intelligence.
```

## 12. Registry IDs

Naming Convention المقترح:

```text
HJR-2026-001

DEC-2026-004

FAIL-2026-002

FSB-2026-003

MKT-2026-007

COMP-2026-002

SRV-2026-001

CASE-TECH-2026-004
```

معاني prefixes:

* `HJR`: Historical Journey Registry
* `DEC`: Decision Registry
* `FAIL`: Failure Registry
* `FSB`: Feasibility Registry
* `MKT`: Market Registry
* `COMP`: Competitor Registry
* `SRV`: Strategic Review Registry
* `CASE-<DOMAIN>`: Case & Resolution Registry

كل ID يجب أن يكون ثابتًا ولا يعاد استخدامه.

## 13. Year One Reality

واقع السنة الأولى:

```text
Google Drive

Google Sheets

Manual Linking

Manual References

Founder Operated
```

التنفيذ اليدوي كافٍ كبداية:

* Sheet منفصل أو tabs للـ registries.
* links إلى docs داخل Google Drive.
* IDs يدوية.
* مراجعة أسبوعية أو شهرية.
* لا automation.
* لا Knowledge Graph الآن.

## 14. Future Evolution

مسار التطور:

```text
Manual Registries
↓
Firestore Registries
↓
Linked Registries
↓
Knowledge Graph
↓
Strategic Intelligence Assistant
```

يجب عدم القفز إلى Firestore أو AI قبل أن تثبت الـ manual registries ما هي الحقول والعلاقات المهمة فعلاً.

## 15. Final Recommendation

نعم، يجب بناء Registry Architecture قبل Owner Room.

السبب:

* Owner Room يحتاج decision memory وfailure memory وhistorical context.
* Strategic Intelligence لا يمكن أن يعمل بدون structured registries.
* بناء Owner Room قبل registries سيجعله dashboard قرار بلا ذاكرة كافية.
* Year One يمكن أن يبدأ يدويًا بدون تكلفة تقنية.

التوصية:

ابدأ بـ Google Sheets + Google Drive + ID convention + manual references. بعد تراكم بيانات كافية، يمكن التفكير في Firestore registries أو Knowledge Graph.

هذا Blueprint يوثق فقط.
هذا Blueprint لا ينشئ UI.
هذا Blueprint لا ينشئ Firebase.
هذا Blueprint لا ينشئ Firestore.
هذا Blueprint لا يغير Runtime.
