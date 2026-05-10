# PRE-MIGRATION AUDIT REPORT
## Mental Smile Flutter/Firebase Project

## 1. Executive Summary
- الحالة العامة: المشروع يعمل كـ Flutter/Firebase app كبير يحتوي Mobile App، Web Registration، Admin Control Room، Dashboards، Routing، Assets، وFirestore Rules، لكن حالة المستودع الحالية غير نظيفة قبل النقل.
- يصلح كـ Legacy Archive: نعم، لكن ليس من الحالة المحلية الحالية قبل حسم التعديلات غير المحفوظة في `firestore.rules` و`firestore.indexes.json` و`lib/features/clinician/presentation/pages/clinician_operations_page.dart`.
- يصلح كأساس لنسخة Production Clean: يصلح فقط بعد إصلاح مخاطر محددة قبل النسخ.
- [Critical] أهم خطر: `git status` يظهر تعديلات غير محفوظة وملفات جديدة غير متتبعة، لذلك GitHub `origin/main` ليس مطابقًا لحالة المشروع الحالية.
- [Critical] أهم خطر: `test/node_modules/` متتبع داخل Git بعدد 9969 ملف، وهذا يلوث النسخة النظيفة ويزيد حجم ومخاطر النقل.
- [Critical] أهم خطر: `lib/core/auth/account_access_service.dart` يعتمد على Firestore role fields وعلى `kKnownPrimaryAdminUid` hardcoded بدل custom claims موثوقة.
- [Important] أهم خطر: `storage.rules` يسمح لأي مستخدم مسجل بقراءة ملفات `centers/{uid}`، ولا يحتوي حدود نوع/حجم أو مراجعة إدارية.
- [Important] أهم خطر: debug traces كثيرة مثل `ACCESS_TRACE` و`ADMIN_GUARD` و`CENTER_TRACE` داخل ملفات تشغيل فعلية.

## 2. Git & Repository Status
- branch الحالي: `main`.
- remote: `origin https://github.com/kingbasbosa-beep/mental-smile-app.git`.
- حالة branch: `main...origin/main [ahead 1]`.
- working tree:
  - [Critical] `firestore.rules` معدل.
  - [Critical] `firestore.indexes.json` معدل.
  - [Important] `lib/features/clinician/presentation/pages/clinician_operations_page.dart` معدل.
  - [Important] `firebase_audit_report.md` غير متتبع.
  - [Important] `production_checklist.md` غير متتبع.
  - [Important] `PRE_MIGRATION_AUDIT_REPORT.md` ملف تقرير جديد لهذا الفحص.
- آخر commits:
  - `4cc3b95 Refactor profile edit requests into dedicated pages`
  - `afaa0a3 Redesign cinematic client and center dashboards`
  - `357d9c5 Restore clinician operations stable layout`
  - `2264690 refactor: polish client dashboard profile header layout`
  - `3820ef0 feat: redesign cinematic library and family support experience`
  - `2c537df Redesign addiction support cinematic carousel UI`
  - `b928dfc Redesign centers landing cinematic carousel UI`
  - `21145c3 Add immersive specialists UI and unify clinician specialties data`
- ملفات حساسة:
  - [Important] لم يظهر `*.jks` أو `key.properties` أو `serviceAccount` أو `.env` أو `google-services.json` متتبع في Git.
  - [Critical] `test/node_modules/` متتبع بالكامل تقريبًا، ويحتوي Firebase packages وملفات dependency generated لا يجب نقلها لنسخة clean.
- تقييم `.gitignore`:
  - [Important] يحمي `android/app/google-services.json` و`**/GoogleService-Info.plist` و`functions/.env*` و`tools/qa_bot/.env`.
  - [Critical] لا يحمي صراحة `*.jks` و`key.properties` و`serviceAccount*.json` و`credentials*.json` وgeneric `.env`.
  - [Critical] لا يحمي `test/node_modules/` رغم أنه موجود ومتتبع.

## 3. Flutter Project Health
- `pubspec.yaml`:
  - [Important] يستخدم Firebase packages: `firebase_core`, `cloud_firestore`, `firebase_auth`, `firebase_analytics`.
  - [Optional] لا يوجد `firebase_storage` dependency رغم وجود `storage.rules` و`lib/features/centers/data/services/center_storage_service.dart`.
  - [Important] `flutter_lints ^4.0.0` موجود لكن لم يتم تشغيل analyzer حسب شرط الفحص.
