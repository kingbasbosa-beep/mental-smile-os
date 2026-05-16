# EX-54 Audit Event Authority Runtime Review

Phase: EX-54 - audit_event Split Design

## Authority-Sensitive Fields

Authority-sensitive fields:

- `actorType`
- `actorId`
- `policyVersion`
- `visibilityScope`
- `references`

These fields describe audit context but must not prove trusted authority by themselves.

## Privacy-Sensitive Fields

Privacy-sensitive fields:

- `actorId`
- `sanitizedPreview`
- `references`

The pure model must not contain raw sensitive content.

## Runtime-Sensitive Field

Runtime-sensitive field:

- `runtimeMarker`

It contains runtime mode, provider id, policy version, and fallback reason vocabulary.

## Event Semantics

`AuditEventType` includes labels such as:

- `runtimeDisabled`
- `providerRejected`
- `protectedWriteDenied`
- `safetyReviewRequired`

These are declarative event labels only. They must not execute runtime/provider behavior.

## Authority/Runtime Finding

`audit_event.dart` is split-eligible only if runtime marker semantics remain declarative and backend authority remains outside the package.

