# clean_core Wave 1 Simulated Import Rewrite Plan

## Rule

This document simulates future import rewrite expectations. It does not rewrite imports.

## Package Imports

Future host-app imports should eventually target curated package barrels, such as:

- `package:mental_smile_clean_core/mental_smile_clean_core.dart`
- focused barrels if approved later

Package imports should be used for host app consumption only after the extracted package exists and the dual-link transition is approved.

## Relative src Imports

Inside the future extracted package:

- sibling files within the same contract group may use relative imports
- cross-group imports should be deliberate and reviewed
- internal-only imports should remain under `src/`
- public barrels should not expose implementation-only helper files

## Internal Hidden Imports

Internal hidden imports should apply to:

- lock/seal implementation details
- unstable federation internals
- capability internals not ready for public API
- runtime-deferred placeholders
- adapter-only implementation placeholders

These should not appear in the root public barrel.

## Unchanged Host-App Imports

During a temporary dual-link phase, host app imports may remain unchanged until each reference is intentionally migrated. This avoids broad automated rewrites and preserves rollback.

Unchanged host-app areas include:

- Firebase initialization
- auth/session runtime
- routing/navigation
- localization generation
- Flutter UI
- assets/platform setup
- app-coupled tests

## Blocked or Review-Required Imports

Future rewrite must block or pause on:

- `package:flutter/`
- `cloud_firestore`
- `firebase_*`
- `firebase_options`
- generated localization/config/router/assets
- provider SDK imports
- networking imports
- Cloud Functions imports
- app-owned package imports
- parent-path imports escaping the package

## Rewrite Method

Future rewrite should be manual and staged:

- no broad automated rewrite
- no repo-wide formatting
- no wildcard barrel exports
- no app-owned imports into the package
- no Firebase/generated/UI imports into the package

## Simulation Finding

The safest rewrite path is package-local imports inside the extracted package, curated package imports in the host app, and no migration of app-owned runtime imports.
