# EX-78 Human Review Audit Detox

## Audit Fields

`EscalationAuditLink` contains:

- `auditId`
- `traceHash`
- `policyVersion`

## Required Audit Caveats

- `auditId` does not prove audit persistence.
- `auditId` does not prove backend audit creation.
- `traceHash` is not an integrity proof.
- `traceHash` does not prove observability execution.
- `policyVersion` is metadata only and does not prove policy enforcement.

## Observability Detox

Package variants must not imply:

- telemetry execution
- observability activation
- incident creation
- audit persistence
- backend review
- runtime observation

## Verdict

Audit detox is viable with explicit caveats.
