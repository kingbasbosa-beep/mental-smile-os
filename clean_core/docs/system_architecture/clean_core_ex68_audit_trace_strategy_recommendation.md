# EX-68 AuditTrace Strategy Recommendation

## Strategy Options

### True Leaf Extraction

Not recommended. `audit_trace.dart` has imports, Firestore mapping, runtime marker dependency, and nested serialization.

### Complete Safe Cluster Movement

Not recommended. Moving `AuditRuntimeMarker`, `AuditReference`, observability-adjacent contracts, and Firestore-coupled mapping as a cluster would expand risk and package surface.

### Mapper Split Before Movement

Recommended. The best strategy is an additive split:

- package-safe pure `AuditTrace` model
- host-side Firestore mapper
- existing compatibility `audit_trace.dart` retained
- no consumer migration
- no reconnect

### Blocked for Now

Not fully blocked, but not execution-ready until a dedicated split design and pre-execution approval are completed.

## Future Package Model Shape

A future pure model may include:

- `traceId`
- `traceHash`
- `policyVersion`
- `processingContext`
- `references`
- `sanitizedPreview`
- `createdAt`

`processingContext` should use `AuditProcessingContext`, not `AuditRuntimeMarker`.

## Rollback Scope

Future rollback should be local to:

- new package `AuditTrace` file
- new host-side Firestore mapper
- optional compatibility edit, if approved
- one explicit barrel export line

No reconnect rollback should be required.
