# PRODUCTION_WARNING_REGISTRY_V1

## Purpose

Register production warnings found during candidate audit.

## Warnings

| ID | Warning | Area | Risk |
| --- | --- | --- | --- |
| PROD_WARN_001 | Runtime is still hosted inside legacy-named `mental-smile-app-clean2`. | Workspace / Runtime | MEDIUM |
| PROD_WARN_002 | Pure OS runtime is not independently extracted. | Runtime | HIGH |
| PROD_WARN_003 | Package name remains `flutterprojects`. | YAML / Dart imports | MEDIUM |
| PROD_WARN_004 | Android namespace/applicationId remains `com.mentalkey.app.flutterprojects`. | Android | HIGH |
| PROD_WARN_005 | `mental_smile_clean_core` remains an active local dependency. | Runtime dependency | HIGH |
| PROD_WARN_006 | Firebase final rules validation was not executed in this step. | Firebase | HIGH |
| PROD_WARN_007 | Git worktree contains many untracked documentation/runtime-planning artifacts. | GitHub release | MEDIUM |
| PROD_WARN_008 | Generated `.firebase/` cache exists untracked. | Firebase / Git hygiene | MEDIUM |
| PROD_WARN_009 | Assets remain broad and not fully pruned into pure OS runtime families. | YAML / Assets | HIGH |
| PROD_WARN_010 | Launch readiness depends on local validation commands not run in this audit. | Runtime / QA | HIGH |

## Required Handling

Warnings must be resolved or explicitly accepted before final production activation.
