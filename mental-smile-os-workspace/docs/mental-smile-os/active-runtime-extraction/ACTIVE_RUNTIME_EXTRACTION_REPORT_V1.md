# ACTIVE_RUNTIME_EXTRACTION_REPORT_V1

## Result

Generation 1 active runtime has been identified.

## Reality Summary

The surviving runtime is currently the Flutter application in `mental-smile-app-clean2`, not a fully separated pure OS runtime.

The pure OS runtime has not yet been extracted as an independent executable root.

## Created Outputs

| Output | Status |
| --- | --- |
| ACTIVE_RUNTIME_MANIFEST_V1 | CREATED |
| ACTIVE_RUNTIME_FILE_REGISTRY_V1 | CREATED |
| ACTIVE_RUNTIME_DEPENDENCY_REGISTRY_V1 | CREATED |
| ACTIVE_RUNTIME_KEEP_LIST_V1 | CREATED |
| ACTIVE_RUNTIME_MIGRATION_LIST_V1 | CREATED |
| ACTIVE_RUNTIME_ARCHIVE_LIST_V1 | CREATED |
| ACTIVE_RUNTIME_REMOVAL_LIST_V1 | CREATED |
| ACTIVE_RUNTIME_BOUNDARY_REPORT_V1 | CREATED |
| ACTIVE_RUNTIME_EXTRACTION_REPORT_V1 | CREATED |

## Key Reality Findings

- Current executable runtime root: `mental-smile-app-clean2`.
- Current route count: 81 declared route constants.
- Current Dart source count: 181 files under `lib/`.
- Current asset count: 193 files under `assets/`.
- Current local package dependency: `mental_smile_clean_core`, 165 files.
- Current Firebase hosting target: `build/web`.
- Current package technical identity remains `flutterprojects`.
- Current Android identity remains `com.mentalkey.app.flutterprojects`.

## Final Classification

| Class | Meaning |
| --- | --- |
| KEEP | Survives in current active host runtime. |
| MIGRATE | Candidate for pure OS runtime after card approval. |
| ARCHIVE | Historical/source evidence; not active runtime. |
| REMOVE | Generated/dead/runtime residue after archive or migration, not now. |
| UNKNOWN | Requires deeper audit before survival. |

## Prompt Registration

PROMPT_ASSET_072 registered.

Parent Prompt: PROMPT_ASSET_071.

Classification: ACTIVE_RUNTIME_EXTRACTION_PROMPT.

## Boundaries

No files were moved.

No files were deleted.

No runtime implementation was changed.

No Firebase changes were made.

No YAML changes were made.

No archive movement occurred.
