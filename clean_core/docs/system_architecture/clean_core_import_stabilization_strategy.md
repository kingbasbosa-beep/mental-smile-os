# clean_core Import Stabilization Strategy

This strategy defines how imports should stabilize after package identity is introduced.

## Current Import State

The extracted package currently uses a curated root barrel and package-local `src` paths. Host app reconnect remains minimal and should not be broadened during pubspec activation.

## Import Migration Philosophy

- Migrate only when a file has a clear dependency on an exported contract.
- Prefer public barrel imports from the host app.
- Keep package-internal imports inside `lib/src`.
- Avoid exposing hidden governance/evaluation surfaces.
- Avoid parent-path escaping imports.

## Future Host Import Pattern

Host app code should eventually import stable contracts through:

```dart
import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';
```

This should happen only after local path dependency exists.

## Internal Package Import Rules

- Public consumers use the root barrel only.
- Package-internal files may use relative imports inside `src`.
- Hidden guards, policies, locks, resolvers, and authority-sensitive objects must not become public imports.

## Scoped Migration Sequencing

1. Contract tests first.
2. Host app references to backend boundary contracts.
3. Host app references to safety decision contracts.
4. Policy/governance references only after semantic review.
5. Adapter contract references later.
6. Runtime bridge references deferred.

## Rollback Checkpoints

Create checkpoints after:

- pubspec creation
- path dependency addition
- first import migration
- test reconnect
- any barrel update

## Stop Conditions

Stop import stabilization if migration pulls in Firebase, Flutter UI, generated files, provider SDKs, networking, routing, localization, assets, or runtime startup behavior.
