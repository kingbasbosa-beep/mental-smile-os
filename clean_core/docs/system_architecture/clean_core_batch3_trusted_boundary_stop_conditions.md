# clean_core Batch 3 Trusted Boundary Stop Conditions

## Mandatory Stop Conditions

Stop Batch 3 movement if any of the following appear before or during movement:

- Firebase import
- Firestore import
- Firebase options/config import
- Flutter UI import
- `BuildContext` dependency
- Navigator/router dependency
- generated localization/config/router/assets import
- provider SDK import
- networking import
- Cloud Functions runtime import
- backend runtime client
- orchestration/runtime execution implementation
- provider execution implementation
- app-owned package import
- parent-path escaping import
- client-side trusted authority expansion
- privileged client-write authority
- broad wildcard export
- fail-closed weakening
- deny-by-default weakening

## Manual Review Conditions

Pause for manual review if:

- trusted backend guard/boundary/policy is proposed for public export
- trusted pipeline guard/policy/check API is proposed for public export
- an `allowed` result is treated as runtime authorization
- a trusted marker is treated as signed backend authority
- review/audit requirements become optional
- provider/runtime allowance defaults become permissive

## Current Review Result

No mandatory stop condition was found in the current trusted backend or trusted pipeline source.

Manual review is required for public export of:

- `trusted_backend_boundary.dart`
- `trusted_backend_guard.dart`
- `trusted_backend_policy.dart`
- `trusted_pipeline.dart`
- `trusted_pipeline_guard.dart`
- `trusted_pipeline_policy.dart`

## Stop Response

If a stop condition appears later:

- do not move Batch 3
- do not modify barrels
- document the offending file
- classify as blocked, internal-only, adapter-required, or runtime-deferred
- preserve rollback clarity
