# WEB-SI2 Strategic Case & Resolution Network Blueprint

## 1. Executive Summary

Mental Smile تحتاج Strategic Case & Resolution Network من السنة الأولى لأن مرحلة Founder-operated لا تعني العمل بدون نظام. بالعكس، قلة الفريق تجعل توثيق المشاكل والحلول أكثر أهمية حتى لا تضيع أسباب التعطيل أو تتكرر نفس الأخطاء.

هذا النظام لا يحل محل Control Room ولا Archive ولا Owner Room. هو شاسيه لتسجيل المشكلة وما حدث بعدها: من رآها، متى ظهرت، ما أثرها، من رد، ما الحل، ما الدرس، وهل أصبحت pattern استراتيجي.

الهدف الأساسي:

```text
Do not remember the problem only.
Remember the response, resolution, and lesson.
```

## 2. Core Doctrine

القواعد الحاكمة:

```text
No problem without resolution tracking.

No incident without timestamp.

No resolution without lesson learned.

Archive remembers.
Departments execute.
Strategic Intelligence learns.
```

هذا يعني أن كل case مهم يجب أن يحتوي على life cycle كامل: ظهور، استجابة، حل، درس، وقرار مستقبلي إن لزم.

## 3. Case Card Structure

كل حالة يجب أن تسجل في Case Card موحد.

## Case Header

* case id
* title
* domain
* category
* severity
* status
* reported by
* created at
* affected area
* owner department

## Problem Section

* problem description
* observed impact
* evidence / references
* related archive ids
* related decision ids

## Response Section

* first response at
* assigned to
* action taken
* response notes

## Resolution Section

* resolved at
* resolved by
* final resolution
* root cause
* lesson learned
* prevention recommendation

## Strategic Section

* strategic impact
* alignment risk
* repeated pattern?
* future watch flag

الغرض من الـ Case Card هو منع انفصال المشكلة عن حلها أو درسها.

## 4. Status / Color Doctrine

الحالات والألوان:

```text
OPEN = Red
IN_PROGRESS = Yellow
AWAITING_RESPONSE = Orange
RESOLVED = Green
ARCHIVED = Blue
STRATEGIC_REVIEW = Purple
```

معنى كل حالة:

* `OPEN`: المشكلة مسجلة ولم يبدأ التعامل الجدي معها بعد.
* `IN_PROGRESS`: يوجد إجراء جارٍ أو شخص/قسم يعمل عليها.
* `AWAITING_RESPONSE`: الحالة متوقفة على رد أو معلومة أو قرار من طرف آخر.
* `RESOLVED`: تم حل المشكلة وتسجيل الحل.
* `ARCHIVED`: تم إغلاقها وتحويلها لذاكرة مؤسسية أو حفظها كمرجع.
* `STRATEGIC_REVIEW`: الحالة لها أثر استراتيجي أو تكشف pattern يحتاج قرار أعلى.

## 5. Response Time Metrics

المقاييس المقترحة:

* time to first response
* time to resolution
* department average response time
* repeated issue count
* unresolved cases count
* strategic deviation count

هذه المقاييس لا تحتاج automation في البداية. يمكن حسابها يدويًا أو عبر Google Sheet formulas لاحقًا.

## 6. Department Ownership

المجالات:

* Technical
* Finance
* Legal
* Marketing
* Content
* Support
* Control Room
* Owner Room
* Archive
* Strategic Intelligence

قاعدة الملكية:

```text
Department owns execution.
Archive owns memory.
Strategic Intelligence owns analysis.
Owner owns decision.
```

Communication بين الأقسام لا يعني نقل الملكية. كل case يجب أن يحدد owner department بوضوح، حتى لو شاركت أكثر من جهة في الحل.

## 7. Year One Manual Implementation

تنفيذ السنة الأولى يجب أن يكون يدويًا وبسيطًا:

* Google Sheet كـ Case Registry
* Google Drive folder لكل case مهم
* naming convention
* weekly review by Owner
* manual labels/colors
* no automation
* no staff dependency

اقتراح naming:

```text
CASE-TECH-2026-004
CASE-FIN-2026-002
CASE-LEGAL-2026-001
CASE-SUPPORT-2026-009
CASE-OWNER-2026-003
```

## 8. Suggested Manual Columns

أعمدة Google Sheet المقترحة:

* case_id
* title
* domain
* severity
* status
* color
* created_at
* first_response_at
* resolved_at
* owner_department
* assigned_to
* root_cause
* resolution
* lesson_learned
* strategic_impact
* related_archive_ids
* next_action

هذه الأعمدة تكفي كبداية Founder-operated بدون بناء ticketing system.

## 9. Alert Future Vision

الرؤية المستقبلية فقط:

```text
Manual Case Registry
↓
Firestore Case Registry
↓
Department Alerts
↓
Pending Response Tracking
↓
Auto Reminder
↓
AI Pattern Analysis
```

لا يتم تنفيذ أي جزء من هذا الآن. البداية يدويًا حتى تنضج الأنماط وتظهر الحاجة الحقيقية للأتمتة.

## 10. Strategic Intelligence Reporting

كل Domain Intelligence يجب أن يرسل تقارير دورية إلى Strategic Intelligence Office.

التقارير المجمعة يجب أن تجيب:

* ما أكثر المشاكل تكرارًا؟
* أي قسم يتأخر في الاستجابة؟
* هل هناك انحراف عن الخطة الاستراتيجية؟
* هل المشكلة بسبب موارد؟
* هل المشكلة بسبب تصميم؟
* هل المشكلة بسبب سوق أو منافس؟
* ما الإجراء المقترح؟

الهدف ليس فقط متابعة التشغيل، بل تحويل المشاكل المتكررة إلى insight استراتيجي.

## 11. Integration With Archive

كل case مهم يمكن أن يتحول إلى Archive Item بعد الإغلاق.

مثال:

```text
CASE-TECH-2026-004
↓
ARCHIVE REPORT
↓
FAILURE REGISTRY
↓
LESSON LEARNED
```

بعد الإغلاق، يتم تحديد هل الحالة:

* تحفظ كـ Archive Report.
* تدخل Failure Registry.
* تدخل Decision Registry.
* تتحول إلى future watch flag.

## 12. What Must Not Be Built Now

ممنوع الآن:

* workflow engine
* auto assignment
* complex permissions
* AI alerts
* Firestore case system
* ticketing system
* CRM
* department dashboards

السنة الأولى تحتاج manual discipline أكثر من system complexity.

## 13. Final Recommendation

نعم، يجب بدء Case & Resolution Network يدويًا قبل بناء Owner Room وControl Room.

السبب:

* Owner Room يحتاج سجل قرارات ومشاكل وحلول يغذي القرار.
* Control Room يحتاج معرفة ما هي الحالات المتكررة قبل بناء dashboards.
* Founder-operated phase تحتاج نظام خفيف يمنع ضياع المشاكل والدروس.
* البدء اليدوي يكشف الحقول المهمة قبل أي Firestore أو automation.

التوصية:

ابدأ بـ Google Sheet + Google Drive folders + weekly Owner review + manual status colors. بعد 2-3 أشهر من الاستخدام، يمكن تقييم هل نحتاج Firestore Case Registry أو alerts.

هذا Blueprint يوثق فقط.
هذا Blueprint لا ينشئ UI.
هذا Blueprint لا ينشئ Firebase.
هذا Blueprint لا ينشئ Firestore.
هذا Blueprint لا يغير Runtime.
