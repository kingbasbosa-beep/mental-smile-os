# EX-127 Downgrade Rules

## Scope

Docs/rubric only. Downgrade rules reduce a candidate's approval taxonomy when
risk is present but not automatically blocking.

## General Downgrade Rule

If any dimension scores 2 or higher, the candidate must be downgraded at least
one category from the initially requested category.

If any dimension scores 3, the candidate must be downgraded to `DOCS_ONLY`,
`INTERNAL_ONLY`, `HOST_ONLY`, `BACKEND_ONLY`, or `BLOCKED`.

If any dimension scores 4, the candidate is `BLOCKED`.

## Category Downgrades

### From MIGRATION_ELIGIBLE

Downgrade to `EXPORT_ELIGIBLE` if export approval is incomplete.

Downgrade to `HOST_ONLY` if migration depends on host mapper ownership.

Downgrade to `BLOCKED` if migration activates runtime/provider/Firebase or
uses unapproved internals.

### From MAPPER_ELIGIBLE

Downgrade to `HOST_ONLY` if mapper ownership is not fully specified.

Downgrade to `DOCS_ONLY` if the mapped contract is not approved.

Downgrade to `BLOCKED` if mapper would live in package surface or expose
Firestore/Firebase through the package.

### From EXPORT_ELIGIBLE

Downgrade to `PACKAGE_INTERNAL_UNEXPORTED` if public API justification is weak.

Downgrade to `INTERNAL_ONLY` if naming needs caveats or rename.

Downgrade to `BLOCKED` if export would expose holdback concepts, wildcard
exports, directory exports, mappers, or Firebase behavior.

### From PACKAGE_INTERNAL_UNEXPORTED

Downgrade to `INTERNAL_ONLY` if rollback is not single-scope local.

Downgrade to `DOCS_ONLY` if source addition is not required.

Downgrade to `BLOCKED` if consumers are needed for the candidate to be useful.

### From BACKEND_ONLY

Downgrade to `DOCS_ONLY` if backend ownership is only conceptual.

Downgrade to `BLOCKED` if client/package exposure is required for authority.

### From HOST_ONLY

Downgrade to `DOCS_ONLY` if no host implementation is needed.

Downgrade to `BACKEND_ONLY` if trusted enforcement or write authority is
required.

Downgrade to `BLOCKED` if host implementation would imply package authority.

### From INTERNAL_ONLY

Downgrade to `DOCS_ONLY` if the candidate is not ready for source design.

Downgrade to `BLOCKED` if the internal design still implies a fake guarantee.

## Evidence Downgrades

Downgrade one category when:

- evidence is incomplete
- exact files in scope are missing
- out-of-scope files are not named
- rollback owner is missing
- compatibility plan is incomplete
- verification commands are unspecified
- caveats are needed but not drafted

Downgrade to `BLOCKED` when:

- evidence contradicts the requested category
- a stop condition is found
- the candidate depends on a future migration to be meaningful
- the candidate requires tooling/runtime activation prohibited by the wave

## Downgrade Verdict

Pass. Downgrade rules ensure eligibility is conservative and does not imply
implementation approval.
