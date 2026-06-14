# Mental Smile Claim Evaluation Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | CLAIM_EVALUATION_CONSTITUTION_V1 |
| Block | BLOCK_6C |
| Era | CONSTITUTIONAL_FIREBASE_RULES_ERA |
| Scope | Claim evaluation doctrine only |
| Claims Implementation | NONE |
| Runtime Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Claim Evaluation Doctrine

Claims are evaluated as runtime-consumable reflections of constitutional authority. Claims do not self-validate and do not create authority.

## Claim Evaluation States

| State | Meaning | Rule Decision Effect |
|---|---|---|
| Claim Valid | Identity, membership, attestation, authorization, evidence all match | May proceed to rule decision |
| Claim Invalid | Required source chain is missing or mismatched | Deny |
| Claim Suspended | Temporary block exists | Suspend / Deny consumption |
| Claim Revoked | Trust has been removed | Revoke / Deny consumption |
| Claim Expired | Validity window has ended | Deny until renewed |

## Claim Evaluation Inputs

| Input | Purpose |
|---|---|
| Identity | Confirms accountable actor/object |
| Membership | Confirms domain relationship |
| Attestation | Confirms trust source |
| Authorization | Confirms permitted action/scope |
| Evidence | Confirms auditability and lifecycle |

## Claim Evaluation Outputs

| Output | Meaning | Required Evidence |
|---|---|---|
| Allow | Claim evaluation passes and can continue to rule decision | Claim evaluation evidence |
| Deny | Claim evaluation fails | Deny evidence |
| Suspend | Claim temporarily blocked | Suspension evidence |
| Revoke | Claim trust removed | Revocation evidence |

## Forbidden Claim Evaluation Patterns

| Forbidden Pattern | Reason |
|---|---|
| Self Validated Claim | Claim cannot certify itself |
| Hidden Claim | Claim must be explicit and evidenced |
| Wildcard Claim | Claim must be scoped |
| Inherited Admin Claim | Admin authority is non-constitutional |
| Claim Without Evidence | Rule decisions must be auditable |

## Block 6C Validation Result

| Pass Condition | Result |
|---|---|
| Claim evaluation defined | PASS |
| Claim states defined | PASS |
| Claim inputs defined | PASS |
| Claim outputs defined | PASS |
| Forbidden patterns defined | PASS |

Final result: `BLOCK_6C_CLAIM_EVALUATION_COMPLETE`.
