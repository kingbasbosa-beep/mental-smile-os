# EX-77 Human Review Metadata Candidate Strategy

## Candidate Strategy

Recommended strategy:

1. Semantic freeze for `EscalationAuditLink` and `EscalationPolicyReference`.
2. Controlled package introduction of metadata-only variants.
3. Remove `toMap` ownership from package variants.
4. Preserve host compatibility files.
5. Avoid reconnect and consumer migration.

## Package-Safe Future Fields

`EscalationAuditLink` package variant:

- `auditId`
- `traceHash`
- `policyVersion`

`EscalationPolicyReference` package variant:

- `policyVersion`
- `snapshotId`
- `hashPlaceholder`

## Renaming Review

No renaming is required before extraction if caveats are explicit. Field names are understandable but must not imply proof, enforcement, or guarantees.

## Rollback

Rollback can remain local to the future package files and explicit barrel export lines.

## EX-78 Recommendation

EX-78 should be semantic freeze, not execution. Freeze audit-detox, policy-detox, observability-detox, export boundaries, and rollback constraints before package introduction.
