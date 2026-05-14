# Mental Smile Clean-Core Migration Audit and Inheritance Map

Date: 2026-05  
Project: Mental Smile  
Workspace: `C:/mental_smile_workspace/app/mental-smile-app-clean2`

## 1. Executive Verdict

The project is ready to start a clean-core migration, but only with selective inheritance and strict legacy quarantine.

The current tree has enough stabilized foundation to serve as a source workspace: Arabic-first localization is established, center and clinician web registration localization has been completed, booking quick-fix sweeps have been applied, and the main access-control concepts are identifiable. It is not recommended to continue trying to turn this exact tree into the final production tree. There is too much legacy routing, deep admin surface, old direct-write UI, unused/experimental modules, asset-pack history, and sensitive copy that has not been human reviewed.

Clean-core should inherit stable production concepts and active modules, not the whole codebase.

## 2. Clean-Core Principle

The current workspace should now be treated as a source/reference workspace, not the final production tree.

Clean-core migration should copy only reviewed, active, necessary pieces. Legacy files should remain available for reference, but they should not be copied merely because they compile or exist in `lib/`.

The clean-core tree should start with a smaller route table, a smaller feature set, Arabic-first localization, hardened role gates, and only assets referenced by migrated pages. Everything else should remain in a legacy archive or be rebuilt later.

## 3. Must Migrate

