# Clean Core Extraction Prerequisites

## Status

Draft extraction planning document. Do not extract or move `clean_core` yet.

## Prerequisites

- No unresolved `clean_core` imports to legacy paths.
- Stable `pubspec` package identity.
- Extracted asset strategy.
- Stable localization strategy.
- Firebase options strategy.
- Routing boundary strategy.
- Runtime environment configuration strategy.
- Test and emulator strategy.
- Legal/compliance documentation retained.
- Existing legacy `../lib` changes reviewed separately.

## Deferred Work

- Package extraction.
- Pubspec restructuring.
- Asset movement.
- Firebase project split.
- CI/CD setup.
- Deployment changes.

## Extraction Principle

Extraction should happen only after clean-core dependencies, routing, assets, localization, Firebase options, and test boundaries are explicitly reviewed and documented.
