# EX-113 Fake AI Guarantee Risks

## Core Finding

Runtime/provider terms can create fake AI guarantees even when implemented as
plain Dart labels or guards.

## Fake-Guarantee Risk Areas

### Execution guarantees

Terms like `aiEnabled`, `executionEnabled`, `complete`, `success`, and
`validatedOutput` can imply AI execution will happen or is safe.

Verdict: blocked from passive public exposure.

### Backend execution claims

Terms like `backendGoverned`, `requiresBackendGovernance`, and
`backendGovernanceRequired` can imply backend enforcement proof.

Verdict: backend-only.

### Provider causality

Terms like `providerUnavailable`, `providerBlocked`, `providerFailure`, and
provider capability gaps can be misread as confirmed provider fault.

Verdict: metadata-only possible only as reported issue labels; causality remains
backend-owned.

### Fallback/retry/recovery

Terms like `fallbackOnlyMode`, `fallbackResponse`, `fallbackLoop`, and
`runtimeDisabled` can be misread as fallback availability or recovery.

Verdict: metadata-only possible only as observation labels; recovery claims are
blocked.

### Safety/moderation ownership

Terms like `safetyClassification`, `safeSupport`, `moderationAssist`,
`crisisDetection`, and `escalationAssist` can imply a model/provider owns safety.

Verdict: host/backend-only or blocked.

### Observability guarantees

Terms like `auditTrace`, `traceHashPlaceholder`, `telemetryRuntimeActive`, and
`isSanitized` can imply telemetry validity or privacy enforcement.

Verdict: backend-only for proof; metadata-only possible only after caveats.

## Prevention Strategy

- do not export runtime/provider execution labels
- do not expose provider/fallback labels as causality
- require public caveats before any metadata labels
- keep adapters and guards internal
- keep retry/recovery claims blocked
- keep backend governance claims backend-only
