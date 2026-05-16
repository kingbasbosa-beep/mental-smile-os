# clean_core Runtime Marker Semantic Review

Phase: EX-32 - Runtime Marker Isolation Review

## Core Semantic Question

The key review question is whether runtime and boundary markers are simple labels or whether they imply execution authority.

Current finding: most runtime markers are declarative labels. The risk is semantic misuse, not observed runtime execution.

## Runtime Marker Semantics

Runtime marker files commonly express:

- disabled runtime mode
- empty provider identifier
- environment label
- backend-governed flag
- fallback-only or inactive marker defaults

These are label/value objects and do not execute provider calls, Firebase calls, networking, orchestration, or runtime transitions.

## Runtime State Semantics

Runtime state vocabulary files define state labels such as:

- disabled
- blocked
- pending review
- fallback only
- active-like vocabulary
- released/rollback-ready labels

These labels do not activate runtime systems by themselves. However, any state vocabulary that includes active or enabled labels must not be treated as authorization to execute.

## Boundary Marker Semantics

Boundary markers can imply authority if used carelessly. For example, escalation boundary markers may include:

- backend governance expectations
- client outcome write restrictions
- emergency guarantee flags

These must remain declarative. They must not become client-side authority, emergency override authority, escalation execution, or moderation outcome authority.

## Observability Semantics

Observability contracts are more sensitive because they include vocabulary such as:

- observability active
- telemetry runtime active
- observation owner
- sanitized observation
- signed authority placeholder
- audit/reference requirements

These terms are contract labels only. They do not implement telemetry, analytics, tracing, export, or monitoring runtime.

## Guard and Policy Semantics

Observability guard and policy files include evaluation-style semantics, such as block-reason selection and fail-closed policy checks.

These are not runtime execution, but they are authority-sensitive. They must remain hidden/internal until a later semantic approval phase determines whether they can be exported safely.

## Semantic Verdict

Runtime markers are generally label-only and non-executing. Boundary markers and observability guard/policy/profile surfaces are semantically sensitive and must remain isolated from public export until future authority review.

