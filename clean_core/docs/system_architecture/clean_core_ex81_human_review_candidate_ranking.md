# EX-81 Human Review Candidate Ranking

## Safest First Candidate

1. `EscalationAssignment`

Rationale:

- smallest field set
- depends only on `EscalationState`
- no nested audit-link dependency
- no outcome or review-note semantics
- authority risk is assignment-oriented but lower than resolution/review

## Second Candidate

2. `EscalationReview`

Rationale:

- moderate field count
- nested audit-link dependency
- reviewer and note semantics require caveats
- less finality than resolution

## Third Candidate

3. `EscalationResolution`

Rationale:

- strongest approval/outcome/finality semantics
- `resolvedBy` and `outcomeKey` can imply authority
- highest need for semantic freeze before split

## Recommended EX-82 Phase

EX-82 should be `EscalationAssignment` semantic freeze, not execution. Freeze package fields, prohibited meanings, mapper boundaries, compatibility strategy, rollback scope, and stop conditions.
