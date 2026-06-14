# Mental Smile Claim Consumption Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | CLAIM_CONSUMPTION_CONSTITUTION_V1 |
| Block | BLOCK_5E |
| Era | CONSTITUTIONAL_RUNTIME_AUTHORIZATION_ERA |
| Scope | Claim consumption doctrine only |
| Firebase Claims Implementation | NONE |
| Runtime Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Claim Consumption Doctrine

Claims are consumed only when they trace to identity, membership, attestation, authorization, scope, and evidence. Claims are not self-authorizing.

## Claim Consumption Definitions

| Term | Definition |
|---|---|
| Claim Consumer | Runtime/governance actor that reads a claim |
| Claim Scope | Bounded resource/action/surface the claim applies to |
| Claim Validation | Verification that claim maps to identity, membership, attestation, and authorization |
| Claim Expiration | End of claim validity period or source lifecycle |
| Claim Revocation | Removal of claim trust through constitutional authority |

## Claim Consumption Lifecycle

| State | Meaning | Required Evidence | Exit |
|---|---|---|---|
| CLAIM_DECLARED | Claim class is declared from attestation | Claim creation evidence | Validation |
| CLAIM_VALIDATED | Claim maps to complete source chain | Claim validation evidence | Activation/consumption |
| CLAIM_CONSUMABLE | Runtime consumer may read claim | Authorization evidence | Suspension/expiration/revocation |
| CLAIM_SUSPENDED | Claim temporarily cannot be consumed | Suspension evidence | Recovery or revocation |
| CLAIM_EXPIRED | Claim validity has ended | Expiration evidence | Renewal or archive |
| CLAIM_REVOKED | Claim trust removed | Revocation evidence | Archive |
| CLAIM_ARCHIVED | Claim record preserved | Archive evidence | Retrieval only |

## Claim Consumption Rules

| Rule | Requirement |
|---|---|
| Consumer declared | Claim consumer must be listed |
| Scope declared | Claim must have bounded scope |
| Validation required | Claim must pass validation before consumption |
| Expiration required | Claim must have lifecycle/expiration path |
| Revocation required | Claim must be revocable |
| Evidence required | Claim consumption must be evidenced |

## Forbidden Claim Consumption

| Forbidden Pattern | Reason |
|---|---|
| Claim Without Attestation | No trust source |
| Claim Without Identity | No accountable identity |
| Claim Without Membership | No domain basis |
| Claim Without Revocation | Cannot remove trust |
| Wildcard Claim Consumption | Scope violation |
| Hidden Claim Consumption | Evidence bypass |
| Generic Admin Claim Consumption | Admin is not constitutional |

## Block 5E Validation Result

| Pass Condition | Result |
|---|---|
| Claim consumption defined | PASS |
| Claim consumer defined | PASS |
| Claim scope defined | PASS |
| Claim validation defined | PASS |
| Claim expiration defined | PASS |
| Claim revocation defined | PASS |
| Claim consumption lifecycle defined | PASS |
| Claim without attestation forbidden | PASS |
| Claim without identity forbidden | PASS |
| Claim without membership forbidden | PASS |
| Claim without revocation forbidden | PASS |

Final result: `BLOCK_5E_CLAIM_CONSUMPTION_COMPLETE`.
