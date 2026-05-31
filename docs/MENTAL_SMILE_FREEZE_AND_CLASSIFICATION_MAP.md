# MENTAL SMILE FREEZE AND CLASSIFICATION MAP

هذا التقرير لا يعدل Runtime.
هذا التقرير لا يعدل Firestore rules.
هذا التقرير لا يحذف routes أو collections.
هو فقط خريطة تصنيف وتجميد قبل التنفيذ.

المرجعية الأعلى لهذا التقرير هي:

```text
docs/MENTAL_SMILE_DOMAIN_OWNERSHIP_CONSTITUTION.md
```

---

# 1. Executive Summary

Mental Smile حسب الدستور هو **سوق خدمات الصحة النفسية**. لذلك أي عنصر في المشروع لازم يتصنف حسب ملكيته الحقيقية، وليس حسب مكانه الحالي في الكود.

النتيجة المختصرة:

* Core يجب أن يظل مركزه: marketplace, client support, education/library, trust transparency, provider/center enablement.
* Control هو admin governance والرقابة والتشغيل، وليس Super Admin Platform يملك كل الدومينات.
* Booking وfinancial cycle ليسوا Core. هم إمّا Optional Module لاحقًا أو Legacy/Quarantined حاليًا.
* `booking_requests` تصنف رسميًا كـ `Frozen + Quarantined + Legacy Candidate`.
* أي payment, payout, accounting, commission, settlement يجب تجميده كمسار مالي legacy وليس توسيعه.
* لا يجوز إنشاء `service_requests` مستقبلًا بنفس مشكلة `booking_requests`.
* لا يتم تعديل Firestore rules الآن. أي تعديل rules لاحق يحتاج domain ownership clarity, route classification, tests, owner approval.

---

# 2. Classification Legend

| التصنيف | المعنى | اتجاه التعامل |
|---|---|---|
| Core | جزء أساسي من هوية Mental Smile كسوق خدمات صحة نفسية | KEEP وتحسين تدريجي تحت نفس الدومين |
| Control | إدارة، مراجعة، governance، monitoring، admin oversight | KEEP مع منع التحول لـ Super Admin Platform |
| Optional Module | قدرة اختيارية قابلة للتأجير أو الفصل | MODULE EXTRACT أو tenant-scoped activation |
| Legacy | موجود تاريخيًا ويخدم توافق أو بيانات قديمة | FREEZE ثم migrate أو bury |
| Quarantined | منطقة خطرة أو مختلطة الدومينات | QUARANTINE ومنع التوسع |
| Burial Candidate | مرشح للدفن بعد archive/migration | BURIAL CANDIDATE ثم إزالة لاحقة مخططة |

Actions المستخدمة:

* KEEP: يظل ضمن الدومين مع ضبط ملكية.
* FREEZE: لا توسع ولا features جديدة.
* QUARANTINE: يعزل عن Core ويمنع استخدامه كأساس.
* RENAME LATER: الاسم الحالي مضلل ويحتاج تسمية لاحقة بعد قرار.
* MODULE EXTRACT: ينقل لاحقًا إلى Optional Module مستقل.
* BURIAL CANDIDATE: مرشح للدفن بعد حفظ legacy/audit.

---

# 3. Route Classification Map

## Core / Client / Marketplace