- dependencies:
  - [Important] `geolocator`, `geocoding`, `url_launcher`, `uuid`, `shared_preferences`, `flutter_riverpod` موجودة وتدعم flows فعلية.
  - [Optional] وجود `test/node_modules` لا يتبع نمط Flutter dependency الطبيعي.
- assets:
  - [Important] `pubspec.yaml` يعلن جذور كثيرة: `assets/branding/`, `assets/images/`, `assets/c5/`, `assets/c6_library/`, `assets/c7_branding/`.
  - [Important] أصول كبيرة جدًا، مثل `assets/c5/sheet/c5_sheet.png` بحجم 3.89MB و`assets/c6_library/categories/cat_saved.png` بحجم 3.27MB و`assets/images/avatar_client_fmale.png` بحجم 2.81MB.
  - [Optional] إعلان `assets/images/` مع subfolders صريحة يزيد احتمال تضخم bundle.
- debug/test/fake traces:
  - [Critical] `lib/core/auth/account_access_service.dart` يحتوي `ACCESS_TRACE`.
  - [Important] `lib/app/router/app_router.dart` يحتوي `ADMIN_GUARD` و`DEV_NO_UID`.
  - [Important] `lib/features/booking/presentation/pages/center_booking_request_page.dart` يحتوي `CENTER_DIAG`, `CENTER_TRACE`, `CENTER_CREATE`, `BLOCK_SUBMIT`.
  - [Important] `lib/features/booking/presentation/pages/booking_page.dart` يحتوي `kDevUi` و`MK_DEV_UI=true`.
  - [Important] `lib/features/booking/presentation/pages/booking_request_page.dart` يحتوي `MK_DEV_CLINICIAN_UID`.
  - [Important] `lib/features/booking/presentation/pages/clinician_inbox_page.dart` يحتوي `MK_DEV_CLINICIAN_ID`.
- duplicate/legacy files:
  - [Optional] native registration files ما زالت موجودة: `lib/features/auth/presentation/pages/clinician_register_page.dart`, `lib/features/centers/presentation/pages/center_register_page.dart`.
  - [Important] old routes محفوظة لكن redirect للويب في `lib/app/router/app_router.dart`.
  - [Optional] placeholder admin files موجودة في `lib/features/admin_surface/pages/admin_control_room_placeholder_pages.dart`.
- ملاحظات عامة:
  - [Important] المشروع صالح كمرجع وظيفي، لكنه غير جاهز كنسخة production clean بدون فصل legacy/debug/test artifacts.

## 4. Firebase Configuration Review
- `google-services.json`:
  - [Important] غير موجود في working tree المتتبع؛ `.gitignore` يحمي `android/app/google-services.json`.
  - [Important] `firebase.json` يشير إلى `android/app/google-services.json` كخرج FlutterFire.
- `lib/firebase_options.dart`:
  - [Important] يستخدم projectId واحد: `mental-smile-app-clean`.
  - [Critical] لا يوجد فصل واضح dev/prod داخل الملف؛ Web/Android/Windows كلها تشير لنفس Firebase project.
  - [Optional] iOS/macOS/Linux غير مدعومة وترمي `UnsupportedError`.
- `firebase.json`:
  - [Important] يربط المشروع بـ `firestore.rules`, `firestore.indexes.json`, و`storage.rules`.
- `firestore.rules`:
  - [Critical] الملف معدل حاليًا وغير مثبت في Git؛ لا يمكن اعتماده كحالة production قبل مراجعة الفروق.
  - [Critical] rules الحالية تعتمد على custom claims حسب آخر تعديل محلي، بينما التطبيق ما زال يقرأ role من Firestore في `lib/core/auth/account_access_service.dart`.
- `firestore.indexes.json`:
  - [Important] الملف معدل حاليًا؛ يجب اعتباره غير نهائي قبل النقل.
  - [Important] app queries متعددة في `sessionRatings`, `clinicians`, `centers`, `bookingRequests`, `supportRequests`, `center_profile_change_requests`.
- `storage.rules`:
  - [Important] موجود ويحتوي فقط `match /centers/{uid}/{allPaths=**}`.
  - [Important] `allow read: if isSignedIn()` يسمح لكل مستخدم مسجل بقراءة كل center storage paths.
  - [Important] لا توجد قواعد لـ clinician/client uploads أو document type validation.
