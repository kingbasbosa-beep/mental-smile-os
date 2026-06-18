# Client Access Execution Decision V1

Status: ACTIVE_DECISION_CARD
Classification: PHASE_8_CLIENT_ACCESS_EXECUTION
Date: 2026-06-18
Runtime effect: yes

## Decision

Phase 8 introduces client access without requiring an account first.

The splash surface now prioritizes:

- Quick Access
- Accessibility Access
- Provider / Center Access

Legacy client login, client registration, and client profile surfaces remain available temporarily, but they are marked as `LEGACY_CANDIDATE`.

## Reason

Client access should not depend on profile creation before the user can reach support, learning, accessibility, or discovery paths.

This follows the Client Identity Extraction Era doctrine:

- repeated intent signals are fresher than stored preferences
- session rooms can show current need without turning it into permanent identity
- accessibility is access, not classification

## Alternatives Considered

| Alternative | Reason Not Chosen |
| --- | --- |
| Remove login and registration immediately | Too risky without migration, downstream dashboard review, and Owner-approved account transition. |
| Keep splash as login-first | Preserves stale account-first doctrine and blocks quick access. |
| Build full accessibility room now | Too broad for Phase 8; accessibility scaffold is still governed separately. |
| Route all users to menu | Does not explicitly introduce account-free session-room doctrine. |

## Why Chosen

The chosen path creates a low-risk public entry layer while preserving legacy routes temporarily.

It introduces the Client Session Room as an account-free access surface without deleting existing auth flows.

## Expected Impact

- Splash becomes simpler and less login-centric.
- Users can enter a session room without account creation.
- Accessibility and provider/center discovery become visible earlier.
- Legacy client login and registration remain available while being governed as extraction candidates.

## Boundary

This decision does not remove Firebase Auth, client documents, login, registration, dashboard, or profile data.

Any future removal requires a separate archive-backed operation.