| File / module | Why it should migrate | Dependencies | Risk | Migration note |
|---|---|---|---|---|
| `lib/main.dart` | App entry point and Firebase/bootstrap startup. | Firebase config, app widget. | Medium | Migrate after checking no legacy-only initialization is pulled in. |
| `lib/app/app.dart` | Material app/localization/router foundation. | `locale_provider.dart`, router, l10n. | Low | Keep Arabic-first fallback behavior. |
| `lib/app/locale_provider.dart` | Locale state behavior. | `LocaleStorage`. | Low | Migrate with comments aligned to Arabic-first behavior. |
| `lib/core/storage/locale_storage.dart` | Locale persistence. | SharedPreferences. | Low | Keep simple; no new storage layer. |
| `l10n.yaml` | Arabic template/source configuration. | ARB files, Flutter gen-l10n. | Low | Ensure `template-arb-file: app_ar.arb`. |
| `lib/l10n/app_ar.arb` | Arabic source language. | gen-l10n. | Medium | Migrate first; run manual `flutter gen-l10n` from PowerShell after copy. |
| `lib/l10n/app_en.arb` | English secondary language. | gen-l10n. | Medium | Must match Arabic key set. |
| `lib/l10n/app_localizations*.dart` | Generated localization surface. | ARB sync. | Medium | Prefer regenerating in clean-core after ARB migration instead of trusting old generated files. |
| `lib/app/router/routes.dart` | Route naming source. | `app_router.dart`. | Medium | Do not copy all routes blindly; create a reduced active route list. |
| `lib/app/router/app_router.dart` | Role gates and page routing foundation. | `AccountAccessService`, page imports. | High | Migrate conceptually, then reduce imports/routes aggressively. |
| `_RouteAccessGate` inside `app_router.dart` | Central route protection. | FirebaseAuth, `AccountAccessService`. | Medium | Keep role/approval/block checks; remove legacy route clutter. |
| `lib/core/auth/account_access_service.dart` | Resolves role, admin, approval, active/blocked state. | Firebase Auth/Firestore. | High | Must migrate; verify field names against rules. |
| `SignedInAccessState` location in core/auth if present | Access state contract. | Account access flow. | Medium | Migrate if currently referenced by active gates/pages. |
| `lib/core/auth/presentation/pages/account_blocked_page.dart` | Blocked/inactive account UX. | Access gate. | Low | Keep as part of hardening. |
| `lib/features/auth/presentation/pages/login_page.dart` | Primary login flow. | FirebaseAuth, l10n, routes. | Medium | Migrate; avoid old registration sprawl. |
| `lib/features/auth/presentation/pages/client_register_page.dart` | Client registration if still active. | FirebaseAuth, Firestore, assets/images avatars. | Medium | Migrate only if product still supports in-app client registration. |
| `lib/features/home/presentation/pages/home_page.dart` | User-facing home entry. | l10n, assets. | Low | Migrate if still first screen in product. |
| `lib/features/home/presentation/pages/menu_page.dart` | Main menu/module entry. | routes, assets. | Medium | Migrate after c7 references are accepted temporarily or replaced. |
| `lib/features/web_registration/presentation/pages/web_center_register_portal_page.dart` | Public center web registration account step. | FirebaseAuth, Firestore, l10n. | Medium | Migrate; verify approval writes. |
| `lib/features/web_registration/presentation/pages/web_center_profile_page.dart` | Center profile registration step. | Firestore, l10n. | Medium | Migrate; keep only approved schema. |
| `lib/features/web_registration/presentation/pages/web_center_media_page.dart` | Center media registration step. | Storage/URL handling if used, l10n. | Medium | Migrate after upload path review. |
| `lib/features/web_registration/presentation/pages/web_center_pricing_page.dart` | Center pricing/capability registration step. | `CenterPricing`. | High | Migrate with schema review; pricing data is production-sensitive. |
| `lib/features/web_registration/presentation/pages/web_center_documents_page.dart` | Center document submission step. | Storage/Firestore. | High | Migrate with document access review. |
| `lib/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart` | Clinician account registration. | FirebaseAuth, Firestore, l10n. | Medium | Migrate; keep approval pending by default. |
| `lib/features/web_registration/presentation/pages/web_clinician_profile_page.dart` | Clinician profile step. | Firestore, l10n. | Medium | Migrate with profile moderation model. |
| `lib/features/web_registration/presentation/pages/web_clinician_sessions_page.dart` | Clinician session configuration step. | Firestore, l10n. | High | Migrate only after validating public/session fields. |
| `lib/features/web_registration/presentation/pages/web_clinician_documents_page.dart` | Clinician documents step. | Storage/Firestore. | High | Migrate with document security rules review. |
| `lib/features/web_registration/presentation/pages/web_registration_success_page.dart` | Shared registration completion. | routes, l10n. | Low | Migrate. |
| `lib/features/centers/data/models/center_model.dart` | Public center schema model. | Firestore service, center pages. | High | Migrate as canonical after reviewing optional link fields later. |
| `lib/features/centers/data/models/center_pricing.dart` | Pricing/capability data structures. | Center details, registration. | High | Migrate, but review business correctness. |
| `lib/features/centers/data/services/centers_firestore_service.dart` | Center listing/detail reads and admin-related writes if any. | Firestore. | High | Migrate only read/listing portions first; review writes. |
| `lib/features/centers/presentation/pages/centers_landing_page.dart` | Public center category entry. | routes, assets. | Medium | Migrate if active in public flow. |
| `lib/features/centers/presentation/pages/centers_list_page.dart` | Public center list. | `CenterModel`, service, assets. | Medium | Migrate; preserve approved/active filtering concept. |
| `lib/features/centers/presentation/pages/center_details_page.dart` | Public center details and Center Office Phase A contact actions. | `url_launcher`, `CenterModel`, l10n. | Medium | Migrate; keep phone/WhatsApp/maps actions; review c7 replacement later. |
| `lib/features/booking/presentation/pages/booking_page.dart` | Public specialist booking entry. | Firestore, l10n. | Medium | Migrate because quick-fix sweep completed. |
| `lib/features/booking/presentation/pages/booking_request_page.dart` | Client-to-clinician booking request. | FirebaseAuth, Firestore, chat adapter, l10n. | High | Migrate with write review; recent compile fixes should be included. |
| `lib/features/booking/presentation/pages/center_booking_request_page.dart` | Client-to-center booking request. | FirebaseAuth, Firestore, pricing, l10n. | High | Migrate with write/status review; recent compile fixes should be included. |
| `lib/features/booking/presentation/pages/my_bookings_page.dart` | Client booking status view. | Firestore, status labels. | Medium | Migrate if stable. |
| `lib/features/booking/presentation/pages/center_inbox_page.dart` | Center request inbox. | `CenterRequestInboxService`, l10n. | Medium | Migrate after generated l10n sync. |
| `lib/features/booking/presentation/pages/clinician_inbox_page.dart` | Legacy-demoted clinician inbox. | Firestore, l10n. | Medium | Migrate only if still routed intentionally; otherwise keep operations page as primary. |
| `lib/features/client/presentation/pages/client_dashboard_page.dart` | Client dashboard. | FirebaseAuth/Firestore, assets, l10n. | Medium | Migrate if smoke-tested after RTL/localization work. |
| `lib/features/client/presentation/pages/client_sessions_page.dart` | Client sessions view. | Firestore/session data. | Medium | Migrate after session field review. |
| `lib/features/clinician/presentation/pages/clinician_operations_page.dart` | Primary clinician workspace. | Firestore, routes, l10n. | High | Migrate after small cleanup; operationally important. |
| `lib/features/clinician/presentation/pages/clinician_sessions_page.dart` | Clinician sessions. | Firestore/session data. | Medium | Migrate after session field review. |
| `lib/shared/ui_kit/*` actively referenced | Shared branded UI primitives. | assets, colors. | Medium | Migrate only referenced widgets; do not copy unused UI kit wholesale. |
| `lib/shared/utils/asset_path_utils.dart` | Normalizes asset paths. | Asset-loading pages. | Low | Migrate if migrated pages still use normalized paths. |
| Actively referenced assets under `assets/branding/`, `assets/images/`, `assets/c5/`, `assets/c6_library/`, `assets/c7_branding/` | Required for migrated UI to render. | `pubspec.yaml`. | Medium | Keep referenced assets until replacement and QA. |
| Firebase config files: `firebase.json`, `.firebaserc`, `firestore.rules`, `firestore.indexes.json`, `storage.rules`, `lib/firebase_options.dart` | Runtime/security environment. | Firebase project. | High | Migrate with explicit security review, not blind copy. |

