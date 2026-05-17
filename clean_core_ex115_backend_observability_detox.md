# EX-115 Backend Observability Detox

## Problem

Reference and observability labels can be misread as verification, trace
validity, telemetry/privacy proof, or backend enforcement.

## Safe Reference Labels

### `auditReferencePresent`

Final caveat:

> `auditReferencePresent` means an audit reference value is present. It does not
> verify the audit, validate a trace, prove telemetry/privacy state, prove
> backend enforcement, or establish compliance.

Status: safe with caveat.

### `policyReferencePresent`

Final caveat:

> `policyReferencePresent` means a policy reference value is present. It does
> not prove policy validity, policy compliance, backend enforcement, governance
> approval, or execution permission.

Status: safe with caveat.

## Backend/Observability Meanings That Stay Blocked

- backend enforcement proof
- backend governance proof
- audit verification
- trace validity
- telemetry/privacy proof
- policy compliance proof
- execution permission

## Backend Observability Verdict

Reference-presence labels are safe only because they say "present", not
"verified". Verification and enforcement remain backend-owned.
