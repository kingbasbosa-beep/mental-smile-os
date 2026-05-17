# EX-102 Boundary Decomposition Strategy

## Goal

Split boundary semantics into package-safe passive labels and backend/host-owned
policies.

## Passive Boundary Labels

Potential package-safe labels after redesign:

- `backend_governance_asserted`
- `client_outcome_write_policy_present`
- `emergency_capability_not_guaranteed`
- `policy_reference_present`
- `audit_reference_present`
- `review_boundary_observed`

These labels must be clearly non-authoritative. They describe observed or
externally supplied metadata only.

## Backend-Only Governance Policies

Backend-owned policies include:

- backend governance verification
- policy version enforcement
- audit trace enforcement
- route approval enforcement
- queue admission enforcement
- moderation ownership enforcement
- provider/runtime boundary enforcement

`backendGoverned` must be treated as a backend-only contract, not a package
guarantee.

## Host-Only Write Policies

Host/backend-owned write policies include:

- assignment writes
- review writes
- resolution writes
- outcome writes
- state transitions
- archived/rejected/resolved transitions

`clientOutcomeWritesAllowed` must remain host/backend-only. A package must not
grant or imply outcome write authority.

## Emergency Boundary

`emergencyGuarantee` must not become package-facing promise. If future metadata
needs to mention emergency semantics, it should express the absence of a package
guarantee rather than claim emergency handling capability.

## Doctrine

Boundary decomposition must separate labels from powers. Labels may be package
safe after detox. Powers remain host/backend-owned.
