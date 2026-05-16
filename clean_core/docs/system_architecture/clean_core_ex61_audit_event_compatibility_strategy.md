# EX-61 Audit Event Compatibility Strategy

Phase: EX-61 - audit_event Split Simulation V2

## Existing Compatibility Path

Existing path:

- `clean_core/lib/core/audit/audit_event.dart`

## Recommended Compatibility Strategy

Use additive-first strategy:

1. keep existing host-side `audit_event.dart`
2. add future package pure model
3. add future host-side Firestore mapper
4. avoid consumer migration
5. avoid reconnect

## Why Compatibility Still Matters

Existing file imports:

- audit actor type
- audit event type
- audit reference
- audit runtime marker
- audit severity
- audit visibility scope

Removing or moving it would break consumer topology.

## Compatibility Finding

Additive compatibility remains possible and should be required. Existing consumers can remain stable while package model and mapper mature separately.

