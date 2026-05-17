# EX-127 Approval Taxonomy

## Scope

Docs/rubric only. This taxonomy classifies future proposals after EX-126
intake and EX-127 scoring. A taxonomy result is not implementation approval; it
defines the next allowed review lane.

## Categories

### BLOCKED

Use when the proposal hits an automatic blocker, total score is 17 or higher,
or any dimension is critical without an explicit doctrine reopening.

Allowed action: stop and document the blocker.

Not allowed: contracts, exports, mappers, migrations, provider/Firebase
activation, or runtime work.

### DOCS_ONLY

Use when the proposal can be handled as documentation, doctrine, registry,
verification, template, rubric, or handoff material.

Allowed action: docs/template/rubric/review files only.

Not allowed: source logic, contracts, exports, mappers, migrations, runtime
activation.

### INTERNAL_ONLY

Use when the candidate may be discussed or designed internally to a future
wave, but no package source, export, mapper, or consumer is approved.

Allowed action: design notes and non-runtime review docs.

Not allowed: public API, consumers, mappers, runtime/provider activation.

### HOST_ONLY

Use when the behavior belongs in host app/core code and must not move into
`mental_smile_clean_core`.

Allowed action: future host-scoped review only, if separately approved.

Not allowed by taxonomy alone: package contracts, package exports, package
mappers, consumer migration.

### BACKEND_ONLY

Use when semantics require trusted backend authority, server enforcement,
write ownership, policy adjudication, emergency handling, provider selection,
or runtime orchestration.

Allowed action: backend doctrine/review only, if separately approved.

Not allowed: client/package exposure as proof or authority.

### PACKAGE_INTERNAL_UNEXPORTED

Use when a passive, pure Dart candidate may remain package-internal,
unexported, unconsumed, and rollback-local for future review.

Allowed action in a later implementation wave only: package-internal source
addition with no barrel export and no consumer reconnect, if explicitly
approved.

Not allowed by taxonomy alone: public export, mapper creation, consumer
migration.

### EXPORT_ELIGIBLE

Use when a candidate appears safe enough to enter the export approval gate.

Required properties:

- passive
- pure Dart
- safe name
- no execution implication
- no routing/admission implication
- no backend enforcement implication
- no emergency handling implication
- no provider causality implication
- no retry/fallback recovery implication
- no mapper ownership requirement
- rollback local
- compatibility preserved
- public export justified

Allowed action: future export approval review.

Not allowed by taxonomy alone: editing the barrel.

### MAPPER_ELIGIBLE

Use when a host mapper may be considered after the package/host ownership
question is resolved.

Required properties:

- host-owned only
- no package mapper
- no Firestore/Firebase leakage into package contracts
- no backend proof implication
- no runtime/provider activation
- rollback local
- consumer migration separately approved if needed

Allowed action: future host mapper review.

Not allowed by taxonomy alone: creating mapper files.

### MIGRATION_ELIGIBLE

Use when a consumer migration may be considered after the target package
surface and export are already approved.

Required properties:

- explicit migration approval requested
- exact consumers named
- target export approved
- no runtime/provider/Firebase/adapter activation
- no held-back concepts adopted
- rollback plan complete
- compatibility preserved

Allowed action: future consumer migration review.

Not allowed by taxonomy alone: changing imports or reconnecting consumers.

## Category Ordering

From most restrictive to least restrictive:

1. `BLOCKED`
2. `DOCS_ONLY`
3. `INTERNAL_ONLY`
4. `HOST_ONLY`
5. `BACKEND_ONLY`
6. `PACKAGE_INTERNAL_UNEXPORTED`
7. `EXPORT_ELIGIBLE`
8. `MAPPER_ELIGIBLE`
9. `MIGRATION_ELIGIBLE`

Eligibility categories are not cumulative. For example, `EXPORT_ELIGIBLE` does
not imply `MAPPER_ELIGIBLE` or `MIGRATION_ELIGIBLE`.

## Required Evidence Per Category

- `BLOCKED`: blocker, source doctrine, and stop condition.
- `DOCS_ONLY`: exact docs in scope and no source/tooling actions.
- `INTERNAL_ONLY`: isolation plan and reason public API is not justified.
- `HOST_ONLY`: host ownership rationale and package exclusion.
- `BACKEND_ONLY`: backend authority rationale and client/package exclusion.
- `PACKAGE_INTERNAL_UNEXPORTED`: rollback-local isolation and no consumers.
- `EXPORT_ELIGIBLE`: export justification and public API risk score.
- `MAPPER_ELIGIBLE`: host mapper ownership and persistence containment.
- `MIGRATION_ELIGIBLE`: approved target export, exact consumers, and rollback
  plan.

## Taxonomy Verdict

Pass. The taxonomy defines review lanes only and authorizes no implementation.