| Route | current purpose | current classification | target classification | risk | action |
|---|---|---|---|---|---|
| `/` | Splash / initial app entry | Core shell | Core | منخفض | KEEP |
| `/language` | اختيار اللغة | Core shell | Core | منخفض | KEEP |
| `/login` | دخول الحسابات وتوجيه الأدوار | Core access | Core | متوسط بسبب role routing | KEEP |
| `/menu` | operational menu hub | Core navigation | Core | متوسط لو يعرض legacy مالي كأنه core | KEEP |
| `/client/*` | client dashboard, sessions, payment proof | Mixed client + legacy booking/financial | Core + Quarantined حسب المسار | عالي في payment/session naming | SPLIT LATER |
| `/clinician/*` | clinician operations, inbox, sessions, chat inbox | Mixed professional enablement + legacy booking | Core enablement + Quarantined fragments | عالي بسبب inbox/sessions المرتبطة بـ booking_requests | FREEZE legacy parts / KEEP enablement |
| `/center/*` | center dashboard, operations, inbox, residencies | Center enablement + legacy booking inbox | Core enablement + Optional Module candidate fragments | متوسط/عالي | KEEP core / MODULE EXTRACT booking inbox later |
| `/module/library` | in-app library | Core education/library | Core | منخفض | KEEP |
| `/web/library` | web library alias | Core education/library | Core | منخفض | KEEP |
| `/chat` | chat support/general communication | Client Support + Chat | Core support | متوسط بسبب escalation/report subflows | KEEP |
| `/module/support-issue-selector` | structured support issue intake | Client Support | Core support | متوسط لأن بعض options تشير payment/booking | KEEP مع detox لاحق للألفاظ المالية |

## Registration / Provider Intake

| Route | current purpose | current classification | target classification | risk | action |
|---|---|---|---|---|---|
| `/register/client` | تسجيل عميل | Core identity/access | Core | منخفض | KEEP |
| `/register/clinician` | legacy alias لتسجيل الأخصائي | Core intake alias | Core | منخفض/متوسط بسبب alias | KEEP / RENAME LATER |
| `/register/center` | legacy alias لتسجيل المركز | Core intake alias | Core | منخفض/متوسط بسبب alias | KEEP / RENAME LATER |
| `/web/clinician/*` | clinician web registration/profile/sessions/documents | Professional intake + trust disclosure | Core + Trust | متوسط بسبب كلمة sessions/prices | KEEP مع wording review |
| `/web/center/*` | center web registration/profile/media/pricing/documents | Center intake + trust disclosure | Core + Trust | متوسط بسبب pricing لازم يظل disclosure | KEEP |

## Admin / Control

| Route | current purpose | current classification | target classification | risk | action |
|---|---|---|---|---|---|
| `/admin/hub` | admin overview hub | Control | Control | متوسط لو يستمد counters من legacy booking | KEEP مع فصل counters لاحقًا |
| `/admin/operations` | operational admin surface | Control | Control | متوسط | KEEP |
| `/admin/clinician-requests` | مراجعة انضمام الأخصائيين | Control + Trust | Control | منخفض | KEEP |
| `/admin/centers` | إدارة/مراجعة centers | Control + Center Enablement | Control | منخفض/متوسط | KEEP |
| `/admin/clinician-profile-requests` | profile change approvals | Control + Trust | Control | منخفض | KEEP |
| `/admin/support-chats` | support chat admin | Control + Client Support | Control | متوسط | KEEP |
| `/chat/escalations` | escalation queue | Control + Support | Control | متوسط | KEEP |
| `/admin/session-report` | reports around session/legacy workflow | Control + Legacy reports | Control + Legacy | عالي بسبب session semantics | FREEZE / RENAME LATER |
| `/admin/archive/*` | legacy archive surfaces | Control archive + Legacy | Control + Legacy/Quarantined حسب النوع | عالي في payments/accounting | KEEP archive only / QUARANTINE financial |
| `/admin/ai-policies` | AI policy management | Control | Control | متوسط لو AI يوحي بعلاج/تشخيص | KEEP |
| `/admin/system-domains` | domain status registry | Control | Control | منخفض | KEEP |
| `/admin/control-room/*` | guided workflows/references/monitoring/analytics shells | Control preview | Control | متوسط لو بقى execution engine | KEEP كـ preview/governance |

## Quarantined / Legacy Financial / Booking

