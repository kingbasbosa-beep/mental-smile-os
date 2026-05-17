# EX-128 Proposal Classification Worksheet

## Scope

Docs/template only. This reusable worksheet combines EX-126 intake, EX-127
scoring, taxonomy classification, automatic blockers, downgrade notes, and the
required next gate.

This worksheet does not approve implementation. It must not be treated as
permission to create package contracts, barrel exports, mappers, imports,
consumer reconnects, provider behavior, Firebase behavior, or runtime
activation.

## 1. Proposal Summary

- Proposal name:
- Related EX wave:
- Request owner:
- Review date:
- One-paragraph summary:
- Desired outcome:
- Why docs-only is insufficient, if applicable:

## 2. Candidate Type

Select exactly one primary type and list secondary types if needed:

- package contract
- barrel export
- host mapper
- consumer migration
- passive vocabulary
- queue/boundary concept
- runtime/provider diagnostic
- operational/admin surface

Primary type:

Secondary types:

## 3. Exact Scope

List exact files, symbols, and behaviors in scope:

| Item | Type | Intended action | Reason |
| --- | --- | --- | --- |
|  |  |  |  |

## 4. Out-Of-Scope

List excluded areas explicitly:

- Runtime/source logic:
- Package contracts:
- Barrel exports:
- Mappers:
- Imports/consumer reconnects:
- Firebase/provider/adapters:
- Dart tooling:
- Tests:
- Other:

## 5. EX-126 Intake Checklist Result

Summarize completed EX-126 intake:

- Candidate name complete:
- Candidate type complete:
- Intended purpose complete:
- Exact files in scope complete:
- Out-of-scope files complete:
- Semantic risk checklist complete:
- Fake guarantee checklist complete:
- Mapper/persistence checklist complete:
- Export/public API checklist complete:
- Consumer migration checklist complete:
- Rollback plan complete:
- Compatibility plan complete:
- Verification plan complete:
- Stop conditions reviewed:

Intake verdict:

## 6. EX-127 Score Table

Complete `clean_core_ex128_scoring_table_template.md` and summarize:

- Total score:
- Highest dimension score:
- Initial risk band:
- Evidence gaps:

## 7. Automatic Blockers Check

Complete blocker review:

| Blocker Area | Any blocker found? | Evidence | Result |
| --- | --- | --- | --- |
| Semantic blockers |  |  |  |
| Naming blockers |  |  |  |
| Package surface blockers |  |  |  |
| Mapper blockers |  |  |  |
| Consumer migration blockers |  |  |  |
| Runtime/provider blockers |  |  |  |
| Queue/boundary blockers |  |  |  |

Automatic blocker verdict:

## 8. Downgrade Rules Check

Complete downgrade review:

- Any score of 2 or higher:
- Any score of 3:
- Any score of 4:
- Evidence incomplete:
- Scope incomplete:
- Rollback owner missing:
- Compatibility incomplete:
- Verification incomplete:
- Caveats needed but missing:
- Candidate depends on future migration:
- Candidate requires prohibited tooling/runtime activation:

Downgrade result:

## 9. Approval Taxonomy Result

Complete `clean_core_ex128_taxonomy_result_template.md` and select one:

- `BLOCKED`
- `DOCS_ONLY`
- `INTERNAL_ONLY`
- `HOST_ONLY`
- `BACKEND_ONLY`
- `PACKAGE_INTERNAL_UNEXPORTED`
- `EXPORT_ELIGIBLE`
- `MAPPER_ELIGIBLE`
- `MIGRATION_ELIGIBLE`

Taxonomy result:

Rationale:

## 10. Required Next Gate

Complete `clean_core_ex128_next_gate_template.md` and select one:

- docs review
- semantic freeze
- simulation
- execution
- verification
- blocked

Required next gate:

Gate rationale:

## 11. Rollback Summary

- Rollback local:
- Files to remove/revert:
- Exports to remove:
- Mappers to remove:
- Consumers to revert:
- Data/persistence rollback:
- Rollback owner:
- Rollback blocker:

## 12. Compatibility Summary

- Existing public APIs affected:
- Existing host behavior affected:
- Existing consumers affected:
- Existing mapper behavior affected:
- Breaking change risk:
- Compatibility plan:
- Compatibility verdict:

## 13. Public API Decision

- Public API change requested:
- Public export justified:
- Explicit file export only:
- Wildcard/directory export avoided:
- Internal holdback exposed:
- Export gate required:
- Public API decision:

Allowed decisions:

- no public API change
- blocked
- internal-only
- export gate required
- export eligible for later review

## 14. Mapper Decision

- Mapper requested:
- Host mapper only:
- Package mapper requested:
- Firestore/Firebase leakage risk:
- Mapper gate required:
- Mapper decision:

Allowed decisions:

- no mapper
- blocked
- host-only
- mapper gate required
- mapper eligible for later review

## 15. Consumer Migration Decision

- Consumer migration requested:
- Exact consumers named:
- Target export already approved:
- Runtime/provider/Firebase activation risk:
- Migration rollback local:
- Migration gate required:
- Consumer migration decision:

Allowed decisions:

- no migration
- blocked
- migration gate required
- migration eligible for later review

## 16. Final Verdict Format

Use this exact format:

```md
## Final Classification Verdict

Proposal:
Candidate type:
Taxonomy result:
Total score:
Highest score:
Automatic blockers:
Downgrade applied:
Required next gate:

Public API decision:
Mapper decision:
Consumer migration decision:

Rollback verdict:
Compatibility verdict:
Verification verdict:

Approved now:
- Docs/template/rubric only:
- Implementation:
- Export:
- Mapper:
- Consumer migration:
- Runtime/provider/Firebase/adapters:

Blocked items:
Required follow-up:
Final statement:
```

Allowed final statements:

- `Pass for docs/template classification only`
- `Blocked`
- `Needs semantic freeze`
- `Needs simulation`
- `Needs execution gate`
- `Needs verification gate`
- `Needs export gate`
- `Needs mapper gate`
- `Needs migration gate`

## Worksheet Verdict

Pass. This worksheet classifies proposals and identifies the next gate only. It
does not authorize implementation.
