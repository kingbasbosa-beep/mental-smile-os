# PRODUCTION_RUNTIME_WARNINGS_V1

## Purpose

Register warnings for current runtime production candidacy.

## Warnings

| ID | Warning | Area | Severity |
| --- | --- | --- | --- |
| RT_WARN_001 | Runtime is still hosted inside legacy-named `mental-smile-app-clean2`. | Workspace | HIGH |
| RT_WARN_002 | Runtime package name remains `flutterprojects`. | Flutter/YAML | HIGH |
| RT_WARN_003 | 74 files contain `package:flutterprojects` imports. | Dart package identity | HIGH |
| RT_WARN_004 | `mental_smile_clean_core` remains active local dependency. | Dependency | HIGH |
| RT_WARN_005 | Android namespace/applicationId remains `com.mentalkey.app.flutterprojects`. | Android | HIGH |
| RT_WARN_006 | Owner runtime contains many placeholder surfaces. | Owner | MEDIUM |
| RT_WARN_007 | Monitoring runtime contains placeholder-heavy surfaces. | Monitoring | MEDIUM |
| RT_WARN_008 | Federation gateway runtime is partial, not fully operational. | Gateways | HIGH |
| RT_WARN_009 | Signal routing exists but full zone gateway execution is not complete. | Signals | MEDIUM |
| RT_WARN_010 | Asset purity remains broad and unresolved. | Assets/YAML | HIGH |
| RT_WARN_011 | Firebase activation is READY_WITH_WARNINGS, not clean READY. | Firebase | HIGH |
| RT_WARN_012 | Several web/city/capital surfaces are scaffolds. | Runtime surfaces | MEDIUM |

## Handling Rule

Warnings do not block production candidacy, but they must be resolved or accepted before final production launch.
