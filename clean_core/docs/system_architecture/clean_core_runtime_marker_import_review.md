# clean_core Runtime Marker Import Review

Phase: EX-32 - Runtime Marker Isolation Review

## Scope

This review covers runtime marker, boundary marker, runtime state, and observability-related files only.

No package movement, export changes, dependency changes, runtime activation, provider activation, or adapter implementation occurred.

## Import Findings

The inspected marker and observability files did not show direct dependency on:

- Firebase SDKs
- `cloud_firestore`
- Flutter UI
- generated localization/config/router/assets
- provider SDKs
- networking clients
- Cloud Functions runtime clients
- app-owned feature imports

## Local Import Patterns

Some observability files use local clean-core imports, for example:

- observability profile imports observation, runtime marker, audit link, review marker, requirement, scope, state, visibility, lock, and policy contracts
- observability guard imports profile, policy, lock, block reason, stage, scope, state, and visibility contracts
- safety observability contract imports audit reference and audit runtime marker

These imports are local and declarative, but the semantics are not automatically export-safe.

## Parent Path and App-Owned Import Review

No parent-path escaping import pattern was identified in the reviewed marker set.

No app-owned import pattern was identified in the reviewed marker set.

## Import Risk Classification

| Import type | Finding | Risk |
| --- | --- | --- |
| Firebase | Not found in reviewed marker set | No current import contamination |
| Flutter UI | Not found in reviewed marker set | No current UI contamination |
| Provider SDK | Not found in reviewed marker set | No current provider SDK contamination |
| Networking | Not found in reviewed marker set | No current network contamination |
| Generated files | Not found in reviewed marker set | No current generated-file contamination |
| Local governance imports | Present in observability family | Semantically sensitive |
| Parent-path escape | Not found in reviewed marker set | No current package escape |

## Import Verdict

The reviewed marker files are import-clean for extraction planning purposes, but import cleanliness does not equal export readiness. Observability guard, policy, lock, and profile semantics remain hidden/review-gated despite pure Dart imports.

