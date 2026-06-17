# Workspace Rebirth Report V1

Result: OWNER_ACTION_REQUIRED

## Mission Reality

The new sovereign workspace target is:

`C:\mental_smile_workspace\app\mental-smile-platform`

The current host is:

`C:\mental_smile_workspace\app\mental-smile-app-clean2`

Current host classification:

`LEGACY_HOST_PRIVATE_ARCHIVE`

## Active Workspace Package

The active workspace package must contain only operational source, required configuration, useful OS documentation, public landing, and release handoff evidence.

## Root Inventory Classification

| Root Item | Classification | Reason |
| --- | --- | --- |
| `.github/` | KEEP_ACTIVE | Firebase Hosting workflows now target `mental-smile-platform`. |
| `android/` | KEEP_ACTIVE | Android runtime, namespace, and applicationId source. |
| `assets/` | KEEP_ACTIVE | Flutter runtime asset source. |
| `functions/` | KEEP_ACTIVE | `firebase.json` declares `functions.source = functions`. |
| `lib/` | KEEP_ACTIVE | Flutter runtime source. |
| `public-landing/` | KEEP_ACTIVE | Firebase official landing public directory. |
| `test/` | KEEP_ACTIVE | Runtime validation source. |
| `web/` | KEEP_ACTIVE | Flutter web shell source. |
| `mental-smile-os-workspace/` | KEEP_ACTIVE | Useful OS docs, release cards, governance evidence, and handoff reports. |
| `.firebaserc` | KEEP_ACTIVE | Active Firebase project points to `mental-smile-platform`. |
| `firebase.json` | KEEP_ACTIVE | Active Firebase, hosting, FlutterFire metadata. |
| `firestore.rules` | KEEP_ACTIVE | Active Firestore rules. |
| `firestore.indexes.json` | KEEP_ACTIVE | Active Firestore indexes. |
| `storage.rules` | KEEP_ACTIVE | Active Storage rules. |
| `pubspec.yaml` | KEEP_ACTIVE | Active Dart package manifest. |
| `pubspec.lock` | KEEP_ACTIVE | Active Dart dependency lock. |
| `analysis_options.yaml` | KEEP_ACTIVE | Active analysis configuration. |
| `README.md` | KEEP_ACTIVE | Public/project front door. |
| `package.json` | KEEP_ACTIVE | Root Firebase/admin utility dependency manifest. |
| `package-lock.json` | KEEP_ACTIVE | Root Node dependency lock and active package identity. |
| `.gitignore`, `.gitattributes`, `.metadata`, `.cursorignore` | KEEP_ACTIVE | Project metadata and ignore behavior. |
| `android/app/google-services.json.backup-before-mental-smile-platform-cutover` | PRIVATE_ARCHIVE_USEFUL | Firebase rollback evidence. |
| `mental_smile_clean_core/` | MOVE_TO_ARCHIVE | Source repository evidence only; not active runtime. |
| `_archive/` | MOVE_TO_ARCHIVE | Historical archive material. |
| `docs/` | PRIVATE_ARCHIVE_USEFUL | Legacy/historical docs outside current OS workspace. |
| `firebase_rules/` | PRIVATE_ARCHIVE_USEFUL | Legacy/reference rule material if unique. |
| `assets_manifests/` | PRIVATE_ARCHIVE_USEFUL | Asset evidence if not duplicated by active manifests. |
| `mental-smile-os-runtime/` | PRIVATE_ARCHIVE_USEFUL | Runtime bootstrap evidence, not active package root. |
| `tools/` | OWNER_DECISION_REQUIRED | Keep only if actively used by current owner workflow. |
| `windows/` | OWNER_DECISION_REQUIRED | Desktop shell exists, but current production target is Android/Web. |
| `.firebase/` | CACHE_ONLY | Local Firebase hosting cache. |
| `.dart_tool/` | CACHE_ONLY | Flutter generated tooling cache. |
| `build/` | CACHE_ONLY | Generated build output. |
| `node_modules/` | CACHE_ONLY | Reinstallable dependency output. |
| `.git/` | KEEP_ACTIVE | Required only if this copy becomes a Git repository; do not copy blindly without Owner decision. |
| `.codex/`, `.idea/` | OWNER_DECISION_REQUIRED | Local tooling state; not required for clean source package. |
| root `clean_core_ex*.md` files | MOVE_TO_ARCHIVE | Clean Core era evidence and lessons, not active workspace files. |
| root legacy foundation `.md` files | MOVE_TO_ARCHIVE | Useful historical evidence only if unique. |
| root helper `.ps1` scripts | OWNER_DECISION_REQUIRED | Keep only current owner bootstrap scripts; otherwise archive or delete later. |
| `flutter_01.png` | DELETE_SAFE | Zero-byte temporary artifact. |
| `devtools_options.yaml`, `l10n.yaml` | OWNER_DECISION_REQUIRED | Keep if required by current Flutter/localization workflow. |

## Active Identity Validation

| Identity | Expected | Current Reality | Status |
| --- | --- | --- | --- |
| Firebase Project | `mental-smile-platform` | `.firebaserc` default is `mental-smile-platform` | PASS |
| Android applicationId | `com.mentalsmile.app` | `android/app/build.gradle.kts` | PASS |
| Namespace | `com.mentalsmile.os` | `android/app/build.gradle.kts` | PASS |
| Dart package | `mental_smile_os` | `pubspec.yaml` | PASS |
| Hosting URL | `https://mental-smile-platform.web.app` | App exit link and Firebase target align | PASS |
| GitHub Pages | Documentation / OS showcase only | Role card created | PASS |

## Big Boss Clean Room Residue

Filtered active scan before final registry cleanup found:

| Term | Occurrence | Classification |
| --- | --- | --- |
| `mental_smile_clean_core` | source folder and construction registry reference | ARCHIVE_ALLOWED before registry removal |

The active construction registry entry for `mental_smile_clean_core` was removed before clean workspace packaging because the clean workspace must not include the core source folder as an active tool target.

Expected clean workspace residue state:

No active `mental-smile-app-clean`, `mental-smile-app-clean2`, `MentalKey`, `flutterprojects`, or `mental_smile_clean_core` references.

## Activation Status

The clean workspace can be prepared, but final certification requires Owner-run validation commands from the new folder.

Final result: OWNER_ACTION_REQUIRED
