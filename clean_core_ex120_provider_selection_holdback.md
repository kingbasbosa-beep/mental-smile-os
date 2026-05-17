# EX-120 Provider Selection Holdback

## Doctrine

Provider selection is backend-owned.

## Backend-Owned Responsibilities

- choose provider
- allow or block provider
- evaluate provider trust
- evaluate provider capability
- evaluate provider compatibility
- enforce provider restrictions
- bind provider to runtime mode/environment
- decide provider audit or policy readiness

## Host-Owned Responsibilities

Host may display externally supplied provider status only when caveated. Host
display must not become selection proof.

## Package-Blocked Semantics

- provider available
- provider selected
- provider trusted
- provider compatible
- provider supports capability
- provider caused failure
- provider approved for crisis/safety/moderation

## Existing Safe Overlap

`policyReferencePresent` and `auditReferencePresent` may describe reference
presence only. They do not prove provider readiness.

## Verdict

Provider selection remains backend-owned. No package diagnostics or exports are
justified.
