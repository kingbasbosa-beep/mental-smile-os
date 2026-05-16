# EX-56 AuditRuntimeMarker Export Caveats

Phase: EX-56 - AuditRuntimeMarker Package Exposure Simulation

## Required Caveats if Exported

If any runtime marker surface is exported later, documentation must state:

- marker is audit metadata only
- marker does not activate runtime
- marker does not prove provider execution
- marker does not approve fallback
- marker does not verify policy authority
- marker does not create backend guarantees
- marker does not start observability or telemetry

## Export Constraints

Future export must be:

- explicit file-by-file only
- no wildcard export
- no directory export
- no observability export bundled with it
- no runtime execution surface bundled with it

## Naming Caveat

If possible, prefer safer naming than `AuditRuntimeMarker` for package public API.

The word marker is acceptable only if the contract is clearly described as label-only metadata.

## Rollback Caveat

Rollback must remain limited to:

- marker file
- export line
- mapper/pure model references introduced in that phase

## Export Caveat Finding

Exporting the current type as-is is possible but not recommended without renaming or strong documentation.

