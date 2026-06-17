# OS_ONLY_PURIFICATION_DECISION_MATRIX_V1

| Area | Current Reality | Classification | Decision | Owner Required |
| --- | --- | --- | --- | --- |
| Dart package name | `mental_smile_os` | SAFE_IGNORE | Keep. | No |
| Pubspec description | Mental Smile OS aligned | SAFE_IGNORE | Keep. | No |
| `mental_smile_clean_core` dependency | Not present in `pubspec.yaml` or `pubspec.lock` | SAFE_IGNORE | Keep removed. | No |
| Test wording | Mentions `clean core` as proof label | SAFE_IGNORE | Optional cleanup. | No |
| App class name | `MentalKeyApp` | ACTIVE_BLOCKER | Rename in Wave 1. | Low-risk approval |
| Theme builder name | `buildMentalKeyTheme` | ACTIVE_BLOCKER | Rename in Wave 1. | Low-risk approval |
| Android applicationId | `com.mentalkey.app.flutterprojects` | VISIBLE_RESIDUE | Defer. | Yes |
| Firebase project IDs | `mental-smile-app-clean` | ACTIVE_BLOCKER | Defer. | Yes |
| GitHub Actions Firebase project IDs | `mental-smile-app-clean` | VISIBLE_RESIDUE | Defer. | Yes |
| Exit Website official URL | `https://mental-smile-app-clean.web.app` | VISIBLE_RESIDUE | Replace after final domain decision. | Yes |
| Construction Workbench source paths | `mental-smile-app-clean2`, `mental_smile_clean_core` | ARCHIVE_ALLOWED | Keep as source evidence for now. | Yes before changing |
| Historical docs | Thousands of source/archive references | ARCHIVE_ALLOWED | Preserve. | No |

## Decision

OS_ONLY_PURIFICATION_WAVE_1 is safe if limited to internal Dart symbol rename plus optional test wording cleanup.

Infrastructure identity must not be included in the first cleanup wave.