| Route | current purpose | current classification | target classification | risk | action |
|---|---|---|---|---|---|
| `/admin/booking-queue` | queue لإدارة `booking_requests` | Quarantined legacy booking | Optional Booking Module candidate أو Burial Candidate | عالي جدًا | QUARANTINE / MODULE EXTRACT |
| `/admin/payments` | payment proof/confirmation surface على booking flow | Quarantined financial | Burial Candidate أو Optional Accounting Module خارج Core | عالي جدًا | FREEZE / QUARANTINE |
| `/admin/accounting` | accounting workspace | Quarantined financial | Optional Accounting Module only | عالي جدًا | FREEZE / MODULE EXTRACT |
| `/admin/sessions` | session lifecycle admin surface | Legacy booking/session | Optional Booking Module candidate أو Burial Candidate | عالي | FREEZE |
| `/client/payment-proof` | client upload payment proof | Quarantined financial | Remove Later أو module-scoped accounting/payment proof | عالي جدًا | FREEZE / BURIAL CANDIDATE |
| `/admin/archive/payments` | financial archive | Legacy financial archive | Quarantined archive | عالي | KEEP archive only / BURIAL CANDIDATE |
| `/admin/archive/accounting` | accounting archive | Legacy financial archive | Quarantined archive | عالي | KEEP archive only / BURIAL CANDIDATE |
| `/booking/my` | client booking list | Legacy booking | Optional Booking Module candidate أو Legacy | عالي | FREEZE / MODULE EXTRACT |

## Workspace / Optional Future Modules

| Route | current purpose | current classification | target classification | risk | action |
|---|---|---|---|---|---|
| `/workspace/marketing` | marketing workspace shell | Optional Module preview | Optional Marketing Suite | متوسط | MODULE EXTRACT |
| `/workspace/content` | content workspace shell | Optional Module preview | Optional Marketing/Education tooling | متوسط | MODULE EXTRACT |
| `/workspace/customer-follow-up` | customer follow-up workspace | Optional CRM/support preview | Optional CRM Module | متوسط/عالي لو يمسك care relationship | MODULE EXTRACT |
| `/workspace/external-follow-up*` | external follow-up registry/templates/campaigns | Optional CRM/Marketing preview | Optional CRM/Marketing Module | متوسط | MODULE EXTRACT |
| `/admin/growth-layer` | growth/admin preview | Optional Marketing/Control shell | Optional Marketing Suite | متوسط | MODULE EXTRACT |
| `/admin/employee-system` | employee ops shell | Control/optional internal ops | Optional internal module | متوسط | FREEZE until ownership |
| `/admin/maintenance` | maintenance ops shell | Control | Control | منخفض/متوسط | KEEP |
| `/admin/ai-devops` | AI/devops admin shell | Control/Optional AI | Optional AI/Translation Suite + Control | متوسط/عالي | KEEP shell / MODULE EXTRACT tooling |

---

# 4. Collection Classification Map

