# IDENTITY_EXECUTION_RISK_MATRIX_V1

## Purpose

Identify risks during identity execution.

## Risk Matrix

| Risk | Severity | Impact | Mitigation |
| --- | --- | --- | --- |
| Partial Dart import rename | HIGH | Analyzer/build failure | Single scoped replacement and analyzer run. |
| Package name rename breaks generated references | MEDIUM | Build failure | Regenerate or update generated references after pub get. |
| Android namespace path mismatch | HIGH | Android build failure | Move Kotlin path and package declaration together. |
| applicationId changed too early | HIGH | Firebase/Play Store identity break | Defer until store-ready Owner decision. |
| Core dependency extraction misses symbol | HIGH | Analyzer/runtime failure | Inventory used symbols first. |
| Removing core package too soon | HIGH | Build failure | Keep temporary until replacement validates. |
| Windows metadata left dirty | LOW | Desktop branding residue | Cleanup only if Windows target survives. |
| Validation skipped | HIGH | Hidden runtime breakage | Require all validation commands. |

## Overall Risk

Overall identity execution risk: HIGH.

Proceed only with Owner-approved scoped patches.
