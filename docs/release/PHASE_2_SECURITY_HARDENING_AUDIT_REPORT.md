# PHASE 2 — SECURITY HARDENING AUDIT REPORT
## Mental Smile

## 1. Repository Verification
- pwd: `/workspace/mental-smile-app`
- remote: لا يوجد remote مُعرّف حاليًا (`git remote -v` بدون مخرجات).
- branch: `work` (وليس `main`).
- HEAD: `afaa0a3a67655d0c87a94f2ac7bf2ae626d4f777`.
- last 5 commits:
    - `afaa0a3` Redesign cinematic client and center dashboards
    - `357d9c5` Restore clinician operations stable layout
    - `2264690` refactor: polish client dashboard profile header layout
    - `3820ef0` feat: redesign cinematic library and family support experience
    - `2c537df` Redesign addiction support cinematic carousel UI
- git status: الشجرة غير نظيفة وبها تغييرات ضخمة عائمة داخل `test/node_modules` (typechange/deletions/modifications متعددة).
- هل الحالة تطابق المرجع المحلي أم لا؟ **لا**.
    - المسار المرجعي المتوقع: `C:\mental_smile_workspace\app\mental-smile-app-clean2` بينما الحالي Linux path مختلف.
    - remote المرجعي المتوقع GitHub غير ظاهر محليًا.
    - الفرع المرجعي المتوقع `main` بينما الحالي `work`.
    - HEAD المرجعي المتوقع `e0f94cb` أو أحدث غير قابل للتحقق كسلسلة تاريخية هنا بسبب عدم وجود remote وربط مختلف.
    - expected floating changes (`firestore.rules`, `clinician_operations_page.dart`) لا تتطابق مع الوضع الحالي الذي يتضمن تغييرات كبيرة أخرى.

## 2. Executive Summary
- الحالة الأمنية العامة: **متوسطة المخاطر مع ثغرات عالية الأولوية في نموذج الثقة وتخزين الملفات**.
- هل يمكن بدء الإصلاح؟ **تقنيًا نعم**، لكن **تشغيليًا لا يُنصح** قبل تثبيت حالة الريبو (state mismatch كبير).
- أهم 5 مخاطر أمنية:
    1. وجود fallback admin hardcoded UID داخل التطبيق (`kKnownPrimaryAdminUid`) يخلق bypass خارج policy/server claims.
    2. عدم استخدام Custom Claims فعليًا، والاعتماد على قراءة Firestore مباشرة لتحديد الدور.
    3. `clinicians` يسمح `allow read: if signedIn()` (أي مستخدم مسجل يمكنه قراءة كل سجلات الأخصائيين).
    4. Storage rules تسمح قراءة كل ملفات `centers` لأي signed-in user بدون فصل حسب حساسية الملف.
    5. وجود traces/diagnostics تفصح حالة حرس الصلاحيات/admin routing في logs وقد تساعد الاستطلاع الداخلي.

## 3. Security Model Review
- current role source:
    - التطبيق يحدد admin من `admins/{uid}.active == true` مع fallback UID hardcoded.
    - clinician/center/client يتم حسمهم من Firestore docs + lookup بالبريد.
- custom claims usage:
    - لا يوجد استخدام فعال لـ `request.auth.token.role`/claims في app model.
- Firestore role fields usage:
    - الحقول (`role`, `approvalStatus`, `isActive`, `isBlocked`) مستخدمة بوضوح في `AccountAccessService` و`LoginPage` وroute gate.
- mismatch risks:
    - خطر mismatch بين منطق التطبيق (hardcoded fallback + doc fields) وقواعد Firestore (isAdmin من admins collection فقط).
    - إذا فشل/تأخر مزامنة docs أو تغيّر schema، يمكن أن يمر قرار UI لا يطابق server enforcement.
- recommended security model:
    - إزالة hardcoded admin fallback نهائيًا.
    - اعتماد مصدر صلاحية وحيد: Custom Claims (مع fallback read-only من admins doc فقط عند migration)
    - جعل Firestore doc fields للحالة التشغيلية فقط (approval/block flags) مع منع تغييرها ذاتيًا، والإبقاء على role authority في claim/server.

## 4. Firestore Rules Review
- deny-by-default status:
    - موجود `match /{document=**} { allow read, write: if false; }` في النهاية، وهي نقطة إيجابية.
- protected fields:
    - `ownClinicianUpdateValid` يثبت عدة حقول حساسة (role/isAdmin/isBlocked/approvalStatus/isActive...) ضد التغيير الذاتي.
    - `ownCenterUpdateValid` يمنع تغيير `role/approvalStatus/isActive/active` ذاتيًا.
- admin-only writes:
    - approved/reject/block/unblock من حيث المبدأ ضمن تحديثات admin على docs (clinicians/centers/requests) عبر `isAdmin()`.
- web registration writes:
    - center self-create مقيد بـ `role='center'`, `approvalStatus='pending_admin'`, `isActive=false`.
    - clinician create متاح ذاتيًا على doc uid، ثم update محكوم بقوائم حقول.
