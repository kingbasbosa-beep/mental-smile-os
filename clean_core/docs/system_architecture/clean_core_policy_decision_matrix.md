# Clean Core Policy Decision Matrix

Draft decision hierarchy for future policy governance.

## Decision Hierarchy

Higher-priority decisions override lower-priority decisions:

1. Emergency shutdown.
2. Deny.
3. Escalation required.
4. Review required.
5. Fallback only.
6. Restricted allow.
7. Allow.

## Authority Hierarchy

Backend authority outranks local authority:

1. Signed backend policy.
2. Backend-governed runtime config.
3. Audit-linked policy snapshot.
4. Environment policy.
5. Local static fallback policy.

If higher authority is missing, fail closed.

## Conflict Resolution

- Deny beats allow.
- Escalation beats execution.
- Review-required beats auto-action.
- Backend authority beats local authority.
- Emergency shutdown beats provider execution.
- Missing audit link blocks audit-required operations.
- Missing consent blocks consent-required operations.
- Unknown confidence fails safer.

## Tie-Breaking

If two rules conflict at the same level:

- Choose the safer state.
- Prefer blocked over fallback-only.
- Prefer review-required over auto-action.
- Prefer backend-required over client action.
- Preserve audit requirement.

## Fallback Behavior

Fallback may provide safe support or inactive planning states only. It must not:

- Activate providers.
- Bypass review.
- Perform privileged client writes.
- Start runtime execution.
- Hide policy failure.

## Blocked-State Behavior

Blocked state should preserve:

- Reason key.
- Audit reference when available.
- Review marker when required.
- Backend authority requirement.

## Explicit Non-Action

No decision engine behavior was changed.
