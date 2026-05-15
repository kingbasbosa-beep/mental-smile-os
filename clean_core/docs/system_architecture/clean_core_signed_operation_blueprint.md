# Clean Core Signed Operation Blueprint

Draft signed operation expectations. No signing implementation was created.

## Purpose

Signed operations should provide a future backend-verifiable reference for trusted actions that cannot be safely decided by the client.

## Conceptual Fields

- Operation id.
- Operation type.
- Authority source.
- Signed authority marker.
- Audit link.
- Policy snapshot reference.
- Review marker when required.
- Expiration or validity window.
- Replay protection marker.
- Backend verification status.

## Expected Operation Types

- Protected field update.
- Review transition.
- Escalation transition.
- Provider governance update.
- Runtime activation.
- Policy publication.
- Release/bootstrap action.
- Payment/review/payout outcome.

## Verification Expectations

Backend should verify:

- Signature validity.
- Authority source.
- Expiration window.
- Replay protection.
- Policy snapshot compatibility.
- Audit link presence.
- Review marker where required.

## Failure Behavior

If verification fails:

- Block operation.
- Preserve audit signal.
- Require review if sensitive.
- Do not fallback to client authority.

## Explicit Non-Action

No signing, verification, or replay protection runtime was implemented.
