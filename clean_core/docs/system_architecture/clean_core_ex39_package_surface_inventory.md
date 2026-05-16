# EX-39 Package Surface Inventory

Phase: EX-39 - Package Surface Freeze

## Scope

This inventory freezes the current public package surface exposed by:

- `mental_smile_clean_core/lib/mental_smile_clean_core.dart`

No exports, imports, dependencies, source files, runtime systems, provider systems, or adapters were modified.

## Current Export Groups

The current package surface exports explicit file-by-file contracts from these groups:

- audit safe-batch contracts
- backend boundary contracts
- governance capability contracts
- governance compliance contracts
- governance federation contracts
- governance kernel contracts
- governance lifecycle contracts
- human review safe-batch contracts
- policy runtime contracts
- safety decision contracts
- trusted backend contracts
- trusted pipeline contracts

## Audit Safe-Batch Surface

Approved audit exports:

- actor type
- event type
- hash placeholder
- redaction helper
- audit reference
- retention policy
- severity
- visibility scope

Excluded from audit surface:

- audit event object
- audit runtime marker
- audit snapshot
- audit trace
- safety observability contract

## Human Review Safe-Batch Surface

Approved human review exports:

- escalation audit link
- escalation level
- escalation policy reference
- escalation reason
- escalation state
- review priority
- review visibility scope

Excluded from human review surface:

- escalation assignment
- escalation boundary marker
- escalation queue
- escalation request
- escalation resolution
- escalation review

## Surface Inventory Finding

The package surface is currently curated and explicit. It includes declarative contract surfaces only and does not expose whole directories or wildcard exports.

