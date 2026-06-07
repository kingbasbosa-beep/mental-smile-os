# Launch Surfaces Planning And Duplicate Function Sweep

## Purpose

Bundle F defines the first launch-surface planning language for Mental Smile Federation.

It does not create UI, widgets, runtime flows, Firebase writes, route changes, automation, or route deletion.

The goal is to know what the first launch surfaces should contain before building any screen, and to expose old/new function conflicts before separation.

## Launch Surfaces

The foundation defines three first launch surfaces:

- Client Launch Surface
- Monitoring Launch Surface
- Archive Launch Surface

Each surface has:

- sections
- tabs
- cards
- counters
- notes

These are blueprints only. They describe what should exist, not what currently renders.

## Client Blueprint

The client surface is planned around:

- My Signals
- Tools
- Saved Destinations
- Guidance

The client blueprint avoids lifecycle language and focuses on personal signal space, tool frames, saved access, and support guidance.

## Monitoring Blueprint

The monitoring surface is planned around:

- Residential Monitoring
- Commercial Monitoring
- Operational Observatory

The monitoring blueprint reads aggregate and observatory language only. It does not track individuals, journeys, payments, or old operational queues.

## Archive Blueprint

The archive surface is planned around:

- Archive Packages
- Federation Reports
- Sovereign Archive

The archive blueprint separates report packages, export packages, and owner sovereign packages.

## Duplicate Functions

The duplicate function sweep records function overlap between older surfaces and federation-era surfaces.

Current foundation examples:

- Client support shortcut vs ClientGuidanceCardS
- Operations counter vs MonitoringCounterS
- Archive report card vs ArchiveReportCardS

The sweep does not remove anything. It only marks overlap for later cleanup.

## Conflict Maps

Function conflicts are classified as:

- duplicate
- legacy_overlap
- replace_candidate
- safe_to_merge
- needs_review

Conflict maps connect:

- old function
- new federation function
- surface
- classification

## S-Suffix Rule

When a federation-era function has nearly the same purpose as an older function, the new function receives an `S` suffix.

Examples:

- ClientGuidanceCardS
- MonitoringCounterS
- ArchiveReportCardS
- MonitoringSignalsTabS

The suffix marks the federation-era version during transition so old and new functions are not confused during construction.

## Cleanup Actions

Cleanup actions are:

- keep
- hide
- freeze
- replace
- remove_later

These actions are planning labels only. They do not mutate navigation or runtime.

## Control Room Cleanup

Control Room cleanup continuation tracks references from the old control surface:

- buttons
- tabs
- counters
- badges
- cards
- quick actions
- drawer entries

Each reference receives a cleanup action and a federation replacement candidate when available.

## Attached Cleanup Pack

Bundle F includes markers for:

- Localization Alignment
- Identity Alignment
- Archive Alignment
- Readiness Marker
- Separation Marker
- Legacy Cleanup Pack
- Control Room Sweep Marker
- Duplicate Function Sweep Marker

These markers prepare future bundles to build once and separate once.

## Constitutional Boundaries

The launch surface boundary prevents these terms from becoming new launch-surface names:

- booking_tab
- session_tab
- payment_tab
- admin_dashboard_tab
- legacy_runtime_surface

The foundation may mention these terms only as forbidden boundary examples. They are not valid new surface names.

## Federation Separation Readiness

### Launch Surface Ready

YES. First client, monitoring, and archive blueprints exist.

### Cleanup Ready

YES. Cleanup actions and sweep markers exist.

### Conflict Ready

YES. Duplicate and conflict registries exist.

### Naming Ready

YES. The S-suffix convention exists.

### Archive Ready

YES. Archive launch blueprint and archive alignment marker exist.

### Separation Ready

YES. The foundation exposes old/new conflicts before construction.

## Build Restrictions Honored

No UI was created.

No widgets were created.

No Firebase writes were added.

No Firestore collections were added.

No runtime features were created.

No routes were modified or deleted.
