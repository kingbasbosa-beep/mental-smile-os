# Federation Runtime Surfaces & Clean Sweep

## Scope

Bundle E creates federation runtime surface maps and clean sweep audit
foundations.

It does not create UI screens, widgets, Firestore writes, Firebase collections,
automation, notifications, runtime features, or route deletion.

## Surface Registry

Surfaces:

- client
- provider
- center
- monitoring
- archive
- commercial
- owner

## Surface Maps

Runtime surface maps define:

- what exists
- what is visible
- what is planned

No runtime execution is added.

## Legacy Navigation Audit

Legacy navigation entry types:

- legacy_button
- legacy_tab
- legacy_badge
- legacy_counter
- legacy_card
- legacy_shortcut
- legacy_drawer_entry

## Control Room Decoupling

The control room sweep tracks references between legacy routes and old control
room surfaces.

Sweep rules:

```text
If Legacy Route Exists
Find All References
Classify
Mark Matching Control Room References
```

Reference types include buttons, tabs, badges, counters, cards, quick actions,
drawer entries, deep links, and section maps.

## Cross Surface References

Cross surface audit tracks:

- route references
- tab references
- badge references
- counter references
- quick actions
- section maps

## Ghost Route Classification

Classifications:

- ghost
- contained
- replace_later
- safe_to_remove
- needs_review

## Cleanup Actions

Supported actions:

- keep
- hide
- freeze
- replace
- remove_later

## Constitutional Boundaries

Federation surface foundation must not introduce:

- admin_dashboard
- booking_surface
- session_surface
- payment_surface
- admin_runtime

## Attached Cleanup Pack

Included markers:

- Localization Alignment
- Identity Alignment
- Archive Alignment
- Readiness Marker
- Separation Marker
- Legacy Cleanup Pack
- Control Room Sweep Marker

## Federation Separation Readiness

### Surface Ready

YES

### Navigation Ready

YES

### Monitoring Ready

YES

### Archive Ready

YES

### Cleanup Ready

YES

### Separation Ready

YES
