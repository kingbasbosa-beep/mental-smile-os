# EX-92 EscalationRequest Authority Detox

## Authority Risks

`EscalationRequest` can sound like an initiating authority record. The freeze detoxes this interpretation.

## Detox Rules

- `uid` does not prove request authorization.
- `level` does not grant escalation authority.
- `reason` does not prove causality or provider failure.
- `state` does not prove backend transition.
- `priority` does not schedule or order review.
- `visibilityScope` does not authorize disclosure or access.
- `auditLink` does not prove audit persistence or integrity.
- `policyReference` does not enforce or approve policy.
- `createdAt` does not prove backend ingestion.

## Excluded Authority Semantics

The package-safe request model must not include:

- initiation authority
- moderation authority
- routing guarantees
- escalation execution
- backend guarantees
- queue guarantees
- provider/runtime causality
- orchestration ownership
- emergency response guarantee
- client outcome write policy

## Authority Verdict

Authority remains host/backend-owned. The package model may only describe request metadata.
