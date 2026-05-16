# clean_core Path Dependency Checkpoint

This checkpoint records the state after adding the host app local path dependency to `mental_smile_clean_core`.

## Completed

- Added a single host app path dependency to `mental_smile_clean_core`.
- Preserved dependency-free package pubspec.
- Created architecture verification docs.

## Not Changed

- No host imports.
- No package source files.
- No package barrel.
- No adapter files.
- No runtime files.
- No provider files.
- No Firebase/routing/localization/assets wiring.

## Rollback Safety

Rollback remains trivial:

1. Remove the `mental_smile_clean_core` dependency entry from host `pubspec.yaml`.
2. Leave the package shell intact.
3. No import restoration is required because no imports were migrated.

## Stop Conditions for Next Phase

Stop future reconnect work if it introduces:

- broad import rewrites
- package imports of app-owned files
- Firebase/Flutter dependencies inside `mental_smile_clean_core`
- provider SDKs
- networking/runtime clients
- analytics/telemetry
- adapter implementation
- runtime/provider execution
- Wave 2 movement without review

## Checkpoint Verdict

Path dependency activation is complete and rollback-safe. The next step should be scoped import/test reconnect only if explicitly approved.
