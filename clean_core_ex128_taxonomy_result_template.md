# EX-128 Taxonomy Result Template

## Scope

Docs/template only. Use this template to record the EX-127 approval taxonomy
classification after scoring, blocker review, and downgrade review.

## Taxonomy Selection

Select exactly one:

- `BLOCKED`
- `DOCS_ONLY`
- `INTERNAL_ONLY`
- `HOST_ONLY`
- `BACKEND_ONLY`
- `PACKAGE_INTERNAL_UNEXPORTED`
- `EXPORT_ELIGIBLE`
- `MAPPER_ELIGIBLE`
- `MIGRATION_ELIGIBLE`

Selected taxonomy:

## Classification Evidence

- Total score:
- Highest score:
- Automatic blockers found:
- Downgrade applied:
- Candidate type:
- Exact scope:
- Rollback local:
- Compatibility preserved:
- Public API justified:
- Mapper ownership:
- Consumer migration approval:

## Category Evidence

Complete the row for the selected category.

| Category | Required Evidence | Candidate Evidence |
| --- | --- | --- |
| `BLOCKED` | blocker, source doctrine, stop condition |  |
| `DOCS_ONLY` | exact docs in scope, no source/tooling actions |  |
| `INTERNAL_ONLY` | isolation plan, no public API justification |  |
| `HOST_ONLY` | host ownership rationale, package exclusion |  |
| `BACKEND_ONLY` | backend authority rationale, client/package exclusion |  |
| `PACKAGE_INTERNAL_UNEXPORTED` | rollback-local isolation, no consumers |  |
| `EXPORT_ELIGIBLE` | export justification, low public API risk |  |
| `MAPPER_ELIGIBLE` | host mapper ownership, persistence containment |  |
| `MIGRATION_ELIGIBLE` | approved target export, exact consumers, rollback plan |  |

## Not Approved By Taxonomy

Mark all that remain not approved:

- implementation:
- barrel export:
- mapper creation:
- consumer migration:
- runtime/provider/Firebase/adapters:
- package contract:
- package mapper:

## Taxonomy Verdict

Taxonomy verdict:

- `Pass`
- `Blocked`
- `Needs downgrade`
- `Needs blocker review`
- `Needs additional evidence`
