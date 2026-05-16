# clean_core Audit Batch A Simulated Reconnect Scope

This document defines reconnect scope after a future Audit Batch A move.

## Movement Phase Reconnect

None.

Future movement must not reconnect host imports.

## Later Reconnect Candidates

Only after movement validation, later phases may consider:

- audit contract tests
- host code that only needs audit enums/references/redaction
- package public barrel import usage

## Blocked Reconnects

- Firebase audit persistence reconnect
- telemetry runtime reconnect
- provider runtime reconnect
- backend audit runtime reconnect
- report/export runtime reconnect
- routing/localization/assets reconnect

## Reconnect Rules

- Use package root barrel only.
- Do not import `lib/src/audit` directly.
- Reconnect one file or test group at a time.
- Preserve rollback after each reconnect.

## Reconnect Scope Verdict

Audit Batch A movement should happen before reconnect and remain disconnected until a later scoped phase.