- Firebase usage points:
  - `FirebaseAuth`: `lib/features/auth/presentation/pages/login_page.dart`, `lib/core/auth/account_access_service.dart`, `lib/app/router/app_router.dart`, dashboards، booking، admin pages.
  - `FirebaseFirestore`: web registration، admin control room، booking، chat، center/clinician/client dashboards.
  - `FirebaseAnalytics`: `lib/shared/analytics/app_analytics.dart`.
  - `FirebaseStorage`: لم يظهر استخدام مباشر لـ `FirebaseStorage` في Dart أثناء الفحص.
  - `FirebaseCrashlytics`: لم يظهر استخدام مباشر.
- مخاطر الإعدادات الحالية:
  - [Critical] لا يوجد dev/prod separation واضح.
  - [Critical] mismatch محتمل بين custom-claims rules وFirestore-role app logic.
  - [Important] Storage rules أوسع من اللازم.

## 5. Roles & Access Flow Review
- client:
  - [Important] login يوجه client إلى `Routes.clientDashboard` في `lib/features/auth/presentation/pages/login_page.dart`.
  - [Important] `AccountAccessService.resolve` قد يرجع `role: 'client'` إذا لم يجد doc لكن المستخدم لديه email.
- clinician:
  - [Important] login يمنع الوصول إذا `approvalStatus != approved` أو `isActive != true`.
  - [Important] protected route gate في `lib/app/router/app_router.dart` يطبق نفس شرط approved/active.
- center:
  - [Important] login يمنع الوصول إذا `approvalStatus != approved` أو `isActive != true`.
  - [Important] protected route gate يطبق نفس شرط approved/active.
- admin:
  - [Critical] `lib/core/auth/account_access_service.dart` يحتوي hardcoded `kKnownPrimaryAdminUid = '1p1UEwzwXFYCHExp22bc0xGSjJj2'`.
  - [Critical] admin detection يعتمد على `admins/{uid}` Firestore doc أو hardcoded uid، وليس custom claims.
- login routing:
  - `lib/features/auth/presentation/pages/login_page.dart` يستخدم `_resolve(User u, SignedInAccessState a)`.
  - blocked users يذهبون إلى `Routes.blockedAccount`.
  - rejected clinicians/centers يذهبون إلى blocked flow.
- protected routes:
  - `lib/app/router/app_router.dart` يحتوي `_checkRouteAccess`.
  - [Important] `_checkRouteAccess` يطبع `ADMIN_GUARD` في التشغيل.
  - [Important] denied redirect قد يعود إلى `Routes.menu`.
- approvalStatus / isActive / isBlocked:
  - [Important] موجودة في `SignedInAccessState`.
  - [Important] `_stateForDoc` يقرأ `approvalStatus`, `isActive`, `isBlocked`.
- access risks:
  - [Critical] app-side role trust من Firestore لا يكفي production security.
  - [Critical] custom claims غير متكاملة مع app role flow حتى الآن.
  - [Important] `DEV_NO_UID` في `app_router.dart` خطر لو وصل route بدون args.

## 6. Web Registration Review
- center registration:
  - files:
    - `lib/features/web_registration/presentation/pages/web_center_register_portal_page.dart`
    - `lib/features/web_registration/presentation/pages/web_center_profile_page.dart`
    - `lib/features/web_registration/presentation/pages/web_center_media_page.dart`
    - `lib/features/web_registration/presentation/pages/web_center_pricing_page.dart`
    - `lib/features/web_registration/presentation/pages/web_center_documents_page.dart`
  - Firestore collection: `centers`.
  - [Important] account step يكتب `role: center`, `approvalStatus: pending_admin`, `isActive: false`.
  - [Important] documents step يكتب `approvalStatus: pending_admin`, `isActive: false`.
  - [Important] media/pricing/profile steps تستخدم `FirebaseAuth.currentUser?.uid` مع draft fallback في بعض الصفحات.
  - [Important] readiness fields مثل `documentsReady`, `imagesReady`, `accommodationCosts`, `autismCareCosts`, `centerCapabilities` موجودة في flow.
