# clean_core Batch 2 Policy Runtime Export Decision

## Export Strategy

Policy runtime should be moved as a Batch 2 contract group, but public exports should be conservative and curated.

## Export-Safe Candidates

These files appear suitable for public export after Batch 2 movement:

- `runtime_policy_audit_link.dart`
- `runtime_policy_fallback.dart`
- `runtime_policy_mode.dart`
- `runtime_policy_module.dart`
- `runtime_policy_requirement.dart`
- `runtime_policy_restriction.dart`
- `runtime_policy_scope.dart`
- `runtime_policy_snapshot_reference.dart`
- `runtime_policy_state.dart`

Reason:

- These are enums, references, state objects, restrictions, requirements, and fallback contracts.
- They do not execute providers, activate runtime, call Firebase, or perform networking.

## Export After Semantic Review

These files should move but remain hidden or review-required before public barrel export:

- `runtime_policy_guard.dart`
- `runtime_policy_pack.dart`
- `runtime_policy_profile.dart`
- `runtime_policy_resolver.dart`

Reason:

- They define policy evaluation and profile selection semantics.
- `RuntimePolicyResolver` contains the most authority-sensitive surface because `allowed` depends on `failClosed`.
- Public exposure could be misread as a runtime authorization API before backend authority is formalized.

## Internal/Hidden by Default

No file is blocked from movement, but the resolver/guard/profile/pack group should be hidden by default in the first Batch 2 root barrel update unless explicitly approved.

## Broad Export Risk

Do not export `policy_runtime` as a whole directory.

Required future barrel rule:

- add file-by-file exports only
- keep resolver/profile/pack/guard out of root export until review
- avoid names that imply runtime activation or provider permission

## Export Decision Verdict

Move-ready as a directory. Public-export-ready only for stable policy contracts. Evaluation/resolution semantics require review before root barrel exposure.
