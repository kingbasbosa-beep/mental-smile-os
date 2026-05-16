# clean_core Package Boundary Contracts

## Boundary Purpose

The package boundary separates declarative governance contracts from runtime implementations owned by the host app and backend.

## clean_core Owns

clean_core may own:

- contract models
- state enums
- block reasons
- fallback descriptors
- audit/review references
- runtime-disabled markers
- backend-governed placeholders
- visibility scopes
- requirements and references

## Host App Owns

The host app owns:

- Flutter UI
- routing/navigation
- localization generation
- assets
- Firebase initialization
- auth/session runtime
- environment loading
- platform setup
- app integration tests

## Backend Owns

Backend systems own:

- trusted execution
- signed authority
- privileged writes
- provider execution
- runtime orchestration
- Cloud Functions
- audit persistence
- policy publication

## Boundary Enforcement

Boundary enforcement requires:

- no parent-path imports
- no host package imports inside clean_core
- no Firebase/Flutter/provider/networking dependencies
- adapters for all external systems
- fail-closed defaults

## Boundary Verdict

Wave 1 package boundaries are valid as an extracted shell. Future work must preserve the distinction between contracts and execution.
