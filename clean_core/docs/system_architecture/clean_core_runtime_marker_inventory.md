# clean_core Runtime Marker Inventory

Phase: EX-32 - Runtime Marker Isolation Review

## Purpose

This inventory identifies runtime-marker, boundary-marker, observability, and runtime-state vocabulary surfaces that require isolation before any future Wave 2 movement or public export decision.

The review remains architecture-only. No files were moved, no exports were changed, and no runtime/provider systems were activated.

## Reviewed Marker Families

### Runtime marker files

The reviewed runtime-marker family includes files matching `*_runtime_marker.dart` across current `clean_core/lib/core` and already extracted package areas. These files generally define labels such as:

- `runtimeMode`
- `providerId`
- `environment`
- `backendGoverned`
- disabled/default marker states
- fallback-only marker states

Representative areas include:

- architecture manifest runtime markers
- audit runtime markers
- conversation runtime markers
- execution routing runtime markers
- environment activation runtime markers
- governance runtime markers
- provider onboarding runtime markers
- response composition runtime markers
- runtime activation markers
- runtime bootstrap markers
- runtime enablement markers
- runtime execution markers
- runtime isolation markers
- runtime observability markers
- runtime readiness markers
- runtime release markers
- runtime rollback markers
- runtime wiring markers
- safety memory and safety registry runtime markers
- secure runtime envelope markers
- system topology runtime markers
- trusted backend and trusted pipeline runtime markers

## Reviewed Boundary Marker Files

Boundary-marker review includes files such as:

- `human_review/escalation_boundary_marker.dart`

Boundary markers are more authority-sensitive than ordinary labels because naming can imply ownership transfer, escalation authority, or runtime control.

## Reviewed Observability Contracts

The observability-related review includes:

- `audit/safety_observability_contract.dart`
- `runtime_observability/runtime_observability_runtime_marker.dart`
- `runtime_observability/runtime_observation.dart`
- `runtime_observability/runtime_observability_profile.dart`
- `runtime_observability/runtime_observability_guard.dart`
- `runtime_observability/runtime_observability_policy.dart`
- `runtime_observability/runtime_observability_fallback.dart`

These files are pure Dart by import posture, but observability semantics require stricter isolation because telemetry wording can be misread as runtime telemetry activation.

## Reviewed Runtime State Vocabulary

Runtime state vocabulary includes enum/state files such as:

- activation state
- bootstrap state
- enablement state
- execution state
- isolation state
- observability state
- readiness state
- release state
- rollback state
- wiring state
- secure runtime state
- AI runtime state

These files are vocabulary-only surfaces, but they should remain review-gated because active-state labels can be misinterpreted as execution readiness.

## Inventory Classification Summary

| Category | Current finding | Extraction posture |
| --- | --- | --- |
| Simple runtime markers | Mostly pure Dart label/value objects | Runtime-sensitive declarative |
| Runtime state enums | Pure Dart state vocabulary | Runtime-sensitive declarative |
| Boundary markers | Pure Dart but authority-sensitive | Hidden/review-gated |
| Observability markers | Pure Dart but telemetry-sensitive | Adapter-boundary/review-gated |
| Observability guards/policies | Pure Dart but evaluation semantics | Hidden/internal-only |
| Provider/runtime labels | Label-only in reviewed files | Review-gated, not execution authority |

