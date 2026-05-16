# clean_core Package Identity Strategy

## Current Status

`mental_smile_clean_core` is currently an extracted package shell only. It has no standalone `pubspec.yaml`, no package registration, no publishing target, and no host dependency wiring.

## Recommended Future Package Name

Recommended package identity:

- `mental_smile_clean_core`

Reason:

- explicit product ownership
- clear separation from the host Flutter app
- reinforces a clean, contract-only kernel rather than a feature module
- avoids implying runtime execution or provider integration

## Namespace Strategy

Future public import:

```dart
import 'package:mental_smile_clean_core/mental_smile_clean_core.dart';
```

Internal implementation namespace:

```text
lib/src/
```

Public exports should remain curated through:

```text
lib/mental_smile_clean_core.dart
```

## Public vs Internal Philosophy

Public:

- stable contract models
- enums
- state markers
- references
- audit/review links
- declarative fallback/block contracts

Internal:

- guards
- policies
- resolvers
- locks
- boundary evaluators
- check APIs
- authority-like main objects

## Non-Runtime Identity

The package is not:

- a runtime engine
- an orchestration runtime
- a provider execution layer
- a backend implementation
- a Firebase integration
- a UI framework
- a routing layer
- a generated-file owner

## Final Identity Principle

`mental_smile_clean_core` should be a governed, declarative, fail-closed contract kernel. Runtime authority remains outside the package.
