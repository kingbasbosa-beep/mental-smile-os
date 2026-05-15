# Clean Core Internal-Only Zones

Draft internal-only guidance for future package extraction. No files were moved or hidden.

## Internal-Only Principle

Some clean_core foundations are intentionally early governance scaffolding. They should not be treated as stable public API until their shape is reviewed, versioned, and proven independent from app-owned systems.

## Internal-Only Candidates

- Temporary orchestration placeholders.
- Readiness, sealing, locking, and activation planning markers.
- System topology structures that may change during extraction.
- Integration manifest/freeze internals.
- Runtime activation, enablement, wiring, routing, environment, rollback, observability, isolation, release, bootstrap, and provider onboarding internals until public API needs are confirmed.
- Any model that exists only to document future Cloud Function or backend-governed behavior.

## Internal-Only Rules

- Do not export broad barrels that expose every `lib/core/*` file automatically.
- Prefer curated public API files after review.
- Keep unstable markers internal until their names and semantics settle.
- Do not allow internal placeholders to imply runtime activation.
- Keep all runtime/provider/backend orchestration disabled by default.

## Promotion Criteria

An internal contract can move toward public API only when:

- It has no app-owned imports.
- It has stable naming and version expectations.
- It has clear documentation.
- It does not expose client-side authority over governance, runtime, payment, crisis, moderation, provider, or admin decisions.
- It remains fail-closed by default.

## Explicit Non-Action

No visibility modifiers, exports, files, package structure, or runtime systems were changed.
