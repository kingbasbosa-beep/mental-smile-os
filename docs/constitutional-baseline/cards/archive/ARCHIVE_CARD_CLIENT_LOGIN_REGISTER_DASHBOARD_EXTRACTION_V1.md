# Archive Card: Client Login Register Dashboard Extraction V1

Status: ACTIVE_ARCHIVE_CARD
Date: 2026-06-18
Related Operation: OP-PHASE-14-CLIENT-LEGACY-REMOVAL-EXECUTION-V1
Domain: RESIDENTIAL / CLIENT_IDENTITY_EXTRACTION
Runtime effect: client registration and dashboard runtime removed

## Archived Runtime Surfaces

- `/register/client`
- `/client/dashboard`
- `ClientRegisterPage`
- `ClientDashboardPage`

## Preserved Runtime Surfaces

- `/client/session-room`
- `/login`
- provider identity
- center identity
- owner identity
- monitoring identity
- accessibility runtime

## Reason

Phase 13 identified the client register/dashboard runtime as the removable legacy client identity layer. Phase 14 removes that runtime and rewires client role navigation toward the Client Session Room.

## Archive Boundary

This archive does not delete Firebase data, rules, provider/center login, saved destinations, contact requests, support requests, or chat threads.

## Evidence

- Client registration page deleted.
- Client dashboard page deleted.
- Client register/dashboard route constants removed.
- Client register/dashboard router cases removed.
- Client login role branch rewired to Client Session Room.
- Client menu shortcut rewired to Client Session Room.
- Client registration route reference in language page rewired to Client Session Room.

## Future Follow-Up

Firebase data/rules cleanup requires a separate governed operation.
