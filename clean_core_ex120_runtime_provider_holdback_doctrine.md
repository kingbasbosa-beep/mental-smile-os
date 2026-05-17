# EX-120 Runtime/Provider Holdback Doctrine

## Scope

Docs/doctrine only. This document freezes runtime/provider orchestration
holdback doctrine after EX-119. It does not modify runtime/source files, create
package contracts, create mappers, export files, reconnect consumers, migrate
imports, run pub get/analyze, or activate providers, adapters, Firebase, or
runtime execution.

## Core Doctrine

Runtime/provider orchestration remains host/backend-owned. The package must not
own execution, provider selection, adapter invocation, guard decisions,
fallback behavior, retry/recovery, backend enforcement proof, telemetry/privacy
proof, moderation/safety ownership, or emergency handling.

## Classification Summary

| Concept | Classification |
| --- | --- |
| provider selection | backend-owned |
| adapter invocation | backend-owned |
| guard decisions | backend-owned |
| fallback handling | host/backend-owned |
| retry/recovery | backend-owned |
| telemetry/privacy proof | backend-owned |
| backend enforcement proof | backend-owned |
| runtime display state | host-owned if externally supplied |
| client-visible AI claims | host/backend-owned, conservative only |
| moderation/safety ownership | host/backend-owned or blocked |
| emergency handling | host/backend-owned or blocked |
| reference-presence labels | package metadata overlap already covered |

## Package-Blocked Doctrine

Package APIs must not expose:

- runtime execution guarantees
- AI completion guarantees
- adapter execution proof
- provider causality
- provider trust proof
- fallback recovery
- retry/recovery state
- backend enforcement proof
- telemetry/privacy proof
- moderation/safety ownership
- emergency handling guarantees
- runtime/provider mappers

## Existing Safe Overlap

Already covered by public `PassiveReviewSignal`:

- `auditReferencePresent`
- `policyReferencePresent`

No new package files are justified.
