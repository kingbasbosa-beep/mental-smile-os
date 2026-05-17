# EX-85 EscalationReview Authority Detox

## Authority-Sensitive Fields

- `reviewerId`
- `state`
- `sanitizedReviewNote`
- `auditLink`

## Required Caveats

- `reviewerId` is metadata only and does not prove reviewer authorization or moderation authority.
- `state` is passive and does not progress workflow.
- `sanitizedReviewNote` is not a privacy or security boundary.
- `auditLink` remains metadata only and does not prove audit persistence, integrity, or policy approval.
- `reviewedAt` is timestamp metadata only and does not prove backend execution or review finality.
- The review record does not approve, moderate, execute, resolve, or own escalation workflow.

## Prohibited Meanings

Package `EscalationReview` must not imply:

- review authority
- moderation authority
- approval finality
- reviewer authorization
- backend ownership
- case resolution

## Verdict

Authority detox is viable with explicit caveats.
