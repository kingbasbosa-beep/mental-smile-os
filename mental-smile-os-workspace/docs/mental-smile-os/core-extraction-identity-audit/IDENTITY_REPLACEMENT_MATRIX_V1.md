# IDENTITY_REPLACEMENT_MATRIX_V1

## Purpose

Map every legacy technical identity to its target decision.

## Matrix

| Current Identity | Target Identity / State | Classification | Execution Phase |
| --- | --- | --- | --- |
| `flutterprojects` package name | OS-owned Dart package name, pending Owner decision | RENAME | Package identity phase |
| `package:flutterprojects/...` imports | New OS package imports | RENAME | Package identity phase |
| `mental_smile_clean_core` dependency | Extracted OS-owned contracts or removed dependency | REPLACE | Core extraction phase |
| `com.mentalkey.app.flutterprojects` Android namespace | OS-owned namespace, pending Owner decision | RENAME | Android identity phase |
| `com.mentalkey.app.flutterprojects` Android applicationId | Owner-approved production applicationId | RENAME_WITH_OWNER_DECISION | Android/Play Store phase |
| `com.mentalkey.app` Windows metadata | OS-owned company/application metadata | RENAME | Windows identity phase if Windows survives |
| `flutterprojects.exe` | OS-owned executable name | RENAME | Windows identity phase if Windows survives |
| `Mental Smile Core Source Repository` | Keep as source repository reference only | KEEP | Documentation/source reference |
| `mental-smile-app-clean2` paths | Keep as current host repository path until extraction | KEEP_TEMPORARY_TECHNICAL_PATH | Workspace extraction phase |
| `legacy` compatibility comments | Keep if marking blocked/disabled legacy behavior | KEEP_WITH_REVIEW | Code cleanup phase |

## Rule

No identity replacement should be performed without a scoped execution patch and validation run.
