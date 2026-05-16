# clean_core Wave 1 Hidden Contracts Review

## Purpose

This review documents intentionally hidden package-local surfaces that require future semantic approval before public export.

## Hidden Categories

Hidden categories include:

- guards
- policies
- locks
- resolvers
- boundary evaluators
- check APIs
- main runtime-like or authority-like objects

## Hidden Contract Groups

Policy runtime hidden surfaces:

- `runtime_policy_guard.dart`
- `runtime_policy_pack.dart`
- `runtime_policy_profile.dart`
- `runtime_policy_resolver.dart`

Trusted boundary hidden surfaces:

- `trusted_backend_boundary.dart`
- `trusted_backend_guard.dart`
- `trusted_backend_policy.dart`
- `trusted_pipeline.dart`
- `trusted_pipeline_guard.dart`
- `trusted_pipeline_policy.dart`

Governance hidden surfaces:

- kernel check/boundary/guard/policy
- lifecycle check/guard/lock/policy
- compliance guard/policy/profile
- capability main object/guard/policy
- federation main object/guard/lock/policy

Safety hidden surface:

- `safety_decision_engine.dart`

## Review Finding

These files remain package-local only. They are intentionally excluded from the root barrel because they can imply authority, evaluation, runtime permission, transition approval, policy resolution, or distributed governance coordination.

## Future Rule

Any future public exposure of hidden contracts requires:

- semantic review
- authority review
- fail-closed review
- backend-governance review
- export surface review
