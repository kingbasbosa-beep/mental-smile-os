# ACTIVE_IDENTITY_RESIDUE_REGISTRY_V1

| ID | File | Exact Finding | Area | Classification | Risk | Recommended Decision |
| --- | --- | --- | --- | --- | --- | --- |
| AIR-001 | `lib/app/app.dart` | `class MentalKeyApp extends ConsumerWidget` | Runtime Dart symbol | ACTIVE_BLOCKER | MEDIUM | Rename to `MentalSmileOSApp` in approved cleanup wave. |
| AIR-002 | `lib/app/app.dart` | `const MentalKeyApp({super.key});` | Runtime Dart symbol | ACTIVE_BLOCKER | MEDIUM | Rename with AIR-001. |
| AIR-003 | `lib/app/app.dart` | `buildMentalKeyTheme(effectiveLocale)` | Runtime Dart symbol reference | ACTIVE_BLOCKER | MEDIUM | Rename with AIR-004. |
| AIR-004 | `lib/shared/ui_kit/app_theme.dart` | `ThemeData buildMentalKeyTheme(Locale locale)` | Runtime Dart symbol | ACTIVE_BLOCKER | MEDIUM | Rename to `buildMentalSmileOSTheme`. |
| AIR-005 | `lib/main.dart` | `child: const MentalKeyApp()` | Runtime Dart symbol reference | ACTIVE_BLOCKER | MEDIUM | Rename with AIR-001. |
| AIR-006 | `android/app/build.gradle.kts` | `applicationId = "com.mentalkey.app.flutterprojects"` | Android technical identity | VISIBLE_RESIDUE | HIGH | Defer. Requires Owner decision and Firebase/Play continuity review. |
| AIR-007 | `firebase.json` | `"projectId": "mental-smile-app-clean"` | Firebase deployment identity | VISIBLE_RESIDUE | HIGH | Defer. Do not change in OS-only Wave 1. |
| AIR-008 | `.github/workflows/firebase-hosting-merge.yml` | `projectId: mental-smile-app-clean` | GitHub Actions deployment identity | VISIBLE_RESIDUE | HIGH | Defer. Must align with Firebase project strategy. |
| AIR-009 | `.github/workflows/firebase-hosting-pull-request.yml` | `projectId: mental-smile-app-clean` | GitHub Actions deployment identity | VISIBLE_RESIDUE | HIGH | Defer. Must align with Firebase project strategy. |
| AIR-010 | `lib/firebase_options.dart` | `projectId: 'mental-smile-app-clean'` | Firebase runtime config | ACTIVE_BLOCKER | HIGH | Defer. Do not touch Firebase without activation plan. |
| AIR-011 | `lib/firebase_options.dart` | `authDomain: 'mental-smile-app-clean.firebaseapp.com'` | Firebase runtime config | ACTIVE_BLOCKER | HIGH | Defer. Do not touch Firebase without activation plan. |
| AIR-012 | `lib/firebase_options.dart` | `storageBucket: 'mental-smile-app-clean.firebasestorage.app'` | Firebase runtime config | ACTIVE_BLOCKER | HIGH | Defer. Do not touch Firebase without activation plan. |
| AIR-013 | `lib/features/app_exit/presentation/pages/app_exit_social_links_page.dart` | `https://mental-smile-app-clean.web.app` | Visible official link | VISIBLE_RESIDUE | MEDIUM | Replace only after Owner confirms final public domain/hosting URL. |
| AIR-014 | `test/mental_smile_clean_core_import_test.dart` | `Mental Smile OS no longer requires clean core as active dependency` | Test label | SAFE_IGNORE | LOW | Optional wording cleanup. Not user-facing. |
| AIR-015 | `lib/features/sovereign_construction/domain/construction_tool_registry.dart` | `mental-smile-app-clean2` local path | Owner tool source path | ARCHIVE_ALLOWED | MEDIUM | Keep until source-repository path decision. Not public-facing app UI. |
| AIR-016 | `lib/features/sovereign_construction/domain/construction_tool_registry.dart` | `mental_smile_clean_core` local path | Owner tool source path | ARCHIVE_ALLOWED | MEDIUM | Keep as source evidence unless Owner retires Construction Workbench path. |
| AIR-017 | `firestore.rules` | `// MASTER CORE role doctrine:` | Rule comment | SAFE_IGNORE | LOW | Generic doctrine wording, not legacy identity. |
| AIR-018 | `android/build.gradle.kts` | `tasks.register<Delete>("clean")` | Gradle task | SAFE_IGNORE | LOW | Technical build term, not app identity. |

