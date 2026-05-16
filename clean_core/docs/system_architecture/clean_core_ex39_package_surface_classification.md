# EX-39 Package Surface Classification

Phase: EX-39 - Package Surface Freeze

## Classification Model

Current exports are classified into:

1. approved stable contracts
2. declarative-only contracts
3. runtime-sensitive labels
4. backend-authority-sensitive labels
5. future-review-only exports

## Approved Stable Contracts

Approved stable contract groups include:

- backend boundary value contracts
- audit safe-batch labels and references
- human review safe-batch labels and references
- safety decision labels, reasons, states, scopes, results, and verdicts
- policy runtime requirements, modes, modules, scopes, restrictions, states, and snapshot references

## Declarative-Only Contracts

The following are declarative-only and non-executing:

- audit labels and visibility contracts
- human review labels and visibility contracts
- governance references, requirements, scopes, states, fallbacks, review markers, audit links, and visibility scopes
- trusted backend/pipeline references, requests, responses/results, states, stages, block reasons, fallbacks, and visibility scopes

## Runtime-Sensitive Labels

Some exported files include runtime-sensitive wording but are frozen as declarative labels only:

- governance runtime markers
- trusted backend runtime marker
- trusted pipeline runtime marker
- runtime policy states/modes/snapshot references
- safety decision guard contract

These exports must not be interpreted as runtime activation authority.

## Backend-Authority-Sensitive Labels

Backend-authority-sensitive labels include:

- backend governed actions
- cloud function boundary contracts
- protected governance fields
- server-owned fields
- trusted operation contracts and types
- trusted backend request/response references
- trusted pipeline request/result references

These describe authority boundaries only. They do not grant client-side authority.

## Future-Review-Only Areas

Future-review-only areas remain outside the public surface:

- runtime marker families not already approved
- observability contracts
- audit event/trace/snapshot/runtime marker surfaces
- escalation queue/boundary/assignment/request/resolution/review surfaces
- Firestore-coupled files
- adapters
- provider/Firebase/runtime implementation surfaces