| Collection | current owner | target owner | current classification | target classification | allowed future direction | forbidden future direction |
|---|---|---|---|---|---|---|
| `clients` | auth/client profile | Client Support / Core identity | Core | Core | client account, support identity, consent/preferences | clinical record, payment ledger, treatment ownership |
| `clinicians` | clinician profile/intake/admin approval | Marketplace + Professional Enablement + Trust | Core | Core + Trust | public profile, disclosed services/prices, credentials, approval state | platform guarantee, central accounting, owned treatment relation |
| `centers` | center profile/intake/admin approval | Marketplace + Center Enablement + Trust | Core | Core + Trust | center page, services, prices as disclosure, documents | platform-owned clinic ops, payout/accounting core |
| `admins` | admin access/control | Control Domain | Control | Control | role governance and admin access | business domain data owner for all modules |
| `booking_requests` | booking/payment/session mixed workflow | Legacy Booking Requests Domain | Quarantined legacy | Frozen + Quarantined + Legacy Candidate | read legacy data, audit, compatibility, migration inventory | payment/accounting/payout expansion, new core platform, more cross-domain fields |
| `bookingRequests` | old/compat booking collection | Legacy compatibility | Legacy / Burial Candidate | Burial Candidate | read-denied compatibility marker, migration audit only | resurrecting writes, making it fallback core |
| `support_requests` | structured support | Client Support Domain | Core support | Core | non-clinical support, complaints routing, issue triage | diagnosis, treatment plan, financial settlement engine |
| `chat_threads` | chat/support flow | Client Support + Communication | Core support | Core | support chat, owner/assigned clinician conversation | booking/payment source of truth, medical record |
| `chat_escalations` | escalated chat cases/reports | Client Support + Control | Control + Core support | Control | escalation workflow, reports, human review | clinical guarantee, hidden treatment ownership |
| `sessionRatings` | reviews/ratings tied to requestId | Trust + Legacy session reviews | Mixed Trust/Legacy | Trust & Transparency with legacy bridge | provider/client ratings, transparency history, migration away from booking dependency | booking/payment/session lifecycle owner |
| `resources` | library content | Education & Library | Core | Core | articles/videos/exercises/resource metadata | therapy plans, diagnosis, unreviewed high-sensitivity tools |
| `system_health` | ops health snapshots | Control | Control | Control | read-only admin health | user-facing trust guarantee |
| `system_alerts` | ops alert snapshots | Control / Reports | Control | Control | Admin SDK written alerts, monitoring | client/provider domain state owner |
| `analytics_summaries` | cloud/admin analytics | Control / Reports | Control | Control | aggregate non-sensitive insights | individual care/payment ledger |
| `system_domains` | domain status registry | Control | Control | Control | domain status/freeze metadata | replacing proper domain-owned collections |
| `ai_policies` | AI policy drafts/published docs | Control + Optional AI | Control | Control / Optional AI module-scoped | AI boundaries, publishing policy, safety rules | diagnosis/treatment automation guarantee |
| `external_follow_up_registry` | external follow-up contacts/registry | External follow-up feature | Optional CRM Module | Optional CRM Module | tenant-scoped registry after extraction | central care relationship ownership |
| `external_follow_up_message_templates` | templates | External follow-up feature | Optional CRM/Marketing | Optional CRM/Marketing Module | tenant-scoped approved templates | clinical advice automation without policy |
| `external_follow_up_campaigns` | campaigns | External follow-up feature | Optional Marketing/CRM | Optional Marketing/CRM Module | campaigns/promotion/follow-up with consent | treatment plan engine or hidden booking dependency |
| `debug` | disabled debug collection | Debug/legacy dev | Burial Candidate | Burial Candidate | stay denied, remove after tooling audit | enabling broad debug writes |

Additional observed collections not required but important:

| Collection | current owner | target owner | classification | note |
|---|---|---|---|---|
| `clinician_profile_change_requests` | admin/profile change flow | Trust + Professional Enablement Control | Control | KEEP |
| `center_profile_change_requests` | admin/profile change flow | Trust + Center Enablement Control | Control | KEEP |
| `chat_threads/{id}/messages` | chat subcollection | Client Support | Core support | KEEP |
| `chat_escalations/{id}/reports` | escalation reports | Control + Support | Control | KEEP |

---

# 5. Service / Adapter Classification Map

