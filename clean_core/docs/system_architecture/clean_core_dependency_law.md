# clean_core Dependency Law

## Core Rule

`mental_smile_clean_core` may define contracts. It must not own runtime integrations.

## Allowed Dependency Direction

Allowed:

- host app imports clean_core contracts
- backend/host implements adapters outside clean_core
- clean_core files import package-local pure Dart contracts
- public barrel exports reviewed stable contracts only

Blocked:

- clean_core importing host app runtime
- clean_core importing Firebase runtime
- clean_core importing Flutter UI
- clean_core importing provider SDKs
- clean_core importing networking clients
- clean_core importing generated files
- clean_core importing app routing/localization/assets

## Adapter Dependency Law

Adapters must be:

- contract-first
- implementation-free inside clean_core unless separately approved
- host/backend implemented
- fail-closed when unavailable
- deny-by-default when authority is missing

## Bridge Layer Law

Bridge layers must not:

- create privileged client authority
- activate runtime implicitly
- execute providers
- perform Firebase writes
- bypass backend governance
- silently fall back to unsafe behavior

## Hidden/Internal Contract Law

Hidden contracts remain package-local until reviewed:

- guards
- policies
- resolvers
- locks
- check APIs
- authority-like main objects

## Export Law

Exports must be:

- explicit
- file-by-file
- reviewed
- stable
- declarative

Exports must not be:

- wildcard
- directory-wide
- authority-expanding
- runtime-activating
- provider-enabling