## 4. Migrate With Fix

| File | Issue type | Safe fix | Timing |
|---|---|---|---|
| `lib/app/router/app_router.dart` | Route/import sprawl; mojibake in fallback text; admin/deep routes mixed with public routes. | Split clean active routes from legacy/admin routes; localize fallback text. | Before migration into clean-core router. |
| `lib/features/booking/presentation/pages/booking_request_page.dart` | Recent `BackButtonIcon` API fix; possible remaining warnings around async context and direct writes. | Keep `IconTheme` fix; review async gaps and write payload. | Before migration if active. |
| `lib/features/booking/presentation/pages/center_booking_request_page.dart` | Recent `InputDecoration` const fix; complex status/payment/intake write flow. | Keep const fix; isolate and review writes/status transitions. | Before migration if active. |
| `lib/features/booking/presentation/pages/my_bookings_page.dart` | Status display and action surface may still contain raw values or old labels. | Verify status mapper/l10n and no raw backend labels leak. | Before or immediately after migration. |
| `lib/features/booking/presentation/pages/center_inbox_page.dart` | New ARB keys require generated sync; status labels still partly local/manual. | Run manual `flutter gen-l10n`; review status mapper later. | Before build in clean-core. |
| `lib/features/booking/presentation/pages/clinician_inbox_page.dart` | Legacy-demoted page; some operational paragraphs intentionally skipped; new ARB keys require generated sync. | Decide whether to migrate at all; if migrated, run gen-l10n and keep disabled guard intentional. | Before migration decision. |
| `lib/features/centers/presentation/pages/center_details_page.dart` | Minor mojibake leftovers in pricing/capability details; newly added l10n locals fix undefined identifiers. | Keep compile fix; later extract remaining labels and replace c7 assets. | Before final QA, not blocker for initial migration if compiled. |
| `lib/features/centers/presentation/pages/centers_list_page.dart` | Contains `c7_branding` fallback detection and possible old asset checks. | Keep temporarily or replace with newer assets after visual decision. | After migration, before visual QA freeze. |
| `lib/features/home/presentation/pages/home_page.dart` | c7 background dependency remains if not replaced. | Either keep referenced c7 asset or replace with `assets/branding/menu/*` after visual decision. | After migration foundation. |
| `lib/features/modules/presentation/pages/support_entry_page.dart` | c7 hero/button assets and support flow text. | Keep temporarily; replacement requires visual/product decision. | After clean-core smoke test. |
| `lib/features/web_registration/presentation/pages/*` | Generated l10n may need sync; upload/document flows need storage review. | Manual gen-l10n; review Firestore/Storage writes. | Before production release, can migrate first as reviewed flow. |
| `lib/features/client/presentation/pages/client_dashboard_page.dart` | Possible leftover direct labels, raw status, responsive asset dependencies. | Small localization/RTL QA pass. | After migration if smoke test passes. |
| `lib/features/clinician/presentation/pages/clinician_operations_page.dart` | Large operational page, possible warnings/deprecated controls. | Fix active warnings only; defer deep refactor. | Before production QA. |
| `lib/features/client/presentation/pages/client_payment_proof_page.dart` | Payment proof advanced flow not fully reviewed. | Security/payment review and l10n pass. | After migration, before enabling payment proof. |
| `lib/shared/ui_kit/app_widgets.dart` | c6/c7 references and broad shared widgets. | Copy only referenced components or replace c7 later. | During selective migration. |