| Service / Adapter | current purpose | current classification | target classification | risk | action |
|---|---|---|---|---|---|
| `AdminPaymentDecisionAdapter` | payment decision updates on `booking_requests` | Quarantined financial | Frozen / Remove Later | عالي جدًا | FREEZE |
| `AdminBookingDecisionAdapter` | admin booking state decisions on `booking_requests` | Quarantined legacy booking | Optional Booking Module candidate | عالي جدًا | QUARANTINE / MODULE EXTRACT |
| `AdminSessionDecisionAdapter` | session lifecycle decisions on `booking_requests` | Legacy booking/session | Frozen legacy | عالي | FREEZE |
| `AdminBookingCommandWrapper` | shadow/audit wrapper for booking admin commands | Control wrapper around quarantined booking | Control containment | متوسط/عالي | KEEP as containment only |
| `booking_health_service.dart` | health/audit for booking domain | Legacy/Control health | Quarantined health monitor | متوسط | KEEP for audit only |
| `center_inbox_service.dart` | center inbox for booking/requests | Legacy booking + Center Enablement | Optional Booking Module candidate | عالي | MODULE EXTRACT later |
| `center_request_inbox_service.dart` | center request inbox | Legacy booking/request | Optional Booking Module candidate | عالي | FREEZE |
| `booking_legacy_chat_adapter.dart` | bridge between booking and chat | Legacy compatibility adapter | Quarantined compatibility | عالي جدًا | FREEZE / REMOVE LATER |
| `chat_firestore_service.dart` | chat threads/escalations/messages | Client Support + Control | Core support | متوسط | KEEP |
| `chat_ai_service.dart` | AI support around chat | Optional AI + Support | Optional AI/Translation Suite controlled by support policy | متوسط/عالي | MODULE EXTRACT / policy-gate |
| `chat_health_service.dart` | chat/domain health status | Control health | Control | منخفض | KEEP |
| `ChatEscalationCommandWrapper` | command wrapper/audit for chat escalation actions | Control around support escalation | Control | متوسط | KEEP |
| `support issue selector flow` | structured support request creation | Client Support | Core support | متوسط بسبب payment/booking options | KEEP with language cleanup later |
| `AppAnalytics` | client-side analytics events | Reports/Insights | Control analytics | متوسط | KEEP with privacy boundaries |
| `functions/index.js analytics summaries` | scheduled/Cloud analytics summaries | Reports/Insights | Control analytics | متوسط | KEEP, no individual care ledger |
| `Admin clinician/center approval services/pages` | approve/block profile/intake state | Trust + Control | Control + Trust | منخفض/متوسط | KEEP |
| `centers_firestore_service.dart` | center marketplace data access | Marketplace + Center Enablement | Core | منخفض | KEEP |
| `center_storage_service.dart` | center media/docs storage helper | Center Enablement + Trust | Core + Trust | متوسط | KEEP |
| `library/resources pages/services` | resources/library display | Education & Library | Core | منخفض | KEEP |
| `follow_up_registry_service.dart` | external follow-up registry | Optional CRM | Optional CRM Module | متوسط | MODULE EXTRACT |
| `follow_up_message_template_service.dart` | follow-up templates | Optional CRM/Marketing | Optional CRM/Marketing Module | متوسط | MODULE EXTRACT |
| `follow_up_campaign_service.dart` | follow-up campaigns | Optional Marketing/CRM | Optional Marketing Suite / CRM Module | متوسط | MODULE EXTRACT |
| `ai_policy_health_service.dart` | AI policy health/readiness | Control | Control | متوسط | KEEP |
| `gateway_health_service.dart` | gateway layer health | Control/gateway preview | Control | متوسط | KEEP shell only |

Core services:

* chat support services, when they stay non-clinical support.
* center/clinician marketplace profile services.
* library/resources services.
* trust/approval services for provider disclosure and profile changes.

Quarantined services:

* payment decision adapter.
* booking decision adapter.
* session decision adapter when attached to `booking_requests`.
* booking legacy chat adapter.

Optional Module candidates:

* booking inbox/services.
* external follow-up services.
* marketing/content/growth workspaces.
* AI productivity/translation surfaces.

Legacy:

* `bookingRequests` compatibility.
* `booking_requests` lifecycle command surfaces.
* financial archive pages sourced from `booking_requests`.

---

# 6. Domain Ownership Map

