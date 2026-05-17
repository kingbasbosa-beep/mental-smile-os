# EX-118 Backend-Only Diagnostic Strategy

## Strategy

If diagnostics become operational records, they should be backend-only.

## Backend-Owned Meanings

The backend should own:

- provider causality
- provider trust proof
- provider compatibility proof
- runtime execution permission
- backend enforcement proof
- retry/recovery state
- fallback recovery state
- telemetry/privacy verification
- audit trace verification

## Why Backend-Only Fits

Runtime/provider diagnostics often require actual authority or evidence. A
package label cannot prove that a provider failed, a backend was unavailable, or
a fallback recovered.

## Package Boundary

The package should not introduce records or mappers for backend-only diagnostics
until backend contracts exist and are reviewed separately.

## Backend-Only Verdict

Recommended for any future diagnostic record semantics. Not a package
introduction path.
