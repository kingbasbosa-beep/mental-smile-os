# clean_core Local Path Dependency Strategy

This document defines a future local path dependency approach for connecting the host app to `mental_smile_clean_core`. It is planning only.

## Future Path Dependency Shape

The host app may later add a local path dependency similar to:

```yaml
dependencies:
  mental_smile_clean_core:
    path: mental_smile_clean_core
```

This must not be added until the package has its own approved pubspec and rollback checkpoint.

## Introduction Rules

- Add the path dependency in a dedicated checkpoint.
- Do not combine path dependency introduction with broad import migration.
- Do not add runtime dependencies to the extracted package.
- Do not reconnect Firebase, UI, routing, or provider systems through the package dependency.

## Temporary Host Integration Strategy

1. Create minimal package pubspec in a future approved phase.
2. Add host path dependency in a separate future phase.
3. Migrate one host test/import group at a time.
4. Keep host app runtime paths unchanged.
5. Preserve rollback to pre-path-dependency state.

## Rollback-Safe Introduction

Rollback must be able to:

- remove the path dependency
- restore direct local test imports if needed
- leave runtime disabled
- leave provider execution blocked
- preserve host app Firebase/UI/routing ownership

## Blocked Reconnects

The first path dependency must not introduce:

- Firebase bridge wiring
- provider bridge wiring
- runtime startup
- analytics/telemetry pipelines
- routing ownership
- generated localization ownership
- PDF/print/share/download ownership

## Verdict

Local path dependency is suitable only after minimal package identity is approved. It should be introduced before any broad host import migration, but after rollback planning is refreshed.