## 5. Do Not Migrate / Legacy Graveyard

| File / module | Reason | Disposition |
|---|---|---|
| `lib/features/web_registration/presentation/pages/web_center_details_page.dart` | Not actively routed; old direct `centers` update; duplicate of newer center web registration steps. | Exclude from clean-core; archive later. |
| `lib/features/centers/presentation/pages/center_form_page.dart` as active UI | Not routed; direct create/update form; mojibake; old admin-like form. | Do not migrate as UI; use only as legacy schema reference. |
| `lib/features/auth/presentation/pages/clinician_register_page.dart` if superseded by web registration | Older in-app clinician registration path. | Needs reference check; likely exclude or rebuild later. |
| `lib/features/centers/presentation/pages/center_register_page.dart` if superseded by web registration | Older in-app/public center registration path with c7 references. | Exclude from initial clean-core unless product explicitly needs it. |
| Deep `lib/features/admin_surface/pages/*` | Large, mixed maturity, some AI/legal/governance placeholders, not fully localized/reviewed. | Keep behind; migrate only a minimal admin subset later. |
| `lib/features/admin/*` archive pages | Archive/internal tools not core product. | Exclude from initial clean-core. |
| `lib/features/gateway_layer/*` | Placeholder/gateway future layer, not active production system. | Archive/reference only. |
| `lib/features/assistant/*` | AI-adjacent surface not safety-reviewed for production. | Exclude until AI/Safety OS phase. |
| AI/legal/crisis/admin policy pages | Sensitive copy not human-reviewed. | Do not migrate into active production. |
| Deep intake/assessment forms if present | Medical/sensitive workflow not reviewed. | Rebuild later with human/legal review. |
| Payment proof advanced flows not reviewed | Financial/privacy-sensitive. | Migrate only after dedicated security/product review. |
| Old internal forms and experimental workspace pages | Not product-critical and increase route surface. | Archive later. |
| Unused widgets/helpers supporting only legacy pages | Pulling them in preserves dead dependencies. | Exclude unless referenced by migrated active pages. |

## 6. Firebase / Firestore Inheritance

### Inherit Conceptually

- Firebase Auth sign-in and current-user identity.
- Role gates for `client`, `clinician`, `center`, and `admin`.
- `approvalStatus`, `isActive`, and `isBlocked` enforcement for center/clinician protected routes.
- `AccountAccessService` access resolution pattern.
- Public center listing concept: show only approved/active/public-safe center data.
- Web registration write concept: create pending profiles/documents for admin approval, not public immediately.
- Booking request concept: client creates request, admin/center/clinician respond through controlled status transitions.

### Do Not Blindly Inherit

- Direct user-side writes to sensitive public profile fields.
- Legacy center create/update flows from `center_form_page.dart`.
- `web_center_details_page.dart` direct center update flow.
- Unreviewed admin writes across `admin_surface`.
- AI/legal/crisis public flows.
- Public exposure of session links, Zoom/Meet links, or private documents.
- Any rules that let users set `verified`, `approved`, `isActive`, `isBlocked`, or admin-only status fields.

## 7. Routes Inheritance

### Keep Active

- `splash`, `language`, `home`, `menu`, `login`, `blockedAccount`.
- Public modules: `centers`, `centersList`, `centerDetails`, `specialists`, `specialistsList`, `specialistDetails`, `library`.
- Web registration: center and clinician routes from register through documents plus success.
- Protected user routes: `clientDashboard`, `clientSessions`, `myBookings`.
- Booking routes: `booking`, `bookingRequest`, `centerBookingRequest`.
- Center operational routes if production-ready: `centerDashboard`, `centerOperations`, `centerInbox`, `centerResidencies`.
- Clinician operational routes if production-ready: `clinicianOperations`, `clinicianSessions`.

### Migrate With Review

- `clientPaymentProof`.
- `clinicianInbox` because it is legacy-demoted and guarded.
- `clinicianChatInbox` and chat routes.
- `sessionReview`.
- Minimal `adminCenters` / `adminCenterDetails` if a production admin subset is required.

### Exclude Legacy