- role-specific access:
    - clients: owner/admin جيد نسبيًا.
    - centers: read لأي signedIn عندما `isActive == true` (مقبول لو المقصود directory عام، غير مقبول لو ملفات/بيانات حساسة داخل نفس doc).
    - clinicians: **فجوة حرجة** `allow read: if signedIn();`.
- critical gaps:
    - قراءة واسعة لبيانات clinicians.
    - `admins` read rule يعتمد `resource.data.active == true` بدون تقييد signedIn صريح (عمليًا عادة يتطلب auth بسبب data access، لكن الأفضل توضيح الشرط).
    - بعض domains (مثل resources) تقرأ `allow read: if true;` وقد تحتاج تصنيف بيانات.

## 5. Storage Rules Review
- current read/write model:
    - فقط namespace `centers/{uid}/**`.
    - read لأي signed-in.
    - write فقط للمالك uid.
- sensitive file risks:
    - أي مستخدم مسجل يمكنه قراءة كامل ملفات المركز (هويات/تراخيص إن وُجدت بنفس المسار).
- upload validation gaps:
    - لا قيود على `size`, `contentType`, ولا تسمية مسارات حساسة/عامة.
- required restrictions:
    - فصل جذور التخزين إلى public/private + role-scoped prefixes.
    - تقييد read حسب الدور/الملكية/اعتماد المركز.
    - إضافة حد حجم وامتدادات/أنواع MIME.
    - إضافة مسارات صريحة لـ clinician/client/admin بدل wildcard واحد.

## 6. App Access Flow Review
- login_page.dart:
    - يطبق block + approval gate للـ center/clinician قبل التوجيه.
- AccountAccessService:
    - يحمل المصدر الفعلي للقرار الأمني في العميل، ويتضمن admin fallback hardcoded + trace logs.
- app_router.dart:
    - `_RouteAccessGate` يفرض auth/blocked/approval/allowedRoles على مستوى route.
- admin access handling:
    - routing محمي عبر gate وisAdmin المستنتج من `AccountAccessService`.
    - وجود `DEV_NO_UID` fallback في clinician inbox route argument handling.
- blocked/rejected/inactive handling:
    - موجود ومطبق بوضوح عبر login + route gate، لكن ما يزال Client-side first (لا يغني عن enforcement backend).

## 7. Debug & DEV Security Traces
| file | trace | risk level | keep/remove decision |
|---|---|---|---|
| `lib/core/auth/account_access_service.dart` | `ACCESS_TRACE ... currentAuthUid/adminDocExists/adminActive` | Medium | Remove in production (or behind non-prod flag). |
| `lib/app/router/app_router.dart` | `ADMIN_GUARD ... isAdmin/allowed/redirect` | Medium | Keep only in debug mode; strip from release logs. |
| `lib/app/router/app_router.dart` | `DEV_NO_UID` default clinicianId | Low-Medium | Remove fallback; enforce null->deny/redirect login. |
| `lib/features/booking/presentation/pages/booking_page.dart` | `MK_DEV_UI` env flag | Low | Keep for dev only with compile-time guard, ensure false in prod pipeline. |
| `lib/features/booking/presentation/pages/booking_request_page.dart` | `MK_DEV_CLINICIAN_UID` env override | Medium | Remove from prod path; dev-only with assert/debug build guard. |
| `lib/features/booking/presentation/pages/clinician_inbox_page.dart` | `MK_DEV_CLINICIAN_ID` env override | Medium | Remove from prod path; dev-only with assert/debug build guard. |

## 8. Release Blockers
- Repository state mismatch كبير مقابل المرجع المتوقع (path/branch/remote/dirty state).
- Hardcoded primary admin UID fallback موجود.
- Firestore clinicians read ليست least-privilege.
- Storage read policy واسعة جدًا للـ centers.
- Dev/trace security signals ظاهرة في logs الإنتاج المحتمل.

## 9. Recommended Fix Plan
- Commit 1: **Security model alignment**
    - إزالة `kKnownPrimaryAdminUid` fallback.
    - اعتماد role authority موحّد (claims-first + migration-safe fallback controlled).
    - توحيد blocked/approval checks في نقطة مشتركة service-layer.
- Commit 2: **Firestore rules hardening**
    - تقييد `clinicians` read إلى owner/admin/authorized flow فقط.
    - تدقيق writes على حقول حساسة (`role/isAdmin/approvalStatus/isActive/isBlocked`) ومنع أي self-escalation.
    - مراجعة `resources` و`admins` read conditions حسب classification.
- Commit 3: **Storage segmentation & validation**
    - إنشاء prefixes منفصلة (`centers/public`, `centers/private`, `clinicians/...`, `clients/...`, `admin/...`).
    - فرض role-based read/write + ownership.
    - إضافة قيود الحجم والـ contentType للرفع.

## 10. Final Decision
BLOCKED_REPOSITORY_STATE_MISMATCH

## 11. Final Git Status
```
On branch work
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	typechange: test/node_modules/.bin/fxparser
	deleted:    test/node_modules/.bin/fxparser.cmd
	deleted:    test/node_modules/.bin/fxparser.ps1
	... (many changes under test/node_modules omitted for brevity)

no changes added to commit (use "git add" and/or "git commit -a")
```
