# ACTIVE_RUNTIME_BOUNDARY_REPORT_V1

## Purpose

Define the boundary between current active runtime, pure OS runtime target, source repository, and archive.

## Current Reality

The current active executable runtime is still the legacy host Flutter app in `mental-smile-app-clean2`.

The OS documentation root exists at `mental-smile-os-workspace`.

The signal routing bootstrap exists at `mental-smile-os-runtime`, but it is not an executable Flutter runtime.

## Boundary Classification

| Area | Boundary |
| --- | --- |
| `lib/` | Active runtime source. |
| `assets/` | Active runtime assets; migration requires asset cards. |
| `android/` | Active Android runtime host. |
| `web/` | Active web runtime host. |
| `firebase.json`, rules, functions | Active Firebase surface. |
| `mental-smile-os-workspace/` | Active OS documentation root. |
| `mental-smile-os-runtime/` | OS runtime planning/bootstrap docs, not executable runtime. |
| `mental_smile_clean_core/` | Current local dependency and source/reference package. |
| `_archive/` | Historical evidence. |
| Generated folders | Not source runtime. |

## Production Survival Boundary

Only active Flutter runtime files, approved assets, approved localization, approved Firebase references, and approved route/signal/gateway components may survive into Generation 1 production.

Anything not classified remains UNKNOWN and cannot be silently imported into pure runtime.
