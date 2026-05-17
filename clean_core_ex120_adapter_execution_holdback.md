# EX-120 Adapter Execution Holdback

## Doctrine

Adapter invocation is an execution boundary and remains backend/runtime-host
owned.

## Backend-Owned Responsibilities

- instantiate provider adapter
- invoke completion
- handle provider response
- handle blocked result
- validate output
- bind audit/policy context
- enforce backend governance

## Package-Blocked Semantics

- adapter execution proof
- AI completion guarantee
- provider response guarantee
- validated output guarantee
- client-side provider invocation
- provider execution permission
- runtime execution success

## Public Surface Rule

No public passive label may imply that adapter execution occurred, will occur, or
is safe.

## Verdict

Adapter execution remains fully held back from package contracts, mappers, and
exports.
