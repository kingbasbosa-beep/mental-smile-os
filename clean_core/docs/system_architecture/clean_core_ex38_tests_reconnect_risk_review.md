# EX-38 Tests Reconnect Risk Review

Phase: EX-38 - Tests-Only Scoped Reconnect Authorization

## Risk Review Scope

This risk review covers only potential tests-only reconnect for moved audit and human-review safe-batch contracts.

## Current Risk Findings

Because no test references were found, current reconnect risk is low and the safest action is no-op.

## Future Reconnect Risks

If tests later reference moved contracts, risks include:

- importing package internals through `lib/src`
- reintroducing old source-path imports
- broad migration beyond tests
- changing backend-boundary test imports outside scope
- accidentally touching runtime/queue/observability-sensitive files
- confusing declarative labels with runtime execution

## Risk Classification

| Category | Current status |
| --- | --- |
| Tests needing reconnect | None found |
| Tests not affected | All Wave 2 audit/human-review tests by current search |
| Blocked tests | None identified |
| Runtime-sensitive test reconnect | None identified |
| Existing non-Wave-2 reconnect imports | Present but out of EX-38 scope |

## Risk Verdict

No-op is the safest tests-only reconnect decision for EX-38.