- Old in-app registration routes if superseded by web-first registration.
- Deep admin/gateway/workspace/archive routes.
- AI policy, compliance, activation, gateway, growth, and control-room pages until the dedicated safety/governance phase.
- `web_center_details_page.dart` has no active route and should not be introduced.

### Possible Aliases Only

- Legacy chat/inbox aliases can exist as redirect-only aliases if existing users/bookmarks require them.
- Do not copy aliases just because they exist.

Legacy routes should not be copied into clean-core merely because they are defined in `routes.dart`.

## 8. Localization Inheritance

### Safe To Migrate

- `l10n.yaml`.
- `lib/l10n/app_ar.arb`.
- `lib/l10n/app_en.arb`.
- Common/auth/menu/home/booking/center/clinician/web registration keys.
- Existing Arabic-first app locale provider/storage.

### Needs Generated Sync

- Generated localization files should be regenerated in clean-core after ARB migration.
- Run `flutter gen-l10n` manually from PowerShell after ARB files are copied.
- Do not rely on generated files if any ARB keys were added after the last manual sync.

### Needs Human Review Later

- AI fallback and safety responses.
- Crisis escalation copy.
- Legal/privacy/medical disclaimers.
- Sensitive intake/assessment copy.
- Admin moderation/governance copy.

### Must Not Auto-Translate

- Crisis copy.
- AI safety copy.
- Legal/medical disclaimers.
- Clinical assessment/intake text.
- Store review copy and consent text.

Arabic remains the source/native language. English is secondary and must be reviewed for tone and legal clarity.

## 9. Assets Inheritance

### Keep Because Referenced

- Active `assets/branding/*` used by home/menu/login/library/navigation/web registration.
- Active `assets/images/*` used by modules, dashboards, centers, specialists, and avatars.
- `assets/c5/avatars/avatar_admin_support.png`.
- `assets/c5/avatars/avatar_client.png`.
- `assets/c5/avatars/avatar_clinician_m.png`.
- `assets/c6_library/categories/*` used by library categories.
- `assets/c6_library/brand/logo_wordmark.png` if still used by shared UI.
- `assets/c7_branding/home/home_bg.png`, `hero_art.png`, `logo/logo_mark.png`, and buttons if still referenced by migrated pages.

### Keep Temporarily

- `assets/c7_branding/*` until replacements are selected and visual QA passes.
- c5/c6/c7 folders declared in `pubspec.yaml` if migrated pages still reference them.

### Defer Cleanup

- c5/c6/c7 cleanup should happen after clean-core migration and visual QA.
- Do not spend additional migration cycles on asset cleanup before the new tree is stable.

### Do Not Delete Yet

- Do not delete any referenced asset.
- Do not delete asset folders based only on suspicion.
- Do not remove pubspec declarations until `git grep` and runtime QA confirm no reference remains.

## 10. Analyzer Warning Inheritance Filter

No full analyzer run was performed for this report. This filter is based on the current reported errors/warnings, observed code patterns, and prior checkpoint findings.

### Safe Quick Fix Before Migration

- Undefined identifiers caused by missing local `l10n` variables in active pages.
- Invalid `const` around localized `InputDecoration`.
- API mismatches such as `BackButtonIcon(color:, size:)`.
- Obvious unused imports in files selected for migration.
- Obvious `TextAlign.left/right` in active user-facing pages where `TextAlign.start/end` is correct.
- Mojibake in active screens with simple labels.

### Safe After Migration

- Minor unused private helpers in migrated pages.
- Deprecated `value/groupValue/onChanged` warnings in active pages, if behavior is stable.
- Small BuildContext async-gap warnings where mounted checks can be added safely.
- Remaining non-sensitive static text extraction.

### Ignore For Now

- Warnings inside deep admin pages not entering clean-core.
- Warnings inside legacy archive pages.
- Warnings inside placeholder/gateway/future AI OS pages.
- Asset cleanup warnings until replacement QA.

### Legacy-Only, Leave Behind

- Warnings in `web_center_details_page.dart`.
- Warnings in `center_form_page.dart` unless mining schema knowledge.
- Warnings in inactive old registration pages.
- Warnings in deep admin/control-room/experimental modules.

## 11. Suggested Execution Prompts

### Prompt A: Create Clean-Core Branch / Workspace Foundation

