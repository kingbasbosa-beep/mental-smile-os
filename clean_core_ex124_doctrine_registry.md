# EX-124 Doctrine Registry

## Scope

Docs/review only. This registry consolidates doctrine from EX-99 through
EX-123 before future implementation waves. It does not approve new contracts,
mappers, exports, imports, consumers, providers, Firebase behavior, or runtime
activation.

## Registry

### Additive Split Doctrine

New package surface must be additive, explicit, and separately reviewable. A
future split must not silently repurpose existing host behavior, migrate
consumers, or imply that host execution moved into the package.

### Semantic Freeze Doctrine

Previously blocked semantics remain frozen unless a later doctrine wave
explicitly reopens them. Names that imply routing, queue admission, backend
enforcement, provider causality, fallback recovery, emergency handling, or
client write authority remain unsafe even when implemented as pure Dart.

### Passive Metadata Doctrine

Package contracts may describe passive facts and references only. Public labels
are not commands, permissions, workflow states, enforcement signals,
routing/admission decisions, audit verification, policy compliance proof,
backend governance proof, emergency handling, write authority,
provider/runtime causality, or fallback recovery.

### Explicit Export Doctrine

The package barrel must remain file-by-file and intentional. Wildcard exports,
directory exports, implicit namespace exposure, and accidental export of
internal vocabulary files are blocked.

### Rollback-Local Doctrine

Experimental or held-back vocabulary must remain rollback-local: isolated,
unexported, unconsumed, and removable without touching runtime logic,
providers, Firestore mappers, or app consumers.

### Compatibility Preservation Doctrine

Existing public package contracts should not be broken to advance a future
wave. Future additions must preserve the current public surface unless a
separate compatibility plan explicitly authorizes a breaking change.

### Host-Owned Execution Doctrine

Execution remains host/backend-owned. Routing, queue admission, reviewer
assignment, provider selection, adapter invocation, guard decisions, fallback
handling, retry/recovery, backend enforcement, telemetry/privacy proof,
moderation ownership, outcome writes, and emergency handling do not move into
`mental_smile_clean_core`.

### Fake Guarantee Prevention Doctrine

The package must not create fake guarantees through authoritative names,
over-broad labels, or mappers that make passive metadata look like execution
proof. Caveats must travel with public passive labels.

### Runtime/Provider Holdback Doctrine

Runtime/provider diagnostics remain held back. Provider issue, provider
capability, fallback loop, fallback-only mode, runtime disabled, backend
unavailable, adapter execution, and provider trust concepts are not approved as
package contracts, exports, mappers, or consumer-facing APIs.

## EX-124 Finding

Pass. The governing doctrine after EX-123 remains governance-first and
containment-first. EX-124 records the doctrine as a registry only and does not
authorize implementation.
