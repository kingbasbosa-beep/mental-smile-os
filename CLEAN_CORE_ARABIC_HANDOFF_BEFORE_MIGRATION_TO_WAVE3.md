# Mental Smile / Mental Key V2 - Clean Core Handoff

## 1. اسم المشروع والوضع العام

اسم المشروع الحالي في `pubspec.yaml` هو:

- `flutterprojects`

وصف المشروع:

- `Mental Smile / Mental Key V2`

اسم الباكدج الجديدة التي يتم نقل العقود النضيفة إليها:

- `mental_smile_clean_core`

وصف الباكدج:

- Pure Dart governance and boundary contracts for Mental Smile.

المسار الحالي:

- `C:\mental_smile_workspace\app\mental-smile-app-clean2`

الفكرة العامة: المشروع بدأ كتطبيق Flutter/Firebase كامل، ثم بدأنا نفصل منه
العقود النضيفة القابلة لإعادة الاستخدام داخل باكدج مستقلة اسمها
`mental_smile_clean_core`. التحويل إلى Clean Core لا يعني نقل كل شيء. النقل
مسموح فقط للمعاني الآمنة: pure Dart contracts, passive metadata, vocabulary,
references. أما التنفيذ، Firebase، Firestore، runtime، providers، routing،
emergency، backend enforcement، والمابرز تظل داخل التطبيق المضيف.

## 2. حالة المشروع قبل المايجريشن

قبل موجات Clean Core، المشروع كان تطبيق Flutter Web-first مع Firebase/Firestore
مباشرة داخل التطبيق.

الحالة القديمة من savepoint:

- MVP demo-ready.
- الهدف الأساسي للتطوير: Web/Chrome.
- Firebase و Firestore القراءة والكتابة شغالين.
- Firestore rules اتشدت في مرحلة C4.
- UI friendly default.
- dev hooks خلف `--dart-define=MK_DEV=true`.
- assets C5 و C6 متضافة ومربوطة في `pubspec.yaml`.
- C6 Library UI متنفذة.

الأدوار الأساسية:

- Client يرسل booking request.
- Admin يراجع ويفوروارد للclinician.
- Clinician يوافق أو يرفض.
- Admin يتعامل مع الدفع خارج التطبيق، ثم ينشئ Zoom/session code.

الموديل القديم المهم:

- `booking_requests`
- `clinicians`
- planned: `sessions`
- planned: `payments`

قبل المايجريشن، المنطق كان متداخل: UI، Firebase، Firestore، governance،
audit، human review، provider/runtime semantics كلها موجودة داخل التطبيق
المضيف بدرجات مختلفة.

## 3. هدف التحويل إلى Clean Core

الهدف ليس عمل package ضخمة تنقل التطبيق كله. الهدف هو فصل العقود النضيفة
المشتركة:

- audit contracts
- human review contracts
- governance/reference/passive labels
- boundary-safe metadata
- trusted/backend/policy/safety vocabularies عندما تكون passive فقط

الممنوع نقله كـ package public API:

- Firestore persistence
- Firebase types
- `Timestamp`
- `FieldValue`
- `toMap/fromMap` داخل vocab passive
- runtime/provider execution
- queue admission
- routing
- emergency guarantees
- backend enforcement proof
- client write permissions
- provider causality
- retry/fallback recovery

قاعدة مهمة: Pure Dart ليس معناه package-safe تلقائيا. الاسم نفسه ممكن يدي
وعد كاذب حتى لو enum بسيط.

## 4. Wave 1 - Audit Extraction / Recovery

الموجة الأولى ركزت على استخراج audit contracts إلى
`mental_smile_clean_core`.

الموجود الآن داخل:

- `mental_smile_clean_core/lib/src/audit/`

العقود العامة الحالية تشمل:

- `audit_actor_type.dart`
- `audit_event.dart`
- `audit_event_type.dart`
- `audit_hash_placeholder.dart`
- `audit_processing_context.dart`
- `audit_redaction.dart`
- `audit_reference.dart`
- `audit_retention_policy.dart`
- `audit_severity.dart`
- `audit_snapshot.dart`
- `audit_trace.dart`
- `audit_visibility_scope.dart`

الذي تحقق:

- audit أصبح له surface نضيف داخل الباكدج.
- العقود pure Dart.
- لا يوجد Firestore/Firebase داخل عقود الباكدج.
- المابرز ظلت host-side.

المابرز التي بقيت داخل التطبيق المضيف:

- `clean_core/lib/core/audit/firestore/audit_event_firestore_mapper.dart`
- `clean_core/lib/core/audit/firestore/audit_snapshot_firestore_mapper.dart`
- `clean_core/lib/core/audit/firestore/audit_trace_firestore_mapper.dart`

