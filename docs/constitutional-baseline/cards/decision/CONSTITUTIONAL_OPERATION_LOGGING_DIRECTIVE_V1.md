# Constitutional Operation Logging Directive V1

Status: ACTIVE_DECISION_CARD
Classification: CONSTITUTIONAL_OPERATION_LOGGING_DIRECTIVE
Effective date: 2026-06-18
Runtime effect: none

## Decision

Every action performed inside this repository must be registered unless the Owner explicitly says:

```text
DO NOT LOG THIS OPERATION
```

Repository memory is mandatory.

## Scope

This directive applies to:

- audits
- reports
- guides
- cards
- registries
- snapshots
- inventories
- memory updates
- finding updates
- archives
- Git operations
- Firebase operations
- runtime changes
- UI changes
- route changes
- collection changes
- signal changes
- accessibility changes
- partnership changes

## Required Operation Logging

Every operation must:

1. Create an operation record.
2. Update the Executed Operations Registry.
3. Update the Executed Operations Index.
4. Link affected cards.
5. Link affected guides.
6. Link findings.
7. Link memory updates.
8. Link archive cards when applicable.

## Required Governance Artifacts

| Trigger | Required Artifact |
| --- | --- |
| Every decision | Decision Card |
| Every problem | Finding Card |
| Every removal | Archive Card |
| Every implementation | Operation Card |
| Every architectural change | Reason, alternatives considered, chosen path, expected impact |

## Integrity Rule

Integrity verification must run after each phase.

Verification must confirm:

- chronological order
- registry/index presence
- causality chain
- affected artifact links
- missing operation detection
- duplicate operation detection

## Chronology Rule

Operations must preserve chronological order and execution timestamp order.

If later registration inserts a previously executed operation, the operation record must state the insertion reason and timeline position.

## No Undocumented Operation Rule

No operation may remain undocumented.

The only exception is an explicit Owner instruction:

```text
DO NOT LOG THIS OPERATION
```

## Architectural Change Rule

Every architectural change must include:

- Reason.
- Alternatives considered.
- Why chosen.
- Expected impact.

## Boundary

This directive changes governance documentation requirements only.

It does not modify runtime code, Firebase configuration, Git state, routes, collections, UI, or signals.