| Domain | owns | does not own | collections | routes | roles | reports | rules direction | archive behavior |
|---|---|---|---|---|---|---|---|---|
| Marketplace Domain | provider discovery, clinician/center profiles, services display, declared prices | payment, payout, accounting, treatment, diagnosis, booking dependency | `clinicians`, `centers` | `/menu`, `/module/specialists*`, `/module/centers*`, `/clinician/*` profile parts, `/center/*` profile parts | client, clinician, center, admin control | marketplace visibility metrics | public/approved read with provider-owned writes | archive profile changes separately |
| Trust & Transparency Domain | credentials, licenses, documents, verification sources, ratings, comments, complaints visibility | platform guarantee, government licensing, treatment outcome guarantee | `clinicians`, `centers`, `sessionRatings`, profile change request collections | `/web/clinician/*`, `/web/center/*`, `/admin/clinician-requests`, `/admin/clinician-profile-requests`, `/admin/centers` | provider, admin, client reviewer | trust history, complaints, review summaries | disclosure-first, no fake guarantee writes | immutable/reviewable transparency history |
| Client Support Domain | support, prevention, complaint links, hotlines, non-clinical guidance | diagnosis, therapy, treatment plan, payment settlement | `support_requests`, `chat_threads`, `chat_escalations` | `/chat`, `/module/support-issue-selector`, `/admin/support-chats`, `/chat/escalations` | client, clinician assignee, admin | support load, escalation reports | owner/assignee/admin scoped | archive support threads/reports without financial ownership |
| Education & Library Domain | articles, exercises, video, audio, prevention content | diagnosis, therapy, personalized plans | `resources` | `/module/library`, `/web/library` | all signed-in users, admin editors | resource usage and review state | signed-in read, admin write | content retirement/version archive |
| Professional Enablement Domain | professional tools, reports, content creation, AI assistant, marketing tools | session payment ownership, platform commission | `clinicians`, optional module collections later | `/clinician/*`, `/workspace/content`, `/workspace/marketing` | clinician, admin | professional performance/productivity | provider-owned or tenant-scoped | archive tools outputs by provider/module |
| Center Enablement Domain | center profile, services, prices disclosure, licenses, marketing/content, courses hooks | center accounting as platform core, payout, treatment ownership | `centers` | `/center/*`, `/web/center/*`, `/admin/centers` | center, admin | center visibility/approval | center-owned updates with admin review | archive center profile changes/docs |
| Control Domain | admin hub, governance, monitoring, domain registry, policies, alerts | owning all business domains directly | `admins`, `system_domains`, `ai_policies`, `system_health`, `system_alerts`, `analytics_summaries` | `/admin/hub`, `/admin/operations`, `/admin/system-domains`, `/admin/ai-policies`, `/admin/control-room/*` | admin | health, alerts, aggregate analytics | admin-only, SDK-only writes where needed | archive decisions/audits, not care/payment records |
| Optional Booking Module | appointment requests, availability, scheduling coordination | Mental Smile core, payment, accounting, payout | future module-scoped collections, not `booking_requests` as-is | future module routes, current `/booking/*` only as legacy bridge | tenant/provider/client depending module | booking ops only | module-scoped after extraction | module archive, not core archive |
| Optional Accounting Module | internal invoices, payments, center/pro accounting | platform commission core, marketplace ownership | future tenant-scoped accounting collections | `/admin/accounting` only as frozen preview/legacy | provider/center tenant admin | financial internal reports | tenant-scoped, not core rules | financial archive inside module |
| Optional CRM Module | provider-owned client management/follow-up | central care relationship ownership | `external_follow_up_*` currently, future tenant collections | `/workspace/customer-follow-up`, `/workspace/external-follow-up*` | provider/center/admin depending tenant | follow-up/campaign reports | tenant-scoped with consent | tenant archive/retention policy |
| Optional Verification Service | premium document review, review record, badge | government licensing authority, universal guarantee | future `verification_reviews` style collection | future verification routes/admin review | provider, reviewer/admin | badge expiry/review cycle | policy-bound review records | immutable review cycle archive |
| Optional Academy Module | courses, diplomas, training spaces | clinical certification guarantee unless policy | future academy collections | future academy routes | center/provider/admin/student | enrollment/course summaries | module-scoped | course/archive by issuer |
| Optional Marketing Suite | campaigns, content, landing pages, promotion | therapy claims, hidden care dependency | `external_follow_up_campaigns` possibly after extraction | `/workspace/marketing`, `/admin/growth-layer` | admin/provider/center | campaign reports | tenant/module-scoped | campaign archive |
| Optional AI/Translation Suite | translation, content tools, productivity, multilingual support | diagnosis, treatment plan, automated care guarantee | `ai_policies` for control, future AI module collections | `/admin/ai-devops`, AI productivity surfaces | admin/provider/center | AI policy/usage reports | policy-gated, audit required | prompt/policy/version archive |
| Legacy Booking Requests Domain | legacy booking/payment/session mixed records | any future core platform authority | `booking_requests`, `bookingRequests` | `/admin/booking-queue`, `/booking/my`, `/client/payment-proof`, legacy session/payment/admin routes | admin/client/clinician/center historically | legacy reports only | freeze, read compatibility, no expansion | archive then bury |

