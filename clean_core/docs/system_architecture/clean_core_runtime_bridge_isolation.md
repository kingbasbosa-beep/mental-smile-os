# clean_core Runtime Bridge Isolation

This document defines runtime isolation expectations for future bridge architecture.

## Isolation Principle

Runtime remains host-owned. clean_core remains declarative.

Runtime bridges may connect host/backend execution systems to clean_core contracts, but bridges must remain fail-closed and externally owned.

## Runtime-Owned Areas

The host/backend owns:

- startup orchestration
- Firebase runtime
- provider runtime
- networking
- telemetry transport
- analytics transport
- routing execution
- print/PDF/share/download execution
- platform setup
- deployment/release execution

## clean_core-Owned Areas

clean_core owns only:

- contract language
- governance markers
- policy references
- boundary state
- safe fallback definitions
- review/audit references

## Bridge Isolation Rules

- Bridge code must not live in clean_core unless it is pure contract shape only.
- Bridge implementation must not import clean_core internals from `lib/src`.
- Bridge implementation must consume public contracts or explicitly reviewed adapter contracts.
- Bridge failure must not activate runtime alternatives.
- Bridge success must not imply backend authority unless signed/verified externally.

## Runtime Activation Rule

Creating a bridge contract does not activate runtime.

Activating runtime requires a separate future review for:

- authority
- security
- provider governance
- fail-closed handling
- audit requirements
- rollback behavior

## Isolation Verdict

Bridge isolation preserves clean_core as a governed kernel and keeps execution in the host/backend runtime layer.
