# Card Coverage Gap Registry V1

Status: ACTIVE_GOVERNANCE_REGISTRY
Operation: OP-PERMANENT-SYSTEM-CARD-COVERAGE-RULE-V1
Runtime effect: none

## Purpose

Track active, legacy, ghost, or Owner-decision system items discovered without a card or registry entry.

This registry is the required landing place for uncovered system items before removal, activation, archival, or Owner decision.

## Classification Values

- `ACTIVE_WITH_MISSING_CARD`
- `GHOST_WITH_MISSING_CARD`
- `LEGACY_WITH_MISSING_CARD`
- `OWNER_DECISION_REQUIRED`

## Gap Entry Requirements

Each gap entry must include:

- Item
- Type
- File path or location
- Current connection
- Missing coverage
- Classification
- Required registry
- Related finding
- Related operation
- Status

## Gap Ledger

| Item | Type | File path / Location | Current connection | Missing coverage | Classification | Required registry | Related finding | Related operation | Status |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Card Coverage Gap Registry baseline | Governance Registry | `docs/constitutional-baseline/registries/CARD_COVERAGE_GAP_REGISTRY_V1.md` | New permanent governance registry | none | OWNER_DECISION_REQUIRED | Memory Registry / Operations Registry | FINDING-ACTIVE-SYSTEM-ITEMS-REQUIRE-CARD-COVERAGE-V1 | OP-PERMANENT-SYSTEM-CARD-COVERAGE-RULE-V1 | ACTIVE_BASELINE |

## Rule

Do not silently remove or ignore uncovered items. First record the gap, classify it, bind it to the correct registry, and log the operation.