---

# 7. Booking Requests Freeze Map

`booking_requests` تصنف رسميًا:

```text
Frozen + Quarantined + Legacy Candidate
```

الـ Booking ليس Core Domain.

الـ Booking هو:

```text
Optional Capability Module
```

## ممنوع

* توسيعها
* إضافة payment/accounting/payout
* بناء Core Platform عليها
* اعتبارها قلب المنصة
* إنشاء `service_requests` بنفس نفس المشكلة
* ربط marketplace discovery بها كشرط
* تحويلها إلى source of truth للتقييمات أو الشكاوى أو التقارير العامة
* إضافة commission أو settlement أو payout fields

## مسموح مؤقتًا

* read legacy data
* minimal bug fixes
* compatibility support
* audit/inventory only
* containment wrappers
* freeze documentation
* migration readiness reports

## اتجاه مستقبلي

* extract as optional Booking Module
* migrate to clean module
* bury as legacy

أي migration لاحق لازم يفصل:

* request intake
* appointment coordination
* payment/accounting
* ratings/reviews
* support complaints
* reports/archive

ولا يكرر cross-domain collection.

---

# 8. Financial Cycle Freeze Map

كل شيء مرتبط بـ:

* payment proof
* payment confirmation
* payout
* accounting
* commission
* settlement
* financial archive

يصنف كالتالي:

```text
Frozen / Quarantined / Remove Later
```

| Area | current surface | classification | target | priority |
|---|---|---|---|---|
| payment proof | `/client/payment-proof`, booking fields | Quarantined financial | Remove Later أو module-scoped | freeze now |
| payment confirmation | `/admin/payments`, `AdminPaymentDecisionAdapter` | Quarantined financial | Remove Later | freeze now |
| payout | implicit/legacy financial semantics | Quarantined | Burial Candidate | hide later |
| accounting | `/admin/accounting`, `/admin/archive/accounting` | Quarantined accounting | Optional Accounting Module only | freeze now |
| commission | forbidden by constitution for core | Burial Candidate if present | Remove Later | block writes later |
| settlement | forbidden for core | Burial Candidate if present | Remove Later | block writes later |
| financial archive | `/admin/archive/payments`, `/admin/archive/accounting` | Legacy financial archive | Read-only legacy archive then bury | archive legacy later |

أولويات التنفيذ المستقبلية:

1. freeze now: منع أي features جديدة أو توسيع في financial cycle.
2. hide later: إخفاء الأسطح المالية من core navigation بعد موافقة المالك.
3. block writes later: قواعد تمنع writes جديدة بعد migration readiness.
4. archive legacy later: حفظ السجلات القديمة كـ audit/read-only.
5. bury later: إزالة routes/services بعد تأكيد عدم وجود اعتماد runtime عليها.

---

# 9. Rules Impact Preview

هذا القسم preview فقط. لا يتم تعديل Firestore rules الآن.

## rules التي يجب عدم لمسها الآن

