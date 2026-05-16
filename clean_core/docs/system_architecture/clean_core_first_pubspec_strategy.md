# clean_core First Pubspec Strategy

EX-20 defines the first pubspec philosophy for the extracted `mental_smile_clean_core` package shell. No `pubspec.yaml` was created, no dependencies were added, no imports were changed, and no runtime systems were activated.

## Current State

- Package shell exists at `mental_smile_clean_core/`.
- Public barrel exists at `mental_smile_clean_core/lib/mental_smile_clean_core.dart`.
- No standalone `pubspec.yaml` exists.
- Current surface is pure Dart, declarative-only, non-executing, fail-closed, and deny-by-default.

## Minimal Initial Pubspec Shape

The first future pubspec should be intentionally small:

```yaml
name: mental_smile_clean_core
description: Pure Dart governance and boundary contracts for Mental Smile.
publish_to: none
version: 0.1.0

environment:
  sdk: ">=3.3.0 <4.0.0"
```

This is a blueprint only. It must not be created until package activation is explicitly approved.

## Dependency Posture

Initial package dependencies should be empty unless a pure Dart test/lint dependency is explicitly approved later.

Allowed dependency categories:

- Dart SDK only
- pure Dart testing dependencies later
- pure Dart linting/dev tooling later

Blocked dependency categories:

- Firebase
- Flutter UI
- provider SDKs
- networking clients
- analytics runtimes
- telemetry runtimes
- platform runtimes
- file/printing/share runtimes

## Metadata Strategy

- Use private/internal posture first.
- Use `publish_to: none` until governance approves publication.
- Avoid repository/homepage metadata until package ownership is finalized.
- Keep description contract-focused, not runtime-focused.

## Lint/Test Posture

- First pubspec may defer dev dependencies until test structure is approved.
- Future linting should be package-local and not force host-app lint cleanup.
- Future tests should be pure Dart contract tests only.

## Stop Conditions

Stop pubspec creation if it introduces Flutter, Firebase, networking, provider SDKs, runtime clients, or platform file/print/share dependencies.
