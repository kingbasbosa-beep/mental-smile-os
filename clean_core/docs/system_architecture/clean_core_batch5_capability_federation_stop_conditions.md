# clean_core Batch 5 Capability and Federation Stop Conditions

## Mandatory Stop Conditions

Stop Batch 5 movement if any of the following appear before or during movement:

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
- distributed authority expansion
- federation runtime activation assumption
- capability escalation authority
- privileged client-write authority
- permissive fallback default
- broad wildcard export
- fail-closed weakening
- deny-by-default weakening

## Manual Review Conditions

Pause for manual review if:

- capability object/guard/policy is proposed for public export
- federation object/guard/policy/lock is proposed for public export
- a capability is treated as executable permission
- federation references are treated as distributed runtime coordination
- signed authority placeholders are treated as real signatures
- lock/seal markers are treated as active enforcement
- provider/runtime defaults become permissive
- backend governance requirements become optional

## Current Review Result

No mandatory stop condition was found in the current capability or federation source.

Manual review is required for public export of authority-adjacent capability and federation surfaces.

## Stop Response

If a stop condition appears later:

- do not move Batch 5
- do not modify barrels
- document the offending file
- classify as blocked, internal-only, adapter-required, or runtime-deferred
- preserve rollback clarity
