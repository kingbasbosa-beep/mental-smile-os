# MONITORING_ROUTE_VALIDATION_V1

## Objective

Validate monitoring route separation.

## Monitoring Route Set

- `/s/capital/signal-monitoring-room`
- `/s/capital/reports`

## Exact Sequence

1. Test unauthenticated access.
2. Confirm redirect to login.
3. Test authenticated non-monitoring access.
4. Confirm denied access.
5. Test authenticated monitoring operator access.
6. Confirm monitoring routes render.
7. Confirm monitoring role cannot access owner-only routes.
8. Confirm monitoring role cannot authorize mutation or owner actions.

## Pass Criteria

- Monitoring routes require `monitoring_operator`.
- Monitoring cannot substitute for owner authority.
- Monitoring remains observe/report only.
- No admin authority is required.

## Known Watch Area

Firestore rules currently had a duplicate `isMonitoringOperator()` warning in prior audit. Runtime validation should confirm route behavior remains consistent after any future Firebase cleanup.

