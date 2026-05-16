# EX-57 Runtime Context Naming Review

Phase: EX-57 - Package-Safe Runtime Context Design

## Scope

This document designs a future package-safe replacement/context type for the current host-side `AuditRuntimeMarker`.

No source files were created, no source files were modified, no imports were changed, no exports were changed, no dependencies were added, and no runtime systems were activated.

## Current Name

Current host-side type:

- `AuditRuntimeMarker`

Risk:

- the word `Runtime` can imply runtime lifecycle ownership
- the word `Marker` is acceptable, but not enough to prevent authority confusion

## Naming Options

### `AuditRuntimeContext`

Pros:

- clear that this is context, not execution
- maps well to audit event usage

Cons:

- still includes `Runtime`

### `AuditExecutionContext`

Pros:

- describes execution context

Cons:

- too likely to imply execution occurred
- not recommended

### `AuditProviderContext`

Pros:

- provider-focused

Cons:

- too narrow
- may imply provider lifecycle ownership

### `AuditRuntimeLabel`

Pros:

- emphasizes label-only semantics

Cons:

- less natural as a grouped event field

### `AuditProcessingContext`

Pros:

- softer than runtime/execution
- implies audit processing metadata rather than runtime authority

Cons:

- may be broader than current fields

## Naming Recommendation

Recommended future name:

- `AuditProcessingContext`

Acceptable fallback:

- `AuditRuntimeContext`, only with strong label-only documentation.

