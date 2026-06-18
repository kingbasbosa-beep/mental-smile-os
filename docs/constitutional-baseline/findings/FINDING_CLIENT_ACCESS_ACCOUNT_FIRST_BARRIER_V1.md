# Finding Client Access Account First Barrier V1

Status: ACTIVE_FINDING_CARD
Classification: CLIENT_ACCESS_EXECUTION_FINDING
Date: 2026-06-18
Runtime effect: none

## Problem

The splash experience was login-first.

That made client access depend on account creation or authentication before the user could reach support, accessibility, learning, or discovery surfaces.

## Finding

Account-first access can become a barrier.

For early client interaction, a session-room entry can reduce friction while preserving legacy account routes during transition.

## Evidence

Before Phase 8 execution, splash primary action routed to `Routes.login`.

Client registration and dashboard surfaces also persisted profile and signal assumptions already documented as Client Identity Extraction candidates.

## Governance Meaning

Client access should support:

- quick access
- account-free session entry
- accessibility access
- provider/center discovery

Login and registration remain useful legacy surfaces, but they should be governed as `LEGACY_CANDIDATE` until extraction is approved and verified.

## Related Decision

`CLIENT_ACCESS_EXECUTION_DECISION_V1.md`
