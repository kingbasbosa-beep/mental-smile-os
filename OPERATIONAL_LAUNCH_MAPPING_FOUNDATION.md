# Operational Launch Mapping Foundation

## Scope

Wave O-2 creates the first federation operational launch map.

This foundation asks what must work for launch. It does not create UI,
dashboards, Firebase writes, Firestore collections, workflows, or runtime
launch automation.

## Surfaces

Launch surfaces:

- app
- web
- monitoring
- owner
- archive
- commercial

## Dependencies

Dependency types:

- legacy_dependency
- ghost_dependency
- federation_dependency

## Readiness

Readiness classes:

- ready
- partial
- blocked
- legacy_dependent

## Blockers

`LaunchBlocker` records:

- blockerId
- severity
- surface
- description

## Launch Areas

Operational areas:

- residential
- commercial
- monitoring
- archive
- owner
- ecosystem

## Launch Signals

Signal names only:

- launch_surface_assessed
- launch_blocker_detected
- launch_dependency_recorded
- launch_readiness_updated

No emission runtime is added.

## Boundaries

Launch mapping must not introduce:

- booking_launch
- session_launch
- payment_launch
- admin_launch

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

## Success Definition

O-2 succeeds when the federation has a clear foundation for identifying what
must work before operational launch.
