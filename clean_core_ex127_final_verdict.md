# EX-127 Final Verdict

## Scope

EX-127 was completed as docs/rubric only. It did not modify runtime/source
logic, create package contracts, create mappers, change imports/exports,
reconnect consumers, migrate imports, run `pub get`, run `analyze`, or activate
runtime/provider/Firebase/adapters.

## Docs Created

- `clean_core_ex127_candidate_scoring_rubric.md`
- `clean_core_ex127_approval_taxonomy.md`
- `clean_core_ex127_automatic_blockers.md`
- `clean_core_ex127_downgrade_rules.md`
- `clean_core_ex127_examples_from_prior_waves.md`
- `clean_core_ex127_final_verdict.md`

## Scoring Rubric

EX-127 defines a 0-4 score scale across:

- semantic risk
- authority/fake guarantee risk
- runtime/provider proximity
- queue/boundary proximity
- Firebase/persistence proximity
- public API risk
- consumer migration risk
- rollback locality
- compatibility preservation
- test/verification readiness

Scores classify eligibility only. They do not authorize implementation.

## Approval Taxonomy

EX-127 defines these taxonomy categories:

- `BLOCKED`
- `DOCS_ONLY`
- `INTERNAL_ONLY`
- `HOST_ONLY`
- `BACKEND_ONLY`
- `PACKAGE_INTERNAL_UNEXPORTED`
- `EXPORT_ELIGIBLE`
- `MAPPER_ELIGIBLE`
- `MIGRATION_ELIGIBLE`

Eligibility categories require later explicit approval gates before any
implementation, export, mapper, or migration.

## Automatic Blockers

Automatic blockers override scoring. Blockers include fake authority,
execution, routing/admission, backend enforcement, emergency handling,
provider causality, fallback recovery, package Firebase behavior, package
mappers, wildcard/directory exports, unapproved holdback exposure, unapproved
consumer reconnect, runtime/provider diagnostics, and queue/boundary exposure.

## Examples

Examples from prior waves classify:

- audit contracts as potentially `EXPORT_ELIGIBLE` when passive and mapper-free
- human-review contracts as export-eligible only after caveat and export review
- `PassiveReviewSignal` as narrow public passive vocabulary with caveats
- internal passive vocabulary files as `PACKAGE_INTERNAL_UNEXPORTED`
- queue/boundary and runtime/provider holdbacks as `BLOCKED`
- Firestore mappers as `HOST_ONLY` or future `MAPPER_ELIGIBLE`
- EX-124 through EX-126 governance work as `DOCS_ONLY`

## Final EX-127 Verdict

Pass. EX-127 establishes the candidate scoring rubric, approval taxonomy,
automatic blockers, downgrade rules, and examples. It authorizes no
implementation, export, mapper, migration, or runtime/provider activation.

## Recommended EX-128 Direction

EX-128 should remain documentation/review first. Recommended direction: create
a proposal classification worksheet that combines the EX-126 intake template
with EX-127 scoring, taxonomy result, blockers, downgrade notes, and required
next gate.
