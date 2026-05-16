# clean_core Batch 4 Governance Import Review

## Scope

Reviewed imports under:

- `clean_core/lib/core/governance_kernel/`
- `clean_core/lib/core/governance_lifecycle/`
- `clean_core/lib/core/governance_compliance/`

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

## Kernel Import Summary

Local imports appear in kernel boundary, policy, request, reference, fallback, guard, and check surfaces. These should remain package-local after movement.

## Lifecycle Import Summary

Local imports appear in lifecycle policy, transition, guard, fallback, and check surfaces. These should remain package-local after movement.

## Compliance Import Summary

Local imports appear in compliance policy, profile, reference, requirement, fallback, and guard surfaces. These should remain package-local after movement.

## Contamination Finding

No import contamination was found in Batch 4 candidate files.

## Import Verdict

All three governance directories are import-clean for Batch 4 movement. No import rewrite should be performed before movement.