معنى هذا: الباكدج تصف audit data وreferences، لكنها لا تثبت أن audit تم حفظه،
ولا تثبت backend enforcement، ولا trace validity، ولا privacy proof.

## 5. Wave 2 - Human Review Extraction

الموجة الثانية ركزت على استخراج human review contracts الآمنة.

الموجود الآن داخل:

- `mental_smile_clean_core/lib/src/human_review/`

العقود العامة الحالية تشمل:

- `escalation_assignment.dart`
- `escalation_audit_link.dart`
- `escalation_level.dart`
- `escalation_policy_reference.dart`
- `escalation_reason.dart`
- `escalation_request.dart`
- `escalation_resolution.dart`
- `escalation_review.dart`
- `escalation_state.dart`
- `review_priority.dart`
- `review_visibility_scope.dart`
- `passive_review_signal.dart`

المابرز بقيت host-side:

- `clean_core/lib/core/human_review/firestore/escalation_assignment_firestore_mapper.dart`
- `clean_core/lib/core/human_review/firestore/escalation_request_firestore_mapper.dart`
- `clean_core/lib/core/human_review/firestore/escalation_resolution_firestore_mapper.dart`
- `clean_core/lib/core/human_review/firestore/escalation_review_firestore_mapper.dart`

الذي تحقق:

- request/review/resolution contracts اتنقلت كباكدج آمنة.
- Firestore mapping لم ينتقل.
- لا يوجد activation للruntime أو Firebase.
- لا يوجد reconnect شامل للمستهلكين بدون wave مخصصة.

المهم: Human Review contracts لا تعني أن في reviewer اتعين فعلا، ولا أن queue
قبلت الطلب، ولا أن emergency handling موجود، ولا أن backend نفذ شيء.

## 6. Wave 3 - Queue/Boundary Governance

هذه كانت أخطر موجة لأنها راجعت queue و boundary semantics قبل أي exposure.

الملفات الأصلية الخطرة التي تمت مراجعتها:

- `clean_core/lib/core/human_review/escalation_queue.dart`
- `clean_core/lib/core/human_review/escalation_boundary_marker.dart`

أهم نتيجة:

- `EscalationQueue.accepts` ليس metadata.
- هو routing/policy/orchestration logic.
- لذلك لا يجوز تصديره كعقد package.

الأعلام الخطرة:

- `backendGoverned`
- `clientOutcomeWritesAllowed`
- `emergencyGuarantee`
- `providerFailure`
- `fallbackLoop`

القرارات:

- queue exposure blocked في شكله الحالي.
- boundary marker exposure blocked في شكله الحالي.
- `backendGoverned` backend-only contract.
- `clientOutcomeWritesAllowed` host/backend-only.
- `emergencyGuarantee` ممنوع أن يصبح package-facing promise.
- `providerFailure` و `fallbackLoop` لا يصلحان public إلا بعد detox شديد،
  وبقيا holdback.

تم إنشاء vocabulary passive داخلي غير مصدر:

- `queue_passive_label.dart`
- `boundary_passive_label.dart`
- `emergency_posture_label.dart`
- `provider_issue_label.dart`
- `fallback_observation_label.dart`

ثم تم السماح بتصدير ضيق جدا فقط:

- `passive_review_signal.dart`

القيم العامة المصدرة:

- `policyIssueObserved`
- `manualSupportRequested`
- `policyReferencePresent`
- `auditReferencePresent`
- `emergencyCapabilityNotGuaranteed`

القيم التي بقيت internal/holdback:

- `safetyConcernObserved`
- `reviewStatePending`
- `reviewBoundaryObserved`
- `providerIssueReported`
- `fallbackLoopObserved`

معنى `PassiveReviewSignal`: labels سلبية/passive فقط. ليست commands، ولا
permissions، ولا workflow states، ولا routing decisions، ولا emergency handling،
ولا backend proof.

## 7. بعد Wave 3 - Runtime/Provider Doctrine Wave

بعد Wave 3 اتعملت موجة doctrine إضافية للruntime/provider من EX-113 إلى
EX-122. هذه لم تضف package surface جديد، لكنها أغلقت الباب على مفاهيم خطيرة.

القرار:

- لا runtime/provider diagnostic package contracts.
- لا runtime/provider mappers.
- لا runtime/provider exports.
- لا activation للproviders/adapters/Firebase/runtime.

الـ safe overlap الوحيد:

- `PassiveReviewSignal.auditReferencePresent`
- `PassiveReviewSignal.policyReferencePresent`

holdbacks runtime/provider:

- `providerIssueReported`
- `providerCapabilityGapObserved`
- `fallbackLoopObserved`
- `fallbackOnlyModeObserved`
- `runtimeDisabledObserved`
- `backendUnavailableObserved`

الممنوع:

