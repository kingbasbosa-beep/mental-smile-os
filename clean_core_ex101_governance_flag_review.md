# EX-101 Governance Flag Review

## Flag Verdicts

### `backendGoverned`

Verdict: backend-only contract.

This flag must not be treated as package-owned metadata. It is meaningful only
when supplied, verified, and enforced by backend governance.

Future direction:

- Backend-only contract.
- Passive package label only if clearly marked as externally asserted.
- Never use as a package-level proof of enforcement.

### `clientOutcomeWritesAllowed`

Verdict: host/backend-only.

This flag implies write authority over review or resolution outcomes. It must
not become package-facing behavior or portable client authority.

Future direction:

- Host/backend-only policy.
- No package-owned mapper or contract.
- No client-side guarantee of outcome write permission.

### `emergencyGuarantee`

Verdict: must not become a package-facing promise.

Emergency handling cannot be guaranteed by this package. A package-facing
emergency guarantee would create a false safety claim.

Future direction:

- Keep false by default.
- Prefer negative safety posture over positive guarantee.
- Backend or host may define emergency workflows externally.

### `providerFailure`

Verdict: passive metadata only if detoxed.

This reason is provider/runtime-adjacent. It must not imply package-level
knowledge of provider causality.

Future direction:

- Diagnostic label only.
- Host/backend determines actual provider failure cause.

### `fallbackLoop`

Verdict: passive metadata only if detoxed.

This reason is orchestration/runtime-adjacent. It must not imply the package owns
fallback routing or loop recovery.

Future direction:

- Diagnostic label only.
- Host/backend determines routing, fallback, and recovery behavior.

## Flag Doctrine

Governance flags should become one of:

- passive labels, when detoxed and explicitly non-authoritative
- host-only policies, when they affect client behavior or ownership
- backend-only contracts, when they imply enforcement or write authority
