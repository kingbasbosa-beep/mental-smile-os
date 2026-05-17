# EX-126 Rollback Template

## Scope

Docs/template only. This template must be completed before any future package
contract, export, host mapper, consumer migration, passive vocabulary,
queue/boundary concept, runtime/provider diagnostic, or operational/admin
surface can proceed.

## Rollback Summary

- Candidate:
- Candidate type:
- Rollback owner:
- Rollback trigger:
- Expected rollback size:
- Can rollback be local?

## Files To Remove Or Revert

| File | Action | Reason | Owner |
| --- | --- | --- | --- |
|  |  |  |  |

## Export Rollback

- Barrel export added:
- Exact export line:
- Can export be removed without breaking existing public consumers?
- Compatibility concern:
- Mitigation:

## Mapper Rollback

- Mapper files added:
- Host-side only:
- Firestore/Firebase dependencies introduced:
- Can mapper rollback happen without package changes?
- Can mapper rollback happen without consumer changes?

## Consumer Rollback

- Consumers migrated:
- Imports changed:
- Behavior changed:
- Exact revert path:
- Data compatibility concern:

## Persistence Rollback

- Firestore/Firebase schema affected:
- Timestamp/FieldValue behavior affected:
- Existing documents affected:
- Backfill needed:
- Data rollback needed:

## Compatibility Rollback

- Public API affected:
- Host behavior affected:
- Consumer behavior affected:
- Breaking change risk:
- Deprecation needed:

## Stop Conditions

Stop if:

- rollback requires runtime/provider activation
- rollback requires deleting unrelated source logic
- rollback requires changing unapproved consumers
- rollback requires moving mapper ownership into the package
- rollback breaks existing public API without a compatibility plan
- rollback cannot remove the candidate in a small, local change

## Rollback Verdict

Rollback verdict:

- `Pass`
- `Blocked`
- `Needs smaller scope`
- `Needs compatibility plan`
- `Needs migration plan`
