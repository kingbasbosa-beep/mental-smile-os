# clean_core Batch 4 Governance Stop Conditions

## Mandatory Stop Conditions

Stop Batch 4 movement if any of the following appear before or during movement:

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
- orchestration/runtime execution implementation
- provider execution implementation
- app-owned package import
- parent-path escaping import
- governance authority expansion
- privileged client-write authority
- federation/runtime dependency assumption
- broad wildcard export
- fail-closed weakening
- deny-by-default weakening

## Manual Review Conditions

Pause for manual review if:

- governance kernel check APIs are proposed for public export
- lifecycle transition checks are proposed for public export
- compliance guard/profile/policy APIs are proposed for public export
- `allowed` results are treated as backend authority
- lifecycle transitions are treated as executable state changes
- compliance markers are treated as legal/runtime authorization
- backend governance requirements become optional
- provider/runtime defaults become permissive

## Current Review Result

No mandatory stop condition was found in the current governance kernel, lifecycle, or compliance source.

Manual review is required for public export of evaluation and authority-adjacent surfaces.

## Stop Response

If a stop condition appears later:

- do not move Batch 4
- do not modify barrels
- document the offending file
- classify as blocked, internal-only, adapter-required, or runtime-deferred
- preserve rollback clarity
