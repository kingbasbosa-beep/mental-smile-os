# ARCHIVE_WORKSPACE_CLASSIFICATION_V1

## Purpose

Classify non-active workspace material as archive candidates after active workspace declaration.

## Classifications

| Workspace / Area | Classification | Reason |
| --- | --- | --- |
| `_archive/` | ARCHIVE | Historical evidence. |
| Root legacy markdown docs | ARCHIVE_CANDIDATE | Prior planning and clean-core history. |
| `docs/` legacy documentation | ARCHIVE_CANDIDATE | Distinct from active OS docs root. |
| `mental_smile_clean_core/` | SOURCE_REFERENCE / MIGRATION_CANDIDATE | Current dependency; must be extracted or retired later. |
| `mental-smile-os-runtime/` | RUNTIME_PLANNING_REFERENCE | Signal routing bootstrap docs, not executable runtime. |
| `.firebase/` | GENERATED_CACHE | Not source workspace. |
| `.dart_tool/` | GENERATED_CACHE | Not source workspace. |
| `build/` | GENERATED_OUTPUT | Not source workspace. |
| `node_modules/` | GENERATED_DEPENDENCY_OUTPUT | Not source workspace. |
| `functions/node_modules/` | GENERATED_DEPENDENCY_OUTPUT | Not source workspace. |
| `test/node_modules/` | GENERATED_DEPENDENCY_OUTPUT | Not source workspace. |

## Rule

Archive classification does not authorize deletion, movement, or cleanup.
