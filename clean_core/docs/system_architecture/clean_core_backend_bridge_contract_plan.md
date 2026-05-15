# Clean Core Backend Bridge Contract Plan

Draft backend bridge contract plan.

## Bridge Purpose

The backend bridge should define how the host app and clean_core contracts request trusted backend decisions without embedding backend runtime inside clean_core.

## Contract Groups

### Trusted Operation Request

Conceptual fields:

- Request id.
- Operation type.
- Actor reference.
- Resource reference.
- Sanitized payload.
- Policy reference.
- Audit placeholder.
- Review marker.

### Trusted Operation Result

Conceptual fields:

- Result id.
- Decision state.
- Authority marker.
- Audit reference.
- Policy snapshot reference.
- Review/escalation marker.
- Fallback reason if blocked.

### Authority Marker

Conceptual fields:

- Authority source.
- Signed marker.
- Validity window.
- Verification status.

### Failure Results

- Fallback result.
- Blocked result.
- Review-required result.
- Escalation-required result.

## Failure Behavior

- Backend unavailable → fail closed.
- Unsigned result → block.
- Stale authority → review or deny.
- Missing audit → block if audit required.
- Policy mismatch → block or review.
- Unknown result → fallback-only or blocked.

## Explicit Non-Action

No backend bridge or network call was implemented.
