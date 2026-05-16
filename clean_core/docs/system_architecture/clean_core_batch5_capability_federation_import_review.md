# clean_core Batch 5 Capability and Federation Import Review

## Scope

Reviewed imports under:

- `clean_core/lib/core/governance_capability/`
- `clean_core/lib/core/governance_federation/`

## Import Findings

All imports are local sibling Dart imports.

No imports were found for:

- Firebase
- Firestore
- Firebase options/config
- Flutter UI
- `BuildContext`
- Navigator/router
- generated localization/config/router/assets
- provider SDKs
- networking libraries
- Cloud Functions
- app-owned package paths
- parent-path escaping imports

## Capability Import Summary

Local imports appear in:

- `governance_capability.dart`
- `governance_capability_guard.dart`
- `governance_capability_policy.dart`
- `governance_capability_requirement.dart`
- `governance_capability_fallback.dart`
- `governance_capability_reference.dart`

These imports should remain package-local after movement.

## Federation Import Summary

Local imports appear in:

- `governance_federation.dart`
- `governance_federation_guard.dart`
- `governance_federation_fallback.dart`
- `governance_federation_reference.dart`
- `governance_federation_policy.dart`

These imports should remain package-local after movement.

## Contamination Finding

No import contamination was found in Batch 5 candidate files.

## Import Verdict

Both directories are import-clean for Batch 5 movement. No import rewrite should be performed before movement.
