# clean_core Package Bootstrap Plan

This blueprint defines the future package bootstrap sequence without executing it.

## Bootstrap Goals

- Establish package identity.
- Preserve pure Dart posture.
- Preserve declarative contract-only behavior.
- Avoid runtime dependency leakage.
- Prepare for scoped host reconnect.

## Future Bootstrap Sequence

1. Confirm working tree and rollback checkpoint.
2. Create minimal `mental_smile_clean_core/pubspec.yaml`.
3. Keep dependency list empty.
4. Keep root barrel explicit and curated.
5. Add package-local documentation if needed.
6. Add pure Dart test directory only after test plan approval.
7. Add host path dependency in a separate step.
8. Migrate imports in a scoped follow-up.

## Initial Package Contents

Current shell should remain limited to:

- `lib/mental_smile_clean_core.dart`
- `lib/src/backend_boundaries/`
- `lib/src/safety_decision/`
- `lib/src/policy_runtime/`
- `lib/src/trusted_backend/`
- `lib/src/trusted_pipeline/`
- `lib/src/governance/`

## Bootstrap Non-Goals

- No Firebase.
- No Flutter UI.
- No networking.
- No provider SDKs.
- No runtime bridge.
- No host route reconnect.
- No package publishing.

## Bootstrap Checkpoint Requirements

Each bootstrap step requires:

- explicit diff review
- dependency review
- export surface review
- hidden contract review
- rollback confirmation

## Bootstrap Verdict

The package is ready for future minimal identity bootstrap, but not ready for runtime activation or broad host reconnect.
