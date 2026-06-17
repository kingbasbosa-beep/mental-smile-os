# REPOSITORY_STATE_REPORT_V1

## Branch

Current branch:

```text
ai-lab
```

## Tracked Modified Areas

| Area | Classification | Notes |
| --- | --- | --- |
| `android/app/build.gradle.kts` | KEEP_FOR_RELEASE | Namespace migration |
| `android/app/src/main/AndroidManifest.xml` | KEEP_FOR_RELEASE | Explicit MainActivity class |
| `android/app/src/main/kotlin/.../MainActivity.kt` | KEEP_FOR_RELEASE | Kotlin package declaration |
| `firestore.rules` | KEEP_FOR_RELEASE | Duplicate monitoring helper removed |
| `lib/` Dart files | KEEP_FOR_RELEASE | Package import migration to `mental_smile_os` |
| `pubspec.yaml` | KEEP_FOR_RELEASE | Package rename and core dependency removal |
| `pubspec.lock` | KEEP_FOR_RELEASE | Core dependency lock removal after Owner validation |
| `test/mental_smile_clean_core_import_test.dart` | KEEP_FOR_RELEASE | Core import isolated |
| `mental-smile-os-workspace/docs/...` tracked roots | KEEP_FOR_RELEASE | Registry/progress/master docs updated |

## Untracked High-Level Areas

| Area | Classification | Notes |
| --- | --- | --- |
| `.firebase/` | EXCLUDE_FROM_RELEASE | Local Firebase hosting cache |
| `mental-smile-os-runtime/` | REQUIRES_OWNER_DECISION | Signal-routing runtime docs/source candidate |
| `forensic-audit/` | REQUIRES_OWNER_DECISION | Include if Owner wants full post-handoff record in first commit |
| `execution-era/` generated additions | KEEP_FOR_RELEASE | Execution history and tracker context |
| `release-candidate-v1/` | KEEP_FOR_RELEASE | RC certificate and scorecard |
| `identity-cleanup-wave-1/` | KEEP_FOR_RELEASE | Identity wave evidence |
| `android-namespace-wave-1/` | KEEP_FOR_RELEASE | Namespace migration evidence |
| `core-extraction-wave-1/` | KEEP_FOR_RELEASE | Core extraction evidence |
| `firebase-warning-cleanup-wave-1/` | KEEP_FOR_RELEASE | Firebase cleanup evidence |
| prompt records `PROMPT_ASSET_067` through `PROMPT_ASSET_090` | KEEP_FOR_RELEASE | Required lineage records |

## Repository Risk

Risk: MEDIUM

Reason: release content is valid but staging scope must be carefully curated before first commit.

