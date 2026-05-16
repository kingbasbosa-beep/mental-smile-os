# clean_core Runtime Marker Hidden Contracts

Phase: EX-32 - Runtime Marker Isolation Review

## Hidden Contract Definition

A hidden runtime-marker contract is a pure Dart file that remains unsuitable for public export because its semantics can imply execution, authority, routing, or runtime control.

## Hidden by Default

The following semantic categories are hidden by default:

- runtime guards
- runtime policies
- runtime locks
- runtime profiles
- boundary markers
- authority placeholders
- signed authority references
- runtime execution labels with activation implication
- observability validation chains
- provider permission labels
- escalation boundary labels

## Observability Hidden Contracts

The runtime observability family includes several hidden surfaces:

- guard semantics
- policy semantics
- lock semantics
- profile semantics
- signed authority placeholder semantics
- telemetry runtime validation semantics

These must not be exported as general public API without a future authority review.

## Boundary Marker Hidden Contracts

Boundary markers are hidden/review-gated because they can imply:

- backend authority transfer
- escalation authority
- emergency guarantees
- client write permissions
- privileged transition control

## Runtime State Hidden Contracts

Some state vocabulary should remain hidden or review-gated even when pure Dart:

- active execution labels
- activation labels
- release labels
- AI runtime labels
- provider runtime labels
- observability runtime labels

These labels can be misused if exposed without strong documentation.

## Hidden Contract Verdict

No hidden contract should be moved into public API by folder-level export. Hidden surfaces require explicit semantic approval, authority review, and fail-closed documentation before future exposure.

