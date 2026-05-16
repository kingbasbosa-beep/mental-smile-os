# EX-43 True Leaf Simulated Import Impact

Phase: EX-43 - True Leaf Simulated Move Plan

## Import Impact Scope

EX-42 found no consumers for:

- `AuditHashPlaceholder`
- `AuditRedaction`
- `AuditRetentionPolicy`

Therefore, no reconnect is expected after the simulated movement.

## Package Context Impact

No package-context issue is expected because no remaining `clean_core` source file is known to import these three files.

This avoids the failure mode from Wave 2 A1/A2, where moved contracts were still consumed by excluded sibling files.

## Import Changes Expected

Expected import changes:

- none inside `clean_core`
- none inside `mental_smile_clean_core`
- none inside tests
- none inside host app feature code

## Import Impact Finding

The simulated true leaf move should be reconnect-free if the consumer scan remains unchanged immediately before execution.

