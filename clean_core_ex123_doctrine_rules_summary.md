# EX-123 Doctrine Rules Summary

## Scope

Docs/handoff only. This document summarizes doctrine rules established by the
completed migration waves.

## Core Package Doctrine

Package contracts may describe passive facts. They must not own routing,
execution, persistence, backend enforcement, emergency handling, provider
causality, telemetry proof, moderation ownership, retry, fallback, or recovery.

Pure Dart is necessary but not sufficient. A pure enum can still be unsafe if
its name or usage implies authority.

## Audit Doctrine

Audit package types may describe audit events, references, snapshots, traces,
visibility, severity, retention, processing context, redaction, and placeholder
hash semantics.

Audit package types must not prove backend enforcement, persistence success,
trace validity, privacy compliance, or Firestore write behavior.

Audit Firestore mapping remains host-side.

## Human Review Doctrine

Human-review package contracts may describe passive requests, reviews,
resolutions, assignments, reasons, levels, policy references, audit links,
priority, state, and visibility.

Human-review package contracts must not imply queue admission, reviewer/team
ownership, moderation ownership, emergency response, backend enforcement, or
client outcome write authority.

Human Review Firestore mapping remains host-side.

## Queue/Boundary Doctrine

Queue and boundary concepts are not package-safe in their original form.

Rules:

- no `accepts` predicates
- no routing/admission guarantees
- no team ownership guarantees
- no emergency guarantees
- no backend enforcement claims
- no client outcome write permissions
- no provider causality claims
- no fallback recovery claims
- package describes facts only

## Runtime/Provider Doctrine

Runtime/provider diagnostics and orchestration remain held back.

Rules:

- no provider causality claims
- no runtime execution guarantees
- no adapter execution proof
- no provider trust proof
- no retry/recovery guarantees
- no fallback recovery claims
- no telemetry/privacy proof
- no backend enforcement proof
- no moderation/safety ownership
- no emergency handling guarantees
- no runtime/provider public mappers
- no runtime/provider package contracts

## Public Label Doctrine

Public passive labels must not be used as:

- commands
- permissions
- workflow states
- enforcement signals
- routing/admission decisions
- audit verification
- policy compliance proof
- backend governance proof
- emergency handling
- write authority
- provider/runtime causality
- fallback recovery

## Mapper Doctrine

Mappers are host-side unless a future wave explicitly says otherwise.
Firestore/Firebase/Timestamp/FieldValue behavior must not leak into package
contracts.
