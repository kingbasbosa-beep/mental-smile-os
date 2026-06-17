# MENTAL_SMILE_CLEAN_CORE_USAGE_AUDIT_V1

## Purpose

Audit active usage of `mental_smile_clean_core` before extraction or removal.

## Audit Scope

- `pubspec.yaml`
- `pubspec.lock`
- `lib/`
- `test/`
- `integration_test/` if present
- `analysis_options.yaml`
- generated imports where discoverable
- active references to `mental_smile_clean_core`

## Summary

`mental_smile_clean_core` is still an active direct dependency, but active code usage is very small.

The host app has:

- one direct package dependency in `pubspec.yaml`
- one lockfile entry in `pubspec.lock`
- one direct Dart import in a proof test
- one runtime source-reference path in the Construction Workbench registry

## Counts

| Metric | Count |
| --- | --- |
| Files importing/referencing `mental_smile_clean_core` outside package source | 4 |
| Direct Dart import files | 1 |
| Runtime Dart source-reference files | 1 |
| Dependency declaration files | 2 |
| Used symbols/classes/functions from package | 3 |

## Used Symbols

- `AuditActorType`
- `AuditActorType.admin`
- `AuditActorTypeKey.key`

## Complexity

Dependency extraction complexity: LOW

Source repository/archive handling complexity: MEDIUM

Overall complexity score: MEDIUM

## Removal Decision

`mental_smile_clean_core` dependency can likely be removed in one extraction wave after replacing the proof test.

The `mental_smile_clean_core` folder itself should not be removed in the same wave because the Construction Workbench references it as source repository evidence.

