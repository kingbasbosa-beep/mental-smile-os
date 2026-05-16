# clean_core Wave 2 Safe Batches Reconnect Boundary

This document defines reconnect boundaries after future safe batch movement.

## Movement Phase Reconnect

None.

No host imports should be changed during movement.

## Later Reconnect Candidates

Later scoped reconnect may consider:

- contract tests for audit labels/references
- contract tests for human review labels/references
- host code that only needs public package vocabulary

## Blocked Reconnects

- Firebase persistence reconnect
- telemetry runtime reconnect
- escalation assignment/review execution
- provider reconnect
- routing/localization/assets reconnect
- adapter implementation

## Reconnect Rules

- Use the package root barrel only.
- Do not import from `lib/src`.
- Reconnect one test or file group at a time.
- Keep rollback checkpoint after every reconnect.

## Reconnect Boundary Verdict

Safe batch movement must remain disconnected until a separate reconnect phase is approved.
