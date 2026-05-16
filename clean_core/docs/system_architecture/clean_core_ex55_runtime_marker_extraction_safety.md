# EX-55 Runtime Marker Extraction Safety

Phase: EX-55 - Audit Runtime Marker Review

## Extraction Options

### Option A - Keep in clean_core only

Safest short-term option.

Pros:

- avoids runtime vocabulary exposure
- avoids package API semantic confusion

Cons:

- blocks full `audit_event` package model if runtime marker remains a typed dependency

### Option B - Move later as pure vocabulary

Possible with caveats.

Requirements:

- semantic documentation
- explicit file-by-file export
- no runtime execution
- no provider authority
- no backend guarantee semantics

### Option C - Redesign first

Possible redesign:

- rename to clarify audit metadata
- use neutral names such as `runtimeModeLabel` or `providerLabel`
- split provider/runtime/fallback references if needed

## Extraction Classification

Classification:

- pure declarative vocabulary
- runtime-sensitive semantic contract
- observability-adjacent
- not execution-sensitive by implementation
- not backend-authority by implementation

## Extraction Safety Finding

`AuditRuntimeMarker` can potentially move later as pure vocabulary, but should not be exported casually. It requires semantic guardrails before package exposure.

