# CORE_EXTRACTION_REPORT_V1

## Result

All remaining technical identities are now visible.

## Created Outputs

| Output | Status |
| --- | --- |
| CORE_DEPENDENCY_AUDIT_V1 | CREATED |
| TECHNICAL_IDENTITY_AUDIT_V1 | CREATED |
| PACKAGE_NAME_AUDIT_V1 | CREATED |
| NAMESPACE_AUDIT_V1 | CREATED |
| LEGACY_BRANDING_AUDIT_V1 | CREATED |
| CORE_EXTRACTION_PLAN_V1 | CREATED |
| IDENTITY_REPLACEMENT_MATRIX_V1 | CREATED |
| CORE_EXTRACTION_REPORT_V1 | CREATED |

## Hard Findings

- `flutterprojects` remains the active Dart package name.
- 74 files contain `package:flutterprojects` imports.
- `mental_smile_clean_core` remains an active local dependency.
- Android namespace remains `com.mentalkey.app.flutterprojects`.
- Android applicationId remains `com.mentalkey.app.flutterprojects`.
- Windows metadata still contains `flutterprojects` and `com.mentalkey.app`.
- Visible Android app label is already `Mental Smile`.
- `Mental Smile Core Source Repository` is acceptable only as a source repository reference.

## Classification Summary

| Identity | Classification |
| --- | --- |
| `flutterprojects` | RENAME |
| `mental_smile_clean_core` | REPLACE |
| `com.mentalkey.app.flutterprojects` | RENAME |
| `com.mentalkey.app` | RENAME |
| `Mental Smile Core Source Repository` | KEEP |
| `mental-smile-app-clean2` path | KEEP_TEMPORARY_TECHNICAL_PATH |
| `legacy` compatibility labels | KEEP_WITH_REVIEW |

## Prompt Registration

PROMPT_ASSET_075 registered.

Parent Prompt: PROMPT_ASSET_074.

Classification: CORE_EXTRACTION_AND_IDENTITY_AUDIT_PROMPT.

## Boundaries

No runtime changes.

No package rename.

No namespace rename.

No dependency removal.

No Firebase changes.

No YAML changes.

No file movement.
