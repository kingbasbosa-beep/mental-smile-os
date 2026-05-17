# EX-128 Next Gate Template

## Scope

Docs/template only. Use this template to select the required next gate after
classification. The next gate is a review lane, not automatic implementation
approval.

## Gate Options

Select exactly one:

- docs review
- semantic freeze
- simulation
- execution
- verification
- blocked

Selected next gate:

## Gate Meanings

### docs review

Use when the next safe action is documentation, doctrine, registry, checklist,
template, rubric, or handoff work only.

Allowed next action: docs/review only.

### semantic freeze

Use when naming, authority, fake guarantee, or blocked-concept risk must be
resolved before any implementation discussion.

Allowed next action: doctrine and semantic review only.

### simulation

Use when the proposal needs non-runtime modeling, examples, dry-run mapping,
or impact analysis without source changes, exports, mappers, migrations,
provider setup, Firebase setup, or runtime activation.

Allowed next action: docs/simulation only.

### execution

Use only when a later wave has explicitly approved implementation scope.

Allowed next action: exactly the approved implementation scope. This gate is
not available from EX-128 by itself.

### verification

Use when a later approved change needs static verification, export review,
mapper containment review, or migration verification.

Allowed next action: verification only, with explicitly approved tooling.

### blocked

Use when automatic blockers, downgrade rules, missing evidence, non-local
rollback, compatibility gaps, or prohibited activation prevent progress.

Allowed next action: stop and document the blocker.

## Gate Selection Rules

- If any automatic blocker is present, select `blocked`.
- If naming or fake guarantee risk is unresolved, select `semantic freeze`.
- If proposal is docs/template/rubric only, select `docs review`.
- If source behavior must be modeled but not changed, select `simulation`.
- If implementation is requested but not explicitly approved, select
  `blocked` or `semantic freeze`.
- If implementation was already approved by a separate wave, select
  `execution`.
- If only validation of an approved change remains, select `verification`.

## Required Evidence

- Taxonomy result:
- Blockers:
- Downgrade notes:
- Rollback verdict:
- Compatibility verdict:
- Public API decision:
- Mapper decision:
- Consumer migration decision:
- Why this gate is the safest next step:

## Next Gate Verdict

Next gate verdict:

- `Pass`
- `Blocked`
- `Needs semantic freeze`
- `Needs docs review`
- `Needs simulation`
- `Needs execution approval`
- `Needs verification approval`
