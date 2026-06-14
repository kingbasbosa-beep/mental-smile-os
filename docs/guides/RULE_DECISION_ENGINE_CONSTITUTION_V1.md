# Mental Smile Rule Decision Engine Constitution V1

## Document Control

| Field | Value |
|---|---|
| Document ID | RULE_DECISION_ENGINE_CONSTITUTION_V1 |
| Block | BLOCK_6D |
| Era | CONSTITUTIONAL_FIREBASE_RULES_ERA |
| Scope | Rule decision doctrine only |
| Runtime Implementation | NONE |
| Firestore Rules Changes | NONE |
| Storage Rules Changes | NONE |
| Version | v1.0.0 |
| Status | ACTIVE_CONSTITUTIONAL_SOURCE |

## Rule Decision Doctrine

Rule decisions are constitutional outcomes of rule evaluation. A decision must be explainable, evidenced, escalatable, and traceable to the rule evaluation chain.

## Decision States

| Decision State | Meaning | Runtime Effect |
|---|---|---|
| ALLOW | Evaluation passed | Permit scoped action |
| DENY | Evaluation failed | Refuse action |
| SUSPEND | Trust or claim temporarily blocked | Refuse until recovery |
| REVOKE | Trust removed | Refuse and archive revocation evidence |
| BLOCK | Critical constitutional violation | Stop consumption and escalate |

## Decision Evidence

| Evidence Class | Required Contents |
|---|---|
| Rule Evaluation Evidence | Identity, membership, attestation, claim, authorization, rule class |
| Authorization Evidence | Authorization ID, scope, owner, revocation path |
| Claim Evidence | Claim ID, state, evaluation result |
| Registry Evidence | Collection/storage/ownership registry entries |
| Decision Evidence | Decision state, reason, evaluator, escalation path |

## Decision Escalation

| Event | Escalates To | Required Action |
|---|---|---|
| Claim invalid | Compliance | Deny and record evidence |
| Hidden access detected | Compliance -> Legal -> Owner | Block |
| Admin decision detected | Compliance -> Owner | Block and remove from future model |
| Registry mismatch | Compliance / Registry Steward | Deny or block |
| Custody mismatch | Compliance -> Legal -> Owner | Block sensitive action |
| Evidence missing | Compliance -> Archive -> Owner | Deny completion |

## Forbidden Decision Patterns

| Forbidden Pattern | Reason |
|---|---|
| Silent Allow | Allow must have evaluation evidence |
| Silent Deny | Deny must have reason/evidence |
| Hidden Decision | Decisions must be traceable |
| Admin Decision | Admin is not constitutional |
| Runtime Self Decision | Runtime cannot create authority |
| Manual Override | Decisions must follow constitutional chain |

## Block 6D Validation Result

| Pass Condition | Result |
|---|---|
| Rule decision engine defined | PASS |
| Decision states defined | PASS |
| Decision evidence defined | PASS |
| Decision escalation defined | PASS |
| Silent/admin/hidden decisions forbidden | PASS |

Final result: `BLOCK_6D_RULE_DECISION_ENGINE_COMPLETE`.
