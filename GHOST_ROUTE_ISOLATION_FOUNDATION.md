# Ghost Route Isolation Foundation

## Scope

Wave O-1 adds a federation route classification foundation.

This foundation does not delete routes, modify routes, modify UI, modify
navigation, or modify GoRouter.

## Route Classes

Supported route classifications:

- federation
- transitional
- legacy
- ghost
- owner
- monitoring
- commercial
- archive

## Ghost Routes

Ghost routes are routes retained for compatibility while being prevented from
becoming modern entry points again.

Ghost categories:

- legacy_booking
- legacy_payment
- legacy_session
- legacy_admin
- legacy_accounting

## Federation Routes

Federation route groups:

- monitoring
- archive
- commercial
- owner
- guidance
- reputation
- tool_meter

## Migration Markers

`RouteMigrationMarker` records:

- legacySource
- federationReplacement
- migrationStatus

It does not modify the active router.

## Visibility Rules

`RouteVisibilityContract` supports:

- visible
- restricted
- hidden
- ghost_only

## Constitutional Boundaries

New route foundation naming must not introduce:

- booking workflow
- session workflow
- payment workflow
- admin operations

Legacy phrases may appear only inside ghost isolation and boundary records.

## Federation Separation Readiness

### Navigation Ready

YES

### Migration Ready

YES

### Monitoring Ready

YES

### Archive Ready

YES

### Separation Ready

YES

## Success Path

Each route can now receive a constitutional classification without changing the
application router.
