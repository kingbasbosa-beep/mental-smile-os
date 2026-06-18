# Permanent System Card Coverage Rule V1

Decision ID: PERMANENT_SYSTEM_CARD_COVERAGE_RULE_V1
Operation ID: OP-PERMANENT-SYSTEM-CARD-COVERAGE-RULE-V1
Date: 2026-06-18
Status: APPROVED_DIRECTIVE
Runtime Effect: none
Firebase Effect: none
Git Effect: none

## Purpose

Every active thing inside Mental Smile runtime, configuration, governance, and public/external surface must have a card or registry entry.

This rule prevents undocumented active system items from surviving as invisible infrastructure, silent legacy, ghost runtime, or ungoverned public behavior.

## Coverage Scope

This rule applies to:

- Routes
- Pages
- Widgets
- Collections
- Rules
- Signals
- Assets
- YAML entries
- Roles
- Workflows
- Firebase configs
- Localization keys
- Public links
- External tools
- Provider fields
- Center fields
- Accessibility resources

## Mandatory Response To Missing Coverage

If any active item is found without a card or registry entry:

1. Do not ignore it.
2. Do not remove it silently.
3. Create a Finding.
4. Create a Card Coverage Gap entry.
5. Add it to the correct Registry.
6. Classify it.
7. Update Operations Registry.
8. Update Operations Index.
9. Update Finding Registry.
10. Update Memory Registry.

## Allowed Classifications

- `ACTIVE_WITH_MISSING_CARD`
- `GHOST_WITH_MISSING_CARD`
- `LEGACY_WITH_MISSING_CARD`
- `OWNER_DECISION_REQUIRED`

## Operation Logging Rule

Every operation must be logged, including:

- Minor checks
- Removals
- Audits
- Registry edits
- Card edits
- One-line fixes
- Runtime changes
- Config changes
- Documentation-only changes

No exception exists unless the Owner explicitly says:

```text
DO NOT LOG THIS OPERATION
```

## Governance Requirement

No undocumented active system item is allowed.

Cards and registries are not optional memory. They are part of the Mental Smile operating system.

## Related Finding

- `FINDING-ACTIVE-SYSTEM-ITEMS-REQUIRE-CARD-COVERAGE-V1`

## Related Registry

- `CARD_COVERAGE_GAP_REGISTRY_V1.md`

## Final Directive

PERMANENT_SYSTEM_CARD_COVERAGE_RULE_ACTIVE
