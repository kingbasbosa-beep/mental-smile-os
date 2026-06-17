# ARCHIVE_CANDIDATE_IDENTITY_REGISTRY_V1

## Archive-Allowed Identity References

Historical documentation may retain legacy names only when clearly functioning as history, source evidence, audit evidence, or migration records.

| Group | Examples | Classification | Action |
| --- | --- | --- | --- |
| Root `clean_core_ex*.md` files | `clean_core_ex101_*` through later clean-core reports | ARCHIVE_ALLOWED | Keep as historical evidence. Do not delete in OS-only audit. |
| `docs/history/legacy/` | legacy dump and admin search reports | ARCHIVE_ALLOWED | Keep. No active runtime risk. |
| `docs/registry/assets/` | duplicate asset references to `_archive/clean_core_legacy...` | ARCHIVE_ALLOWED | Keep as source evidence. |
| `docs/registry/localization/` | historical hardcoded text reports | ARCHIVE_ALLOWED | Keep as audit evidence. |
| `mental-smile-os-workspace/docs/.../active-runtime-*` | prior warnings mentioning `flutterprojects`, `mental_smile_clean_core`, `clean2` | INTERNAL_HISTORICAL_REFERENCE | Keep unless a future docs rewrite is explicitly approved. |
| `mental-smile-os-workspace/source-repository-links/` | `MENTAL_SMILE_CORE_SOURCE_LINK.md` | INTERNAL_HISTORICAL_REFERENCE | Keep. It correctly marks source repository role. |
| `mental-smile-os-workspace/tool-shortcuts/` | local path shortcuts | INTERNAL_HISTORICAL_REFERENCE | Keep for owner tools; not public app UI. |

## Not Archive Candidates Yet

| Item | Reason |
| --- | --- |
| `lib/features/sovereign_construction/domain/construction_tool_registry.dart` | Active owner tooling references source paths. Requires Owner decision before removal or rewrite. |
| `firebase.json` / `.firebaserc` / `lib/firebase_options.dart` | Active infrastructure identity, not archive material. |
| `android/app/build.gradle.kts` applicationId | Active Android identity, not archive material. |

