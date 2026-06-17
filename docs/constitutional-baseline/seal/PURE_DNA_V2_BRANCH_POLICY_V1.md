# PURE_DNA_V2_BRANCH_POLICY_V1

Status: ACTIVE_BRANCH_POLICY
Phase: 9
Operation: OP-PHASE-9-PURE-DNA-V2-SEAL-V1
Runtime effect: none
Git effect: none
Firebase effect: none

## Branch Roles

| Branch | Role | Policy |
| --- | --- | --- |
| `main` | Presentation/display branch | Must not be directly overwritten by baseline work |
| `post-separation-pure-dna-v1` | Constitutional baseline branch | Target branch for Pure DNA baseline after Owner approval |

## Hard Rules

- No force push.
- No direct `main` overwrite.
- No accidental deployment.
- No push before Owner approval.
- No tag before Owner approval.
- No commit before Owner approval.
- No Firebase deploy from seal work.
- No Firebase mutation from seal work.

## Official Identity

| Item | Value |
| --- | --- |
| Official GitHub repository | `kingbasbosa-beep/mental-smile-os` |
| Official Firebase project | `mental-smile-platform` |
| Local Pure DNA workspace | `C:\mental_smile_workspace\app\mental-smile-platform` |

## Historical Identity

Old identities and old repositories are historical/IP archive evidence.

They are not the active development line and must not receive future active development commits unless Owner explicitly approves a lineage change.

## Constitutionalization Gate

Before connecting or pushing:

- Owner confirms remote URL.
- Owner confirms branch target.
- Owner confirms first commit message.
- Owner confirms tag policy.
- Owner confirms visibility and branch protection decisions.
- Secret/build artifact staging check passes.

