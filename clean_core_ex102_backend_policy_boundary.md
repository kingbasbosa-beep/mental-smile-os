# EX-102 Backend Policy Boundary

## Purpose

Define the line between package facts and backend enforcement for queue and
boundary governance.

## Backend-Only Policies

The following must remain backend-only:

- queue admission policy
- routing policy
- review ownership policy
- resolution ownership policy
- outcome write policy
- audit enforcement policy
- policy snapshot enforcement
- backend governance verification
- emergency workflow policy
- provider failure adjudication
- fallback-loop recovery policy

## Host-Only Policies

The following may be host-owned or backend-owned, but must not be package-owned:

- UI presentation of review labels
- whether a user can submit a support request
- whether a client can request escalation
- whether a client can display a pending-review state
- whether a client can initiate a non-authoritative draft

Host-only policies may shape client behavior, but backend must remain the final
authority for writes and enforcement.

## Package-Safe Facts

Package-safe facts may include:

- labels
- externally supplied references
- non-authoritative display metadata
- fail-closed disclaimers
- detoxed diagnostic categories

These facts must be inert. They must not make decisions or grant permissions.

## Enforcement Boundary

The package must not:

- verify backend governance by itself
- decide queue admission
- decide routing
- decide emergency handling
- decide provider causality
- decide outcome writes
- act as a source of moderation authority

## Doctrine

The package describes. The host/backend decides. Backend enforcement cannot be
created by naming a flag in package metadata.
