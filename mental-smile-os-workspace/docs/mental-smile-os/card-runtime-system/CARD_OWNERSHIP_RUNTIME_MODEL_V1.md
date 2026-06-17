# CARD_OWNERSHIP_RUNTIME_MODEL_V1

Status: REGISTERED

## Ownership Doctrine

Card ownership belongs to the constitutional owner of the card definition.

Runtime consumption does not transfer ownership.

## Ownership Rules

- Owner defines card authority.
- Registry records card authority.
- Runtime consumes card guidance.
- Consumer surfaces may use a card but may not mutate card authority.
- Archive preserves card snapshots but does not own active card authority.

## Required Ownership Fields

| Field | Required |
|---|---|
| Card Owner | YES |
| Source Authority | YES |
| Consumer Runtime | If applicable |
| Archive Custodian | If archived |
| Clone Owner | If cloned |
| Replacement Owner | If replaced |

## Violations

- Runtime mutates card authority.
- Consumer claims ownership.
- Archive edits active card source.
- Card has no owner.