- clinician registration:
  - files:
    - `lib/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart`
    - `lib/features/web_registration/presentation/pages/web_clinician_profile_page.dart`
    - `lib/features/web_registration/presentation/pages/web_clinician_sessions_page.dart`
    - `lib/features/web_registration/presentation/pages/web_clinician_documents_page.dart`
  - Firestore collection: `clinicians`.
  - [Important] account step يكتب `role: clinician`, `approvalStatus: pending_review`, `isActive: false`, `isAdmin: false`.
  - [Important] documents step يكتب `approvalStatus: pending_review`, `isActive: false`, `documentsSubmitted`.
- success routing:
  - `lib/features/web_registration/presentation/pages/web_registration_success_page.dart` يقرأ args `role/source` لاختيار background.
  - [Important] أي navigation للنجاح بدون args يعتمد على fallback.
- consistency risks:
  - [Critical] self-registration writes لـ `role`, `isAdmin`, `approvalStatus`, `isActive` يجب أن تكون محكومة بدقة في `firestore.rules`.
  - [Important] center uses `pending_admin` بينما clinician uses `pending_review`; admin filters يجب أن تظل متوافقة.

## 7. Admin Control Room Review
- approval flow:
  - `lib/features/admin_surface/pages/admin_centers_page.dart`
    - `_approve` يكتب `approvalStatus: approved`, `isActive: true`.
    - `_reject` يكتب `approvalStatus: rejected_admin`, `isActive: false`.
    - `_returnToFollowUp` يكتب `approvalStatus: center_follow_up`, `isActive: false`.
  - `lib/features/admin_surface/pages/admin_clinician_requests_page.dart`
    - `_approve` يكتب `approvalStatus: approved`, `isActive: true`.
    - `_reject` يكتب `approvalStatus: rejected`, `isActive: false`.
    - `_returnToPending` يكتب `approvalStatus: pending_review`, `isActive: false`.
- block/unblock:
  - `lib/core/auth/account_access_service.dart` يحتوي `AccountBlockingService`.
  - [Important] block writes: `isBlocked`, `blockedAt`, `blockedBy`, `blockReason`.
  - `admin_centers_page.dart`, `admin_clinician_requests_page.dart`, `admin_clients_page.dart` تستدعي block/unblock.
- requested changes:
  - `lib/features/admin_surface/pages/admin_clinician_profile_requests_page.dart` يوافق/يرفض requests للأخصائي والمركز.
  - [Important] center requests تطبق fields على `centers/{centerId}`.
  - [Important] clinician requests تطبق fields على `clinicians/{clinicianId}`.
- admin-only risks:
  - [Critical] admin power يعتمد على Firestore/admin route guard في التطبيق؛ يجب أن تطابقه rules قبل production.
  - [Important] `admin_registration_maintenance_page.dart` يقرأ `clinicians`, `centers`, `clients` كلها؛ يجب حصره admin-only في rules.
  - [Optional] admin placeholder pages مثل `admin_ai_devops_center_page.dart`, `admin_employee_system_page.dart`, `admin_communication_gateway_page.dart` تحتوي placeholder/TODO نصوص.

## 8. Assets & Branding Review
- declared assets:
  - `pubspec.yaml` يعلن `assets/branding/`, `assets/branding/menu/desktop/`, `tablet/`, `mobile/`.
  - `pubspec.yaml` يعلن `assets/branding/client_dashboard/desktop/`, `tablet/`, `mobile/`.
  - `pubspec.yaml` يعلن `assets/branding/web_registration/centers/`, `clinicians/`, `clients/`.
  - `pubspec.yaml` يعلن `assets/images/` وfolders حديثة: `addiction`, `backgrounds`, `centers`, `client_dashboard/actions`, `center_dashboard/actions`, `family_support`, `specialists`.
- missing paths:
  - [Important] لم يتم تأكيد missing asset حاليًا بتشغيل app، لكن حدثت سابقًا أخطاء path مثل `desktob/desktop` و`assets/assets/...`; يجب عدم النقل قبل مراجعة static asset references.
- duplicated assets:
  - [Optional] `assets/images/` root مع subfolders صريحة قد يؤدي لبندلة واسعة.
  - [Optional] logos/avatars كبيرة جدًا ومكررة بصريًا: `assets/branding/logo_primary_dark.png`, `assets/c7_branding/logo/logo_mark.png`, `assets/images/avatar_*`.
