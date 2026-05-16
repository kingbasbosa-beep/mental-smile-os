# EX-56 AuditRuntimeMarker Package Risk

Phase: EX-56 - AuditRuntimeMarker Package Exposure Simulation

## Runtime Naming Risk

`AuditRuntimeMarker` includes the word runtime.

Risk:

- consumers may infer runtime lifecycle authority
- consumers may treat marker values as runtime state proof

## Provider ID Risk

`providerId` is sensitive because it may imply:

- provider execution
- provider selection
- provider trust
- provider availability

In package context, it must remain an audit label only.

## Fallback Reason Risk

`fallbackReason` may imply:

- fallback execution
- fallback policy approval
- runtime recovery behavior

It must remain descriptive metadata only.

## Policy Version Risk

`policyVersion` may imply:

- signed policy authority
- active policy approval
- backend verification

It must remain a reference label unless backed by backend authority.

## Observability Risk

Because `safety_observability_contract.dart` consumes `AuditRuntimeMarker`, exporting it may pull observability-adjacent semantics toward package public API.

## Package Risk Finding

Package exposure is possible only with strong caveats. The marker is implementation-pure but semantically sensitive.