* `clients`
* `clinicians`
* `centers`
* `support_requests`
* `chat_threads`
* `chat_escalations`
* `resources`
* `admins`
* `system_domains`
* `ai_policies`

السبب: هذه تحتاج phase منفصل فيه tests واضحة، وبعضها Core/Control حساس.

## rules التي يجب تجميدها

* `booking_requests`
* `bookingRequests`
* أي rules مرتبطة بكتابة payment/session/accounting داخل legacy booking flow

التجميد لا يعني تعديل الآن. يعني لا يتم توسيع permissions أو إضافة حالات جديدة.

## rules التي تحتاج إعادة تصميم

* `booking_requests`: يجب أن تتحول لاحقًا إلى read compatibility أو module-scoped migration path.
* `sessionRatings`: تحتاج فصل Trust/Transparency عن requestId legacy dependency.
* `support_requests`: تحتاج wording/policy يمنع تحولها لتسوية مالية أو تشخيص.
* `external_follow_up_*`: تحتاج tenant-scoped model قبل أي توسع.

## rules التي ستصبح module-scoped

* future booking module rules
* future accounting module rules
* future CRM/follow-up rules
* future verification service rules
* future marketing suite rules
* future AI/translation suite rules

## tests المطلوبة قبل أي تعديل rules

* admin can still read/control Control collections.
* client can access own Core support/profile data only.
* provider can update own disclosed profile fields only.
* public/approved marketplace reads لا تكشف private documents.
* `booking_requests` writes are blocked or constrained حسب freeze phase.
* `bookingRequests` stays denied unless migration test explicitly needs read.
* payment/accounting writes fail outside module scope.
* chat owner/assignee/admin permissions remain correct.
* support requests do not allow diagnosis/treatment/financial settlement fields as authority.
* external follow-up access is tenant-scoped before activation.

---

# 10. First Safe Execution Packages

هذه packages مقترحة للمستقبل فقط. لا يوجد تنفيذ في هذا التقرير.

## Package 1: Documentation Freeze

* اعتماد هذا التقرير.
* ربطه بالدستور.
* وضعه كمرجع لأي route/rule/collection change.
* لا runtime changes.

## Package 2: Navigation Visibility Audit

* حصر كل links المؤدية إلى booking/payment/accounting.
* تحديد ما يظهر للمستخدم وما يظهر للأدمن.
* لا حذف routes.
* لا تعديل rules.

## Package 3: Booking Legacy Inventory

* inventory لكل fields داخل `booking_requests`.
* فصل fields حسب domain: request, booking, payment, session, review, archive, report.
* تقرير migration options فقط.

## Package 4: Financial Cycle Containment Plan

* تحديد payment/accounting/payout/commission/settlement surfaces.
* تصميم freeze ثم hide ثم block writes.
* لا تنفيذ قبل owner approval.

## Package 5: Trust Layer Cleanup Plan

* فصل ratings/comments/complaints عن booking lifecycle.
* تصميم transparency history.
* تصميم optional Verification Service بدون fake guarantee.

## Package 6: Optional Module Extraction Blueprint

* Booking Module blueprint.
* Accounting Module blueprint.
* CRM Module blueprint.
* Marketing Suite blueprint.
* AI/Translation Suite blueprint.

---

# 11. Final Verdict

Mental Smile core يجب أن يبقى:

```text
Marketplace
+
Trust Through Transparency
+
Client Support
+
Education & Library
+
Professional / Center Enablement
```

`booking_requests` ليست القلب.

الـ financial cycle ليس core.

Control Domain لا يعني Super Admin Platform.

Optional Modules ممكن تتأجر أو تتفعل أو تتفصل، لكن ممنوع تتحول لاعتماد مخفي داخل core platform.

هذا التقرير لا يعدل Runtime.
هذا التقرير لا يعدل Firestore rules.
هذا التقرير لا يحذف routes أو collections.
هو فقط خريطة تصنيف وتجميد قبل التنفيذ.
