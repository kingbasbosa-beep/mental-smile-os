# Finding: Active System Items Require Card Coverage V1

Finding ID: FINDING-ACTIVE-SYSTEM-ITEMS-REQUIRE-CARD-COVERAGE-V1
Operation ID: OP-PERMANENT-SYSTEM-CARD-COVERAGE-RULE-V1
Date: 2026-06-18
Status: ACTIVE_FINDING
Runtime Effect: none

## Problem

Active runtime, configuration, governance, localization, workflow, or external items can exist without a card or registry entry.

When this happens, Mental Smile loses the ability to distinguish:

- active purpose
- legacy purpose
- ghost infrastructure
- Owner decision requirement
- removal readiness

## Finding

Every active item requires card or registry coverage. Missing coverage is itself a governance finding and must be recorded instead of ignored.

## Risk

Uncovered active items can become silent infrastructure, undocumented legacy, or future contamination.

## Required Governance Response

If missing coverage is found:

- create a finding
- create a card coverage gap entry
- add the item to the correct registry
- classify the gap
- update operations, finding, and memory registries

## Related Decision

- `PERMANENT_SYSTEM_CARD_COVERAGE_RULE_V1.md`

## Related Registry

- `CARD_COVERAGE_GAP_REGISTRY_V1.md`
