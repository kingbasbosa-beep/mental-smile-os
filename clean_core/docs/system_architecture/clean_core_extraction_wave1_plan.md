# clean_core Extraction Wave 1 Plan

## Status

This document defines the first real extraction wave before execution. No files are moved, no package skeleton is created, no imports are rewritten, and no runtime behavior is activated by this plan.

## Wave 1 Objective

Wave 1 should extract only the safest pure-Dart contract groups that already align with the clean_core extraction strategy:

- backend-boundary contracts
- safety decision contracts
- policy runtime contracts
- trusted backend contracts
- trusted pipeline contracts
- selected governance contracts after review

The goal is to establish a small, rollback-safe first package movement with no Firebase, Flutter UI, generated-file, networking, provider SDK, Cloud Functions, or runtime-execution dependency.

## Wave 1 Candidate Scope

Primary candidates:

- `lib/core/backend_boundaries/`
- `lib/core/safety_decision/`
- `lib/core/policy_runtime/`
- `lib/core/trusted_backend/`
- `lib/core/trusted_pipeline/`

Secondary candidates after review:

- `lib/core/governance_kernel/`
- `lib/core/governance_lifecycle/`
- `lib/core/governance_compliance/`
- `lib/core/governance_capability/`
- `lib/core/governance_federation/`

## Deferred Scope

These areas should not enter Wave 1:

- `lib/core/ai_safety/`
- `lib/core/audit/`
- `lib/core/human_review/`
- `lib/core/legal/`

Reason: prior extraction scans identified Firestore-coupled files in these domains. They require file-by-file cleanup, adapter abstraction, or semantic review before extraction.

## Blocked Scope

These paths remain host-app owned or blocked from Wave 1:

- `lib/main.dart`
- `lib/firebase_options.dart`
- `lib/app/**`
- `lib/l10n/**`
- `lib/features/**`
- `lib/shared/ui_kit/**`
- `lib/core/auth/**`
- `lib/core/storage/**`
- `assets/**`
- current app-coupled tests

## Required Wave 1 Properties

Every Wave 1 file must remain:

- pure Dart
- contract-first
- runtime-disabled
- provider-blocked
- Firebase-free
- Flutter UI-free
- generated-file-free
- networking-free
- Cloud Functions-free
- fail-closed by default
- deny-by-default by default

## Execution Rule

Wave 1 must be executed as staged movement later, not as a single broad copy. Each batch requires a review checkpoint before the next batch starts.
