# EX-81 Human Review Authority Semantics Review

## Authority-Sensitive Fields

`EscalationAssignment`:

- `assignedTo`
- `assignedBy`
- `state`

`EscalationResolution`:

- `resolvedBy`
- `state`
- `outcomeKey`
- `sanitizedResolutionNote`
- `auditLink`

`EscalationReview`:

- `reviewerId`
- `state`
- `sanitizedReviewNote`
- `auditLink`

## Authority Findings

- Assignment fields can imply reviewer assignment authority.
- Resolution fields can imply outcome approval, case closure, or backend resolution authority.
- Review fields can imply reviewer authority and human approval semantics.
- `EscalationState` labels must remain metadata only and cannot imply workflow progression.
- `EscalationAuditLink` remains metadata only and cannot prove audit persistence, trace integrity, or policy approval.

## Required Caveats

Future package models must state that identity fields, outcome fields, notes, audit links, and states are passive record metadata only and do not grant approval, assignment, resolution, review, or backend authority.
