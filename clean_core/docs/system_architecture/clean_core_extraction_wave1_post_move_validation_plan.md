# clean_core Extraction Wave 1 Post-Move Validation Plan

## Purpose

This document defines validation expectations for the future real Wave 1 move. No validation commands are run as part of this planning phase.

## File Tree Validation

After the future move, verify:

- the extracted package contains only Wave 1 approved paths
- blocked app-owned paths are absent
- deferred Firestore-coupled domains are absent
- generated files are absent
- assets are absent
- app-coupled tests are absent
- package folders match the approved skeleton strategy

## Import Path Validation

Verify imports remain:

- package-boundary safe
- parent-path free
- app-package identity free unless deliberately handled during dual-link transition
- Firebase-free
- Flutter UI-free
- generated-file-free
- provider SDK-free
- networking-free
- Cloud Functions-free

## Export Surface Validation

Verify public barrels are:

- curated
- grouped by stable contract area
- free of wildcard export-all behavior
- free of internal-only files
- free of app-owned files
- free of runtime-deferred files
- explicit about review-required surfaces

## Pubspec Dependency Validation

The future extracted package pubspec should avoid:

- Flutter SDK dependency for Wave 1
- Firebase packages
- provider SDK packages
- networking packages
- generated localization/config dependencies
- platform-specific setup dependencies
- app-shell dependencies

## Runtime and Provider Validation

Confirm the extracted package does not contain:

- runtime activation
- provider execution
- AI execution
- orchestration runtime
- backend runtime
- networking clients
- Firebase initialization
- Cloud Functions runtime
- deployment/release activation

## Host Ownership Validation

Confirm the host app still owns:

- Firebase initialization/runtime
- auth/session runtime
- routing/navigation
- localization generation
- assets/platform setup
- provider SDK runtime
- telemetry/analytics runtime
- deployment/release runtime
- app-coupled integration tests

## Rollback Validation

Confirm:

- rollback checkpoint exists before each batch
- moved file inventory exists
- import changes are isolated and reversible
- host app can return to pre-move references
- extraction does not require runtime activation to recover
- fail-closed and deny-by-default behavior remain intact

## Final Wave 1 Acceptance Criteria

Wave 1 should be accepted only when:

- all batches pass their checkpoints
- no stop condition is present
- extracted surface is pure Dart and contract-only
- public exports are curated
- app-owned systems remain excluded
- runtime/provider execution remains blocked
- backend authority expectations remain preserved
