# EX-128 Scoring Table Template

## Scope

Docs/template only. Use this table to apply the EX-127 0-4 scoring rubric to a
completed EX-126 intake.

## Score Scale

| Score | Meaning |
| --- | --- |
| 0 | No meaningful risk; evidence is clear |
| 1 | Low risk; caveats or documentation needed |
| 2 | Medium risk; needs narrowed scope or additional gate |
| 3 | High risk; likely requires doctrine review |
| 4 | Critical risk or automatic blocker |

Scores classify eligibility only and do not authorize implementation.

## Score Table

| Dimension | Score | Evidence | Mitigation/Caveat | Downgrade Needed |
| --- | --- | --- | --- | --- |
| Semantic risk |  |  |  |  |
| Authority/fake guarantee risk |  |  |  |  |
| Runtime/provider proximity |  |  |  |  |
| Queue/boundary proximity |  |  |  |  |
| Firebase/persistence proximity |  |  |  |  |
| Public API risk |  |  |  |  |
| Consumer migration risk |  |  |  |  |
| Rollback locality |  |  |  |  |
| Compatibility preservation |  |  |  |  |
| Test/verification readiness |  |  |  |  |

## Total Score

- Total score:
- Highest dimension score:
- Any score of 4:
- Any score of 3:
- Any score of 2 or higher:
- Initial risk band:

## Risk Bands

| Total Score | Initial Classification |
| --- | --- |
| 0-4 | Low risk |
| 5-9 | Moderate risk |
| 10-16 | High risk |
| 17+ | Blocked by risk profile |

Automatic blockers override total score.

## Evidence Requirements

Each score must cite:

- EX-126 intake section:
- exact candidate name:
- exact file scope:
- risk rationale:
- caveat or mitigation:
- rollback evidence:
- compatibility evidence:
- verification evidence:

## Scoring Verdict

Scoring verdict:

- `Pass`
- `Blocked`
- `Needs more evidence`
- `Needs downgrade`
- `Needs doctrine review`