- Goal: Create a new clean-core branch or workspace with Flutter/Firebase project skeleton.
- Files allowed: root config, `lib/main.dart`, `lib/app/*`, `pubspec.yaml`.
- Files forbidden: legacy feature pages, admin deep pages, AI/legal/crisis modules.
- Commands forbidden: `flutter clean`, destructive git commands, mass formatting.
- Stop condition: App shell boots with empty or minimal routes.

### Prompt B: Migrate Localization Foundation

- Goal: Move Arabic-first l10n foundation and ARB files.
- Files allowed: `l10n.yaml`, `lib/l10n/app_ar.arb`, `lib/l10n/app_en.arb`, generated l10n after manual generation.
- Files forbidden: feature pages except app bootstrap.
- Commands forbidden: repeated generation loops, `flutter pub upgrade`, `flutter clean`.
- Stop condition: Manual PowerShell `flutter gen-l10n` succeeds once.

### Prompt C: Migrate Auth + Role Gates

- Goal: Migrate login, account access, and protected route gate.
- Files allowed: `features/auth/presentation/pages/login_page.dart`, `core/auth/*`, route gate subset.
- Files forbidden: old registration pages unless explicitly selected.
- Commands forbidden: full analyze, cleanup commands.
- Stop condition: login route and blocked/pending account handling are wired.

### Prompt D: Migrate Clean Routes

- Goal: Build reduced clean route table.
- Files allowed: `routes.dart`, `app_router.dart`.
- Files forbidden: deep admin, AI/legal/crisis routes, legacy aliases unless redirect-only.
- Commands forbidden: route auto-generation, broad refactor.
- Stop condition: active public/auth/protected route list is minimal and documented.

### Prompt E: Migrate Stable User-Facing Pages

- Goal: Move home/menu/library/specialists/centers public pages.
- Files allowed: active public pages and their models/helpers/assets.
- Files forbidden: legacy forms and deep admin.
- Commands forbidden: asset cleanup, redesign.
- Stop condition: public navigation works with required assets.

### Prompt F: Migrate Web Registration

- Goal: Move center and clinician web registration flows.
- Files allowed: `features/web_registration/presentation/pages/web_center_*`, `web_clinician_*`, success page, required services/models.
- Files forbidden: `web_center_details_page.dart`, old in-app registration unless approved.
- Commands forbidden: schema changes, rules changes without explicit review.
- Stop condition: registration flow writes pending/approval-safe data.

### Prompt G: Migrate Booking / Client / Clinician / Center Operations

- Goal: Move booking pages, dashboards, inboxes, sessions, and operations pages selectively.
- Files allowed: active booking/client/clinician/center pages and required services.
- Files forbidden: payment proof advanced flow until reviewed, legacy clinician inbox if not intentionally active.
- Commands forbidden: business logic rewrites, status renames.
- Stop condition: protected routes compile and core user workflows are smoke-testable.

### Prompt H: Smoke Test + Manual Gen-L10n Checklist

- Goal: Verify compile-level and runtime basics.
- Files allowed: none unless fixing small active-page compile errors.
- Files forbidden: broad refactor, unrelated cleanup.
- Commands forbidden: `flutter clean`, repeated generation, full cleanup.
- Stop condition: `flutter gen-l10n` was run manually once, app launches, primary routes open.

### Prompt I: Legacy Archive Notes

- Goal: Document what stayed behind and why.
- Files allowed: `docs/*`.
- Files forbidden: source code, assets, Firebase rules.
- Commands forbidden: delete/move/cleanup.
- Stop condition: legacy graveyard list is complete and searchable.

### Prompt J: Prepare AI / Security / Policy OS Phase

- Goal: Start a later human-reviewed safety/security/legal phase.
- Files allowed: docs, policy drafts, selected admin/safety modules after review.
- Files forbidden: public AI/crisis/legal copy without human review.
- Commands forbidden: automated translation of crisis/legal text.
- Stop condition: scope is approved and separated from clean-core migration.

## 12. Final Recommendation

Start clean-core migration now, but only with selective inheritance and legacy quarantine.

Do not migrate the full current project. Do not clean assets first. Do not bring deep admin, AI/legal/crisis, old direct-write forms, or experimental pages into the first production-core pass. Use the current workspace as a reference library, copy active and reviewed pieces only, regenerate localization manually from PowerShell after ARB migration, and keep c5/c6/c7 assets until replacements are chosen and visually verified.

The clean-core goal should be a smaller, Arabic-first, route-gated, Firebase-safe production foundation that can later receive AI Safety, Legal, Admin, and Asset Cleanup phases without carrying forward old project sprawl.
