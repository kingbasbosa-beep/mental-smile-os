# EX-77 Human Review Policy Semantics Review

## Policy Fields

`EscalationAuditLink` includes:

- `policyVersion`

`EscalationPolicyReference` includes:

- `policyVersion`
- `snapshotId`
- `hashPlaceholder`

## Policy Leakage Risks

These fields can be misread as:

- policy enforcement proof
- policy approval
- backend compliance guarantee
- immutable policy snapshot proof
- trusted governance authority

## Required Policy Detox

Future package-safe variants must state:

- `policyVersion` is metadata only
- `snapshotId` is a passive reference only
- `hashPlaceholder` is not an integrity proof
- policy references do not prove enforcement, authorization, compliance, or backend approval

## Verdict

Policy semantics are manageable with caveats and serialization removal.
