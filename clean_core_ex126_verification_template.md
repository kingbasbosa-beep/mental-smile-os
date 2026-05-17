# EX-126 Verification Template

## Scope

Docs/template only. This verification template must be completed before a
future proposal can move from intake to implementation review.

## Verification Boundaries

State what will and will not be run:

- `pub get`:
- `analyze`:
- tests:
- Firebase/provider setup:
- runtime/adapters:
- static docs inspection:
- static source inspection:

## Static Verification Plan

| Verification Area | Command Or Method | Expected Result |
| --- | --- | --- |
| Barrel export check |  | Explicit exports only |
| Wildcard export check |  | None |
| Directory export check |  | None |
| Internal holdback check |  | Not exported |
| Mapper containment check |  | Host-side only |
| Firestore/Firebase package check |  | No package leakage |
| Consumer reconnect check |  | None unless approved |
| Runtime/provider exposure check |  | None unless doctrine reopened |
| Queue/boundary exposure check |  | None unless doctrine reopened |
| AI/safety fake guarantee check |  | No authority implication |
| Rollback-local check |  | Local rollback path exists |
| Compatibility check |  | No unplanned breakage |

## Required Evidence

- Files inspected:
- Commands used:
- Docs referenced:
- Candidate files verified:
- Out-of-scope files untouched:
- Existing untracked files noted:

## Verification Stop Conditions

Stop if verification finds:

- wildcard or directory export
- unapproved barrel export
- package mapper
- Firestore/Firebase dependency inside package contracts
- unapproved consumer import migration
- runtime/provider diagnostic exposure
- queue/boundary exposure
- fake guarantee naming
- rollback not local
- compatibility break without plan

## Required Final Verification Statement

Use this format:

```md
## Verification Statement

Candidate:
Verification scope:
Commands used:
Files inspected:
Files changed:
Out-of-scope files untouched:
Tooling intentionally not run:
Findings:
Stop conditions encountered:
Verification verdict:
```

Allowed verification verdicts:

- `Pass`
- `Blocked`
- `Needs doctrine review`
- `Needs additional static inspection`
- `Needs explicit tooling approval`
