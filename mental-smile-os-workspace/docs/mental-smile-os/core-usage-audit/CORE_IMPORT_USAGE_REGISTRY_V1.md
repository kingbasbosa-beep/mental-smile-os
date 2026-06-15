# CORE_IMPORT_USAGE_REGISTRY_V1

## Registry

| ID | File Path | Import / Reference Line | Used Symbols | Runtime Area | Classification | Risk | Suggested Fate |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CORE_USAGE_001 | `pubspec.yaml` | `mental_smile_clean_core:` / `path: mental_smile_clean_core` | package dependency | Dependency graph | DIRECT_IMPORT | MEDIUM | REMOVE_AFTER_REPLACEMENT |
| CORE_USAGE_002 | `pubspec.lock` | `mental_smile_clean_core` path dependency lock entry | resolved package dependency | Dependency lock | TRANSITIVE_DEPENDENCY | LOW | REMOVE_AFTER_REPLACEMENT |
| CORE_USAGE_003 | `test/mental_smile_clean_core_import_test.dart` | `import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';` | `AuditActorType`, `AuditActorType.admin`, `AuditActorTypeKey.key` | Test-only integration proof | DIRECT_IMPORT | LOW | REPLACE_WITH_OS_MODULE |
| CORE_USAGE_004 | `lib/features/sovereign_construction/domain/construction_tool_registry.dart` | local path string to `mental_smile_clean_core` | none; path reference only | Owner Construction Workbench source link | LEGACY_RESIDUE | LOW | KEEP_TEMPORARY |

## Classification Notes

`CORE_USAGE_003` is the only direct Dart import discovered in active app/test scope.

`CORE_USAGE_004` is not a package dependency or code import. It is a source repository reference used by the Construction Workbench.