- provider causality claims
- runtime execution guarantees
- retry/recovery guarantees
- fallback recovery claims
- provider trust proof
- adapter execution proof
- moderation/safety ownership
- emergency handling guarantees
- telemetry/privacy proof
- backend enforcement proof
- runtime/provider public mappers
- runtime/provider package contracts

## 8. Current Package Surface

الباريل الحالي:

- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

يصدر حاليا مجموعات:

- audit
- backend boundaries
- governance capability/compliance/federation/kernel/lifecycle
- human review
- policy runtime
- safety decision
- trusted backend
- trusted pipeline

ملاحظة مهمة: وجود أسماء مثل runtime marker أو policy runtime في الباكدج لا يعني
أن runtime execution انتقل للباكدج. هذه عقود/markers قديمة موجودة في السطح،
لكن موجة runtime/provider لم تضف diagnostics أو mappers أو execution contracts.

## 9. حدود Host vs Package

Package مسؤول عن:

- pure Dart contracts
- passive labels
- references
- request/review/resolution shapes
- audit/event/snapshot/trace vocabulary
- metadata التي لا تنفذ شيئا

Host/backend مسؤول عن:

- Firestore
- Firebase
- persistence
- toMap/fromMap
- routing
- queue admission
- reviewer assignment
- backend enforcement
- outcome writes
- emergency handling
- provider selection
- adapter invocation
- runtime execution
- guard decisions
- fallback handling
- retry/recovery
- telemetry/privacy proof

## 10. أهم الدروس والقواعد

لا تعمل الآتي بدون wave صريحة:

- لا تشغل `pub get`.
- لا تشغل `analyze`.
- لا تغير imports/exports.
- لا تعمل reconnect consumers.
- لا تنقل mappers إلى الباكدج.
- لا تضيف `toMap/fromMap` إلى passive labels.
- لا تصدر queue أو boundary marker.
- لا تصدر `EscalationQueue.accepts`.
- لا تعمل runtime/provider diagnostics.
- لا تضيف provider/fallback/retry labels كـ public API.

قاعدة ذهبية:

> الباكدج تصف facts فقط. التطبيق المضيف والbackend هما فقط من يقرران التنفيذ،
> التوجيه، الإنفورسمنت، الطوارئ، الكتابة، والruntime/provider causality.

## 11. Rollback Strategy

الrollback مقسم:

- Audit contracts: إزالة exports/files وإرجاع host imports لو لزم.
- Human review contracts: إزالة exports/files وإرجاع host imports لو لزم.
- Firestore mappers: rollback host-local.
- Passive vocabulary: حذف الملفات الداخلية أو إزالة export
  `passive_review_signal.dart`.
- Runtime/provider doctrine: documentary فقط لأنه لم يضيف source surface.

## 12. ماذا يجب أن يعرف الشات الجديد

لو شات جديد هيكمل، يبدأ من هذه الحقائق:

- المشروع الأساسي `flutterprojects` / `Mental Smile / Mental Key V2`.
- المسار `C:\mental_smile_workspace\app\mental-smile-app-clean2`.
- الهدف تحويل أجزاء آمنة إلى `mental_smile_clean_core`.
- Audit و Human Review تم استخراجهم جزئيا بنجاح.
- Queue/Boundary تم عمل governance لهم، وليس exposure كامل.
- Runtime/Provider تم عمل holdback doctrine لهم، وليس implementation.
- أي export جديد هو قرار governance وليس تعديل بسيط.
- أي mapper أو Firebase type داخل package هو خطر.

## 13. أفضل Next Wave

الأفضل بعد هذا الهاند أوف:

- Documentation registry/index لكل docs.
- Package surface verification.
- Host-side mapper containment verification.
- Consumer readiness review بدون تغيير imports.

لا تبدأ implementation wave إلا لو الطلب القادم واضح جدا ويحدد:

- هل المطلوب docs فقط؟
- هل مسموح source changes؟
- هل مسموح exports؟
- هل مسموح mappers؟
- هل مسموح consumer migration؟
- هل مسموح analyze؟

## 14. الخلاصة النهائية

المشروع كان Flutter/Firebase app متكامل اسمه العملي `Mental Smile / Mental Key
V2`. تم البدء في تحويل الأجزاء النضيفة إلى package اسمها
`mental_smile_clean_core`.

حتى Wave 3، الذي تم بناؤه فعليا:

- Audit contracts package-safe.
- Human Review contracts package-safe جزئيا.
- Queue/Boundary dangerous semantics تم حظرها.
- PassiveReviewSignal اتصدر كسطح ضيق وآمن.
- مابرز Firestore بقيت host-side.
- runtime/provider لم يتم فتحه للباكدج.

الحالة الصحية للمشروع الآن: Clean Core migration متقدمة لكن محكومة. يجب
الاستمرار بنفس الانضباط: facts فقط داخل package، التنفيذ والسلطة داخل
host/backend.
