# clean_core Extraction Wave 1 Stop Conditions

## Mandatory Stop Conditions

Wave 1 must stop immediately if any of the following appear in a candidate batch or extracted package surface:

- Firebase import
- Flutter UI import
- generated file import
- generated localization import
- generated router import
- generated asset/config import
- unexpected app package identity import
- parent-path import escaping the package boundary
- provider SDK import
- networking import
- Cloud Functions coupling
- runtime execution
- provider execution
- AI execution
- orchestration runtime
- dependency injection runtime
- privileged client write
- app shell dependency
- package test requiring app shell
- broad barrel export that exposes internal/app-owned/deferred systems
- weakening of fail-closed posture
- weakening of deny-by-default posture

## Review-Required Conditions

Wave 1 should pause for manual review if:

- a file references audit/legal/human-review systems that are deferred
- a governance file appears to grant runtime authority
- a policy file contains permissive defaults
- a trusted backend or trusted pipeline contract looks executable rather than declarative
- a topology/federation file looks internal-only instead of export-safe
- a future public export would freeze unstable semantics too early

## Blocked Inclusion Conditions

The following must not be included in Wave 1:

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
- Firestore-coupled `ai_safety`, `audit`, `human_review`, and `legal` files

## Stop Response

If a stop condition is detected:

- pause extraction immediately
- do not continue to the next batch
- record the offending file/path
- classify as blocked, adapter-required, app-owned, internal-only, or runtime-deferred
- restore from the latest rollback checkpoint if files were moved
- update the extraction plan before retrying

## Safety Principle

Stopping is the expected safe behavior. Wave 1 should prefer a smaller extracted surface over a contaminated or ambiguous package boundary.
