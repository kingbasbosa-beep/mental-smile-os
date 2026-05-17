# EX-120 Client AI Claims Boundary

## Doctrine

Client-visible AI claims must be conservative and externally supplied by host or
backend.

## Host-Owned Claims

Host may display:

- runtime unavailable messaging
- fallback-only support copy
- support guidance
- generic unavailable-state messaging

Only if phrased as non-authoritative user-facing copy.

## Backend-Owned Claims

Backend owns proof of:

- runtime state
- provider availability
- provider trust/capability
- telemetry/privacy state
- backend enforcement
- audit trace validity
- policy compliance
- safety validation

## Package-Blocked Claims

- AI is available
- AI response is safe
- provider is healthy
- provider supports safety/moderation
- emergency is handled
- fallback recovered
- backend enforced this action
- telemetry/privacy is guaranteed

## Existing Safe Overlap

`PassiveReviewSignal` reference labels remain the only public package overlap.
They are not client AI capability claims.

## Verdict

Client-visible AI claims remain host/backend-owned. Package labels must not
create capability, safety, or enforcement promises.
