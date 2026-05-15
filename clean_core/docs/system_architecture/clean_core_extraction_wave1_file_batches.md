# clean_core Extraction Wave 1 File Batches

## Batch 1: Backend Boundaries and Safety Decision

Included paths:

- `lib/core/backend_boundaries/`
- `lib/core/safety_decision/`

Why safe:

- Expected to be pure contract/model/governance logic.
- No runtime provider execution is expected.
- No host app ownership is expected.

Required import checks:

- No `package:flutter/` imports.
- No `cloud_firestore`, `firebase_*`, or `firebase_options` imports.
- No generated localization, generated router, or generated asset imports.
- No parent-path imports escaping clean_core.

Possible dependency risks:

- Hidden app-package imports from early app integration work.
- Overly broad future barrel export accidentally exposing non-contract internals.

Rollback checkpoint:

- Capture file list and import diff before moving.
- Move as a single reversible batch.
- Keep host app references unchanged until reconnect plan is approved.

Validation expectations:

- Package tree contains only selected contract files.
- Export surface remains curated.
- No runtime/provider activation symbols are introduced.

## Batch 2: Policy Runtime

Included path:

- `lib/core/policy_runtime/`

Why safe:

- Policy runtime foundations are intended as deterministic governance contracts, not live runtime execution.
- Expected to preserve deny-by-default and fail-closed posture.

Required import checks:

- No Firebase, Flutter UI, networking, provider SDK, or Cloud Functions imports.
- No app shell, routing, localization, asset, or generated config coupling.
- No runtime activation implementation.

Possible dependency risks:

- Naming may imply runtime behavior, so exported API must clearly remain contract-only.
- Policy rule surfaces may need semantic review before being public API.

Rollback checkpoint:

- Verify policy files can be removed from extracted location without affecting app-owned runtime.
- Keep original source untouched until a real move plan is approved.

Validation expectations:

- Policy exports are curated.
- Defaults remain blocked/deny-first.
- No hidden activation or permissive fallback appears.

## Batch 3: Trusted Backend and Trusted Pipeline

Included paths:

- `lib/core/trusted_backend/`
- `lib/core/trusted_pipeline/`

Why safe:

- These are placeholder/contract foundations for future backend-governed operation.
- They intentionally contain no networking, backend runtime, provider execution, or orchestration.

Required import checks:

- No HTTP, Firebase Functions, provider SDK, or live backend bridge imports.
- No auth runtime imports.
- No app-owned generated files.

Possible dependency risks:

- Future readers may confuse boundary contracts with implemented backend integration.
- Guard/policy names must remain visibly fail-closed and placeholder-only.

Rollback checkpoint:

- Confirm no host runtime depends on extracted path before moving.
- Keep batch review separate from policy runtime review.

Validation expectations:

- Trusted backend/pipeline exports remain interfaces, enums, markers, and blocked results only.
- No network clients or orchestration objects are added.

## Batch 4: Core Governance Foundation

Included paths:

- `lib/core/governance_kernel/`
- `lib/core/governance_lifecycle/`
- `lib/core/governance_compliance/`

Why safe:

- These areas are expected to define governance contracts and lifecycle/compliance placeholders.
- They are strong extraction candidates if import scans confirm pure Dart boundaries.

Required import checks:

- No Firestore, Firebase, Flutter UI, generated files, app package identity, or platform imports.
- No privileged client-write assumptions.
- No runtime orchestration hooks.

Possible dependency risks:

- Governance terms may overlap with app-owned admin workflows.
- Compliance contracts may reference legal/audit areas that are deferred.

Rollback checkpoint:

- Move only after Batch 1 through Batch 3 reviews pass.
- Record dependency references to deferred audit/legal systems before movement.

Validation expectations:

- Governance contracts remain app-shell independent.
- Deferred legal/audit dependencies are references only, not runtime imports.

## Batch 5: Governance Capability and Federation

Included paths:

- `lib/core/governance_capability/`
- `lib/core/governance_federation/`

Why safe:

- These directories define capability/federation contracts for future governance coordination.
- They should remain contract-only and backend-governed.

Required import checks:

- No orchestration runtime imports.
- No Firebase, Flutter UI, provider SDK, networking, generated, or app-shell imports.
- No activation path into provider/runtime systems.

Possible dependency risks:

- Federation concepts may be internal-only rather than public export-safe.
- Capability contracts may need semantic review before inclusion in public barrels.

Rollback checkpoint:

- Treat this as the last Wave 1 batch.
- Move only after public/internal decision is reviewed.

Validation expectations:

- Federation remains non-executing.
- Capability references remain governance markers, not permissions to activate runtime.