- responsive backgrounds:
  - [Important] menu/client dashboard/web registration تستخدم responsive desktop/tablet/mobile paths داخل `pubspec.yaml`.
  - [Important] module pages تستخدم `assets/images/backgrounds/specialists_bg_*`.
- branding consistency:
  - [Optional] توجد أنظمة branding متعددة: `assets/branding`, `assets/c7_branding`, `assets/c6_library`, `assets/c5`.

## 9. Release Blockers Before Migration
- [Critical] تنظيف أو حسم working tree قبل النسخ: `firestore.rules`, `firestore.indexes.json`, `lib/features/clinician/presentation/pages/clinician_operations_page.dart`, وملفات audit غير المتتبعة.
- [Critical] إزالة `test/node_modules/` من النسخة النظيفة ومن Git history المستقبلي أو عزله قبل clone production.
- [Critical] توحيد security model بين `firestore.rules` custom claims و`AccountAccessService` Firestore role logic.
- [Critical] إزالة hardcoded admin UID من `lib/core/auth/account_access_service.dart` قبل production.
- [Important] مراجعة `storage.rules` لأنها تسمح بقراءة center storage لكل signed-in user.
- [Important] إزالة debug traces من `account_access_service.dart`, `app_router.dart`, booking pages، وadmin adapters.
- [Important] تأكيد dev/prod Firebase separation لأن `lib/firebase_options.dart` يستخدم `mental-smile-app-clean` فقط.
- [Important] مراجعة `DEV_NO_UID`, `MK_DEV_UI`, `MK_DEV_CLINICIAN_UID`, `MK_DEV_CLINICIAN_ID` قبل أي نسخة clean.
- [Important] فحص assets الكبيرة جدًا قبل Web production bundle.

## 10. Recommended Migration Decision
READY_WITH_FIXES_BEFORE_CLONE

السبب المختصر: المشروع صالح كمرجع Legacy Archive من حيث الوظائف والهيكل، لكنه ليس جاهزًا للنسخ Production Clean من الحالة الحالية بسبب working tree غير نظيف، `test/node_modules` متتبع، mismatch محتمل بين rules/custom claims ومنطق الأدوار داخل التطبيق، ووجود debug/dev traces في مسارات تشغيل فعلية.

## 11. Files Reviewed
- `.gitignore`
- `pubspec.yaml`
- `firebase.json`
- `firestore.rules`
- `firestore.indexes.json`
- `storage.rules`
- `lib/firebase_options.dart`
- `lib/main.dart`
- `lib/app/router/routes.dart`
- `lib/app/router/app_router.dart`
- `lib/core/auth/account_access_service.dart`
- `lib/features/auth/presentation/pages/login_page.dart`
- `lib/features/auth/presentation/pages/client_register_page.dart`
- `lib/features/auth/presentation/pages/clinician_register_page.dart`
- `lib/features/centers/presentation/pages/center_register_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_media_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_pricing_page.dart`
- `lib/features/web_registration/presentation/pages/web_center_documents_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_profile_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_sessions_page.dart`
- `lib/features/web_registration/presentation/pages/web_clinician_documents_page.dart`
- `lib/features/web_registration/presentation/pages/web_registration_success_page.dart`
- `lib/features/admin_surface/pages/admin_centers_page.dart`
- `lib/features/admin_surface/pages/admin_clinician_requests_page.dart`
- `lib/features/admin_surface/pages/admin_clinician_profile_requests_page.dart`
- `lib/features/admin_surface/pages/admin_clients_page.dart`
- `lib/features/admin_surface/pages/admin_registration_maintenance_page.dart`
- `lib/features/admin_surface/pages/admin_hub_page.dart`
- `lib/features/client/presentation/pages/client_dashboard_page.dart`
- `lib/features/clinician/presentation/pages/clinician_operations_page.dart`
- `lib/features/centers/presentation/pages/center_operations_page.dart`
- `lib/features/home/presentation/pages/menu_page.dart`
- `lib/features/library/presentation/pages/library_page.dart`
- `lib/shared/analytics/app_analytics.dart`
- `lib/features/booking/presentation/pages/booking_page.dart`
- `lib/features/booking/presentation/pages/booking_request_page.dart`
- `lib/features/booking/presentation/pages/center_booking_request_page.dart`
- `lib/features/booking/presentation/pages/clinician_inbox_page.dart`
