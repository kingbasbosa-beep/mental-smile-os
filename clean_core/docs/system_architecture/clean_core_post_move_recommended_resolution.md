# Post-Move Recommended Resolution

Phase: EX-40B - Post-Move Broken Consumer Strategy

## Recommended Resolution

Recommended primary path: Option A, roll back Wave 2 A1/A2 movement, unless the project is ready to immediately authorize a broader package-aware consumer restructuring.

## Rationale

Rollback is recommended because:

- package import is not currently safe in the nested analyzer context
- cross-package relative import is not an acceptable stable architecture pattern
- dependent excluded files still require semantic/runtime/Firebase/authority review
- temporary compatibility barrels may create shim debt
- known analyzer breakage should not remain open across future phases

Rollback restores the pre-move sibling graph while preserving the documentation and learning from Wave 2.

## Alternative Forward Path

If rollback is not acceptable, the next safest forward path is a dedicated EX-41 package-consumer resolution phase that decides between:

- making `clean_core` package-aware safely
- creating temporary compatibility barrels with expiry rules
- moving selected dependent files after review

That phase must be explicitly authorized before any import, export, or movement changes.

## Not Recommended

Not recommended:

- package imports from affected nested files until package resolution is stable
- cross-package relative imports
- broad reconnect
- moving Firestore-coupled files without review
- leaving analyzer breakage unresolved for long

## Stop Conditions

Stop if a proposed resolution would:

- activate runtime
- enable provider execution
- reconnect Firebase/providers
- create adapters
- use broad migration
- introduce wildcard exports
- hide Firestore-coupled movement inside a compatibility fix
- create long-lived shims without removal plan
- expand package surface without export governance

## Final Recommendation

Choose rollback for immediate stability, or open a dedicated package-consumer resolution phase before any further extraction or reconnect execution.

