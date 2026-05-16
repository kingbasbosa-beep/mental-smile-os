# clean_core Future Pubspec Blueprint

## Status

This is a blueprint only. No `pubspec.yaml` is created by this document.

## Future Pubspec Goals

The future package identity should:

- stay pure Dart first
- avoid Flutter dependency
- avoid Firebase dependency
- avoid provider SDK dependency
- avoid networking dependency
- avoid platform runtime dependency
- preserve declarative contract behavior

## Allowed Dependency Categories

Allowed only after review:

- Dart SDK only
- small pure-Dart utility dependencies if unavoidable
- test-only pure-Dart dependencies for contract tests
- linting packages if package-owned and pure Dart compatible

Preferred starting point:

- no runtime dependencies beyond Dart SDK

## Blocked Dependency Categories

Blocked:

- Firebase packages
- Flutter SDK/UI packages
- provider SDKs
- networking clients
- analytics SDKs
- telemetry runtimes
- platform runtimes
- Cloud Functions runtimes
- generated localization/config packages
- app shell packages

## Temporary Path Dependency Strategy

The host app may later reference the package through a temporary path dependency only after package identity is approved.

Rules:

- path dependency should be explicit
- reconnect should be scoped
- no broad host import rewrite
- no runtime activation during reconnect
- rollback path must remain clear

## Future Registration Approach

Recommended posture:

- internal/private package first
- local path dependency first
- no public publishing until governance and semantic exposure risks are reviewed

## Pubspec Verdict

A future `pubspec.yaml` may be introduced only after final dependency-law review confirms the package remains pure Dart and contract-only.
