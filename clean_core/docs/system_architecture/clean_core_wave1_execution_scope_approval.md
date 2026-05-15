# clean_core Wave 1 Execution Scope Approval

## Scope Approval

Wave 1 may include only pure-Dart contract directories that passed prior scan and planning phases.

## Approved Primary Scope

Primary approved groups:

- `lib/core/backend_boundaries/`
- `lib/core/safety_decision/`
- `lib/core/policy_runtime/`
- `lib/core/trusted_backend/`
- `lib/core/trusted_pipeline/`

These groups are approved because they are intended as contract/governance surfaces rather than runtime implementations.

## Conditional Scope

Conditional groups:

- `lib/core/governance_kernel/`
- `lib/core/governance_lifecycle/`
- `lib/core/governance_compliance/`
- `lib/core/governance_capability/`
- `lib/core/governance_federation/`

These require semantic review before public export because governance capability and federation surfaces may contain internal-only or authority-sensitive concepts.

## Explicitly Excluded Scope

Excluded:

- Firebase runtime/config
- Flutter UI
- routing/navigation
- localization generation
- assets
- provider SDKs
- networking
- Cloud Functions runtime
- auth runtime
- storage runtime
- app-coupled tests
- Firestore-coupled contracts

## Scope Limits

Wave 1 must not:

- create runtime execution paths
- create provider execution paths
- create backend runtime clients
- create Firebase integrations
- create networking integrations
- grant client-side trusted authority
- expose internal/deferred contracts through broad barrels

## Scope Verdict

Scope is approved only for narrow contract extraction with manual checkpoints and curated export review.
