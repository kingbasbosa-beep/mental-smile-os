# EX-120 Guard/Fallback Holdback

## Guard Doctrine

Guard decisions are backend-owned because they determine whether runtime or
provider behavior is allowed, blocked, or fail-closed.

Backend-owned guard concepts:

- `blockReason`
- fail-closed decisions
- policy mismatch
- provider blocked
- runtime disabled
- backend governance required
- audit missing
- escalation required
- unsafe observation

## Fallback Doctrine

Fallback behavior is host/backend-owned. Public labels may never imply fallback
execution, recovery, or retry.

## Package-Blocked Fallback Semantics

- fallback route activated
- fallback response guaranteed
- fallback-only mode enforced
- retry scheduled
- recovery started
- recovery completed
- provider recovered
- backend recovered
- runtime recovered

## Metadata Boundary

Future diagnostic labels, if ever introduced, must remain reported/observed
metadata only and must not trigger behavior.

## Verdict

Guard and fallback semantics remain held back. No package file is justified.
