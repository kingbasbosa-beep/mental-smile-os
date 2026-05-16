# clean_core Runtime Marker Authority Flags

Phase: EX-32 - Runtime Marker Isolation Review

## Authority Risk Model

Runtime markers must never become authority. A marker may describe a state, requirement, or boundary, but it must not decide privileged outcomes or authorize execution.

## Authority-Sensitive Terms

The reviewed marker family includes terms that require caution:

- `backendGoverned`
- `signedAuthorityPlaceholder`
- `clientOutcomeWritesAllowed`
- `emergencyGuarantee`
- `runtimeAllowed`
- `providerAllowed`
- `observabilityAllowed`
- `observabilityActive`
- `telemetryRuntimeActive`
- review-required markers
- audit-required markers

These terms are acceptable only as declarative metadata. They are not client-side permission grants.

## Boundary Marker Authority Flags

Boundary markers should be treated as hidden or review-gated when they reference:

- escalation boundaries
- backend governance
- client outcome writes
- emergency guarantees
- transfer of responsibility
- authority-sensitive locks

## Observability Authority Flags

Observability profile and guard semantics are authority-sensitive because they evaluate whether observations are signed, owned, sanitized, telemetry-free, and policy-compliant.

These files should not be public API until the architecture explicitly defines whether such checks are:

- pure validation contracts
- backend-owned enforcement rules
- adapter-boundary checks
- internal-only safety logic

## Backend Authority Rule

Any marker that mentions backend governance must preserve the following rule:

- client can describe state
- client can submit intent
- backend decides authority
- missing authority fails closed
- marker state is never proof of authority

## Authority Verdict

No reviewed marker file was found to execute backend authority. The authority risk is interpretation risk. Export decisions must prevent consumers from treating labels, markers, or guard outputs as privileged client authority.

