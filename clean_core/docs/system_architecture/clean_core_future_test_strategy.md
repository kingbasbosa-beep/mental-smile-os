# clean_core Future Test Strategy

This document defines future test strategy after controlled package activation. No tests were added in EX-20.

## Test Categories

1. Pure Dart contract tests.
2. Export surface tests.
3. Hidden contract tests.
4. Fail-closed behavior tests.
5. Deny-by-default behavior tests.
6. Adapter contract mock tests later.
7. Semantic stability tests.

## Initial Test Posture

The first package test set should require:

- Dart SDK only
- no Flutter UI
- no Firebase
- no emulator
- no generated localization
- no platform setup
- no provider SDKs
- no networking

## Export Surface Tests

Future tests should verify:

- root barrel exposes only approved files
- hidden guards/policies/locks/resolvers stay hidden
- no wildcard exports are introduced
- no runtime execution surface appears

## Fail-Closed Tests

Future tests should confirm:

- default states are inactive/blocked where applicable
- missing authority remains blocked
- fallback behavior is safe
- review/audit markers remain declarative

## Adapter Contract Tests Later

Adapter tests should use mocks only and must not call:

- Firebase
- network clients
- provider SDKs
- platform file/print/share APIs

## Host-Owned Tests

The host app should retain:

- Flutter widget tests
- Firebase/emulator tests
- routing tests
- localization tests
- print/PDF/share/download integration tests
- provider bridge tests later

## Test Strategy Verdict

Package tests should prove contract stability, not runtime functionality.
