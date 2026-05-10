# FLOATING CHANGES CLOSEOUT REPORT
## Mental Smile

## 1. Summary
- عدد الملفات العائمة: 3 ملفات.
- الملفات:
  - `firestore.rules`
  - `firestore.indexes.json`
  - `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- لماذا تتم مراجعتها الآن: هذه الملفات بقيت modified بعد Commit `chore: clean repository before production clone`، ولازم يتحدد مصيرها قبل بدء `PHASE 2 — SECURITY HARDENING` حتى لا تدخل تغييرات غير مفهومة في security work أو Production Clone.
- التوصية العامة: لا يتم commit الآن ولا revert الآن. يتم الاحتفاظ بها مؤقتًا كـ floating changes تحت مراجعة Phase 2، مع فصل ملف clinician لاحقًا عن تغييرات الأمن لأنه يحتوي UI/behavior وليس security hardening فقط.

## 2. firestore.rules Review
- نوع التغييرات: إعادة كتابة كبيرة جدًا لملف Firestore Rules.
- ملخص الفروقات:
  - تم تقليل الملف من حوالي 2433 سطر إلى حوالي 447 سطر.
  - تم حذف عدد كبير من helper functions القديمة الخاصة بـ booking lifecycle مثل `clientPaymentProofUpdateValid`, `adminForwardValid`, `adminClinicianForwardValid`, `centerQuoteFrozenGuardValid`, وbridge validators متعددة.
  - تم استبدال `isAdmin()` المعتمد على `admins/{uid}.active == true` بمنطق أقرب إلى custom claims.
  - تم تغيير read/write rules لمجموعات رئيسية: `clients`, `clinicians`, `centers`, `booking_requests`, `sessionRatings`, `support_requests`, `chat_threads`, `chat_escalations`, `admins`, `resources`, `external_follow_up_*`.
  - تم تغيير public/read behavior لبعض المسارات مثل `resources` من read عام إلى signed-in read.
  - تم تغيير `support_requests` من validation مفصل لـ `supportType`, `issueType`, `priority`, `createdAt` إلى validation أبسط.
  - تم تغيير `admins/{adminId}` إلى `allow read, write: if isAdmin()` بدل منع write سابقًا.
- تقييم الخطورة:
  - Critical
- القرار:
  - KEEP_FOR_PHASE_2
- السبب:
  - التغيير متعلق مباشرة بالأمان وproduction readiness، لكنه كبير جدًا وغير آمن للـ commit بدون اختبار rules matrix لكل الأدوار وكل flows.
  - التغيير قد يكسر booking/payment/session/chat/support flows بسبب حذف validators تفصيلية كانت موجودة.
  - التغيير قد يكون intentional كبداية hardening، لكنه يحتاج Phase 2 review وليس commit عابر.

## 3. firestore.indexes.json Review
- نوع التغييرات: توسيع وإعادة تنظيم composite indexes.
- ملخص الفروقات:
  - تم إضافة indexes جديدة لـ `booking_requests` على `clientId/status/createdAt`, `clinicianUid/status/createdAt`, `assignedClinicianId/status/createdAt`, `centerId/status/createdAt`, و`archived/createdAt`.
  - تم إضافة indexes لـ `sessionRatings` تشمل `clinicianId/reviewerType/createdAt`, `clientId/createdAt`, و`centerId/createdAt`.
  - تم إضافة indexes لـ `clinicians` تشمل `approvalStatus/isActive/specialtyKey/sortOrder` و`approvalStatus/isActive/specialty/sortOrder`.
  - تم تعديل center indexes لتشمل `approvalStatus/isActive/category/sortOrder` و`approvalStatus/isActive/city/sortOrder`.
  - تم إضافة indexes لـ `center_profile_change_requests`, `clinician_profile_change_requests`, `support_requests`, `chat_threads`, collection group `messages`, وcollection group `reports`.
  - يوجد تغيير تنسيق JSON إلى inline field objects في أجزاء كثيرة.
- تقييم الخطورة:
  - Important
- القرار:
  - KEEP_FOR_PHASE_2
- السبب:
  - التغيير غالبًا intentional ومفيد لتقليل index runtime errors، خصوصًا مع `sessionRatings` وapproved/active filters.
  - لكنه مرتبط بنمط queries الحالي ويحتاج مطابقة دقيقة مع كل where/orderBy قبل commit/deploy.
  - لا يجب نشر indexes قبل حسم `firestore.rules` لأنهما جزء من security readiness package.

## 4. clinician_operations_page.dart Review
- نوع التغييرات: تغييرات UI/behavior داخل صفحة عمليات الأخصائي، مع تعديل query واحد للتقييمات.
- ملخص الفروقات:
  - تم تغيير `_clinicianHomeActionsEnabled` من `false` إلى `true`.
  - تم استبدال home summary القديم بواجهة `_buildOperationsActions` تحتوي 4 أزرار: `فتح الحالات`, `إرسال طلب دعم`, `تعديل بياناتي`, `جلساتي`.
  - تم حذف app bar الخاص بـ `AppShellActions.buildAppBar` من حالتي loading/main.
  - تم إزالة sections وصفية مثل header/chat summary/ratings/profile workspace من الـ home summary الرئيسي.
  - تم إخفاء empty state في assignments list باستبداله بـ `SizedBox.shrink`.
  - تم استبدال `ChoiceChip` filters بـ `_FilterPill`.
  - تم إضافة `where('reviewerType', isEqualTo: 'client')` إلى query `sessionRatings`.
  - تم إضافة widgets جديدة: `_OperationActionButton` و`_FilterPill`.
- تقييم الخطورة:
  - Important
- القرار:
  - KEEP_FOR_PHASE_2
- السبب:
  - جزء صغير فقط مرتبط بصحة البيانات وهو فلتر `reviewerType == client`.
  - أغلب التغيير UI/behavior وليس Security Hardening، خصوصًا تفعيل `_clinicianHomeActionsEnabled` وإزالة app bar/sections.
  - لا يجب commit الملف مع rules/indexes كحزمة أمنية واحدة قبل قرار منتج واضح: إما فصل rating query fix في commit مستقل، أو revert UI changes، أو اعتماد redesign لاحقًا.

## 5. Recommended Action
KEEP_FLOATING_CHANGES_FOR_PHASE_2

السبب المختصر: `firestore.rules` و`firestore.indexes.json` مرتبطان مباشرة بـ Phase 2 لكن غير جاهزين للcommit قبل review/testing، و`clinician_operations_page.dart` يحتوي تغييرات مختلطة UI + behavior + rating query لذلك يجب إبقاؤه عائمًا لحين فصل القرار.

## 6. Proposed Commit Message
- لا يوجد commit مقترح الآن لأن القرار النهائي ليس `COMMIT_FLOATING_CHANGES`.

## 7. Final Git Status
```text
On branch main
Your branch is ahead of 'origin/main' by 2 commits.

Changes not staged for commit:
  modified:   firestore.indexes.json
  modified:   firestore.rules
  modified:   lib/features/clinician/presentation/pages/clinician_operations_page.dart

Untracked files:
  docs/release/FLOATING_CHANGES_CLOSEOUT_REPORT.md
```
