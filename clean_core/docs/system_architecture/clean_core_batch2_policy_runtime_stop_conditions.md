# clean_core Batch 2 Policy Runtime Stop Conditions

## Mandatory Stop Conditions

Stop Batch 2 movement if any of the following appear before or during movement:

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
- app-owned package import
- parent-path escaping import
- runtime activation implementation
- provider execution implementation
- client-side authority expansion
- privileged client-write authority
- broad wildcard export
- fail-closed weakening
- deny-by-default weakening

## Manual Review Conditions

Pause for manual review if:

- resolver semantics imply runtime permission
- profile authoring allows permissive runtime behavior
- guard behavior is treated as backend authorization
- fallback behavior becomes permissive
- policy pack selection creates client-side authority
- public barrels expose resolver/guard/profile/pack without review

## Current Review Result

No mandatory stop condition was found in the current `policy_runtime` source.

Manual review is required for public export of:

- `runtime_policy_guard.dart`
- `runtime_policy_pack.dart`
- `runtime_policy_profile.dart`
- `runtime_policy_resolver.dart`

## Stop Response

If a stop condition appears later:

- do not move Batch 2
- do not modify barrels
- document the offending file
- classify as blocked, internal-only, adapter-required, or runtime-deferred
- preserve rollback clarity
