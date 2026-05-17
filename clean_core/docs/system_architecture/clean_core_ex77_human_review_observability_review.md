# EX-77 Human Review Observability Review

## Audit Link Fields

`EscalationAuditLink` includes:

- `auditId`
- `traceHash`
- `policyVersion`

## Observability Leakage Risks

These fields can be misread as:

- audit existence proof
- trace integrity proof
- observability execution
- telemetry linkage guarantee
- backend audit guarantee

## Audit Detox Requirements

Future package-safe variants must state:

- `auditId` is a passive identifier
- `traceHash` is metadata unless verified by backend-owned integrity systems
- audit links do not prove audit persistence, telemetry execution, observability activation, or backend review

## Related Audit Context

Package audit contracts already caveat `AuditReference`, `AuditTrace`, and hash placeholders as metadata-only. Human review metadata should follow the same detox pattern.

## Verdict

Observability risk is acceptable for a metadata-only variant, but direct movement with `toMap` should be avoided.
