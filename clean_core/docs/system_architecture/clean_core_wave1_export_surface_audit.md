# clean_core Wave 1 Export Surface Audit

## Reviewed File

- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

## Export Style

Confirmed:

- exports are explicit file-by-file exports
- no wildcard exports
- no directory-wide exports
- no generated files exported
- no Flutter UI exported
- no Firebase/runtime/provider/networking exports
- no app-owned exports

## Exported Surface

The root barrel currently exposes approved declarative contracts from:

- backend boundaries
- safety decisions
- policy runtime contract records
- trusted backend declarative contracts
- trusted pipeline declarative contracts
- governance kernel declarative contracts
- governance lifecycle declarative contracts
- governance compliance declarative contracts
- governance capability declarative contracts
- governance federation declarative contracts

## Hidden Authority-Sensitive Surfaces

Confirmed hidden from the root barrel:

- safety decision engine
- policy guards, packs, profiles, resolvers
- trusted backend boundary, guard, policy
- trusted pipeline check API, guard, policy
- governance kernel check API, boundary, guard, policy
- governance lifecycle check API, guard, lock, policy
- governance compliance guard, policy, profile
- governance capability main object, guard, policy
- governance federation main object, guard, lock, policy

## Export Verdict

The Wave 1 export surface remains narrow, explicit, and consistent with the approved fail-closed extraction rules.
