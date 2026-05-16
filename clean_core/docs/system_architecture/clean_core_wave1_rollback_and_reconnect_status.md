# clean_core Wave 1 Rollback and Reconnect Status

## Rollback Status

Rollback remains clear because Wave 1 moved complete, isolated directories into `mental_smile_clean_core/lib/src/`.

Original moved source directories no longer exist under `clean_core/lib/core/` for:

- `backend_boundaries`
- `safety_decision`
- `policy_runtime`
- `trusted_backend`
- `trusted_pipeline`
- `governance_kernel`
- `governance_lifecycle`
- `governance_compliance`
- `governance_capability`
- `governance_federation`

Backup and rollback tags remain the recovery baseline.

## Reconnect Status

Reconnect remains minimal and scoped.

Known scoped reconnect:

- affected tests use a temporary relative import to `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

No broad host migration was performed.

## Host Ownership

Host app still owns:

- Firebase runtime
- auth/session runtime
- routing/navigation
- localization generation
- assets
- Flutter UI
- platform setup
- provider SDK runtime
- telemetry/analytics runtime
- deployment/release runtime

## Reconnect Verdict

Wave 1 reconnect is acceptable as a temporary shell-stage reconnect. Future package imports should wait until a standalone package identity and `pubspec.yaml` are introduced.
