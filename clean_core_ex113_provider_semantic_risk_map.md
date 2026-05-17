# EX-113 Provider Semantic Risk Map

## Provider Risk Findings

Provider governance contracts include trust, capability, permission,
compatibility, restrictions, policy links, audit references, and block reasons.
These concepts are authority-bearing.

## Provider Ownership Concepts

Risk terms:

- `providerId`
- `providerType`
- provider registry
- provider trust level
- provider restrictions
- provider policy link
- provider audit reference

Classification:

- backend-only for trust/enforcement
- host-only for UI/environment selection
- metadata-only possible for externally reported provider labels

## Provider Capability Semantics

Risk terms:

- `textGeneration`
- `safeSupport`
- `translation`
- `moderationAssist`
- `crisisDetection`
- `escalationAssist`
- `auditTracing`

Risk: these imply a provider can safely perform sensitive work.

Classification:

- redesign-needed for public labels
- backend-only for capability enforcement
- permanently blocked as proof of actual provider ability

## Provider Permission Semantics

Risk terms:

- `ProviderRuntimePermission`
- `requestedCapability`
- `boundaryScope`
- `backendGoverned`
- runtime mode
- environment

Risk: these are permission and execution claims.

Classification: backend-only.

## Provider Block/Fallback Semantics

Risk terms:

- `providerBlocked`
- `trustLevelInsufficient`
- `capabilityBlocked`
- `runtimeModeBlocked`
- `environmentBlocked`
- `escalationRestricted`
- `crisisHandlingRestricted`
- `providerUnavailable`

Risk: consumers may infer confirmed provider failure or backend adjudication.

Classification:

- metadata-only possible as reported labels after detox
- provider causality remains backend-only

## Safety/Moderation Ownership

Risk terms:

- `moderationAssist`
- `crisisDetection`
- `escalationAssist`
- `safetyReview`
- `crisisSupport`

Risk: these imply moderation or crisis ownership.

Classification: host/backend-only; public passive exposure blocked pending
separate safety doctrine.
