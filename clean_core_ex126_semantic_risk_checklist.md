# EX-126 Semantic Risk Checklist

## Scope

Docs/template only. This checklist must be completed before any future package
contract, export, mapper, consumer migration, passive vocabulary,
queue/boundary concept, runtime/provider diagnostic, or operational/admin
surface is proposed.

## Required Answers

Use `yes`, `no`, or `not applicable`, then add evidence.

| Question | Answer | Evidence |
| --- | --- | --- |
| Is it passive? |  |  |
| Is it pure Dart? |  |  |
| Does the name imply authority? |  |  |
| Does it imply execution? |  |  |
| Does it imply routing/admission? |  |  |
| Does it imply backend enforcement? |  |  |
| Does it imply emergency handling? |  |  |
| Does it imply provider causality? |  |  |
| Does it imply retry/fallback recovery? |  |  |
| Does it imply telemetry/privacy proof? |  |  |
| Does it imply audit verification proof? |  |  |
| Does it imply policy compliance proof? |  |  |
| Does it imply moderation/safety ownership? |  |  |
| Does it imply operational/admin authority? |  |  |
| Does it require mapper ownership? |  |  |
| Is rollback local? |  |  |
| Is compatibility preserved? |  |  |
| Is public export justified? |  |  |
| Is consumer migration explicitly approved? |  |  |

## Candidate Type Risk Notes

### Package Contract

Must be passive, pure Dart, mapper-free, rollback-local, and compatible. The
name must not imply authority or execution.

### Barrel Export

Must already have a safe contract. Export must be explicit file-only and must
not expose internal holdbacks, mappers, or Firebase behavior.

### Host Mapper

Must remain host-owned. It may use Firebase APIs only outside
`mental_smile_clean_core` and must not imply backend proof or package
execution.

### Consumer Migration

Requires explicit migration approval. Consumer adoption must not be used as
evidence that the package surface is safe.

### Passive Vocabulary

Must be narrow, caveated, non-operational, and rollback-local before export.

### Queue/Boundary Concept

Blocked by default. Must not imply queue admission, routing, reviewer/team
ownership, boundary enforcement, emergency handling, backend enforcement, or
write authority.

### Runtime/Provider Diagnostic

Blocked by default. Must not imply provider causality, provider trust, adapter
execution, runtime execution, fallback recovery, backend availability,
telemetry/privacy proof, or enforcement proof.

### Operational/Admin Surface

Blocked from package exposure by default. Must not imply permissions, admin
authority, staff ownership, routing authority, backend writes, enforcement, or
runtime/provider operation.

## Stop Conditions

Stop if:

- any high-risk implication is answered `yes`
- passivity or pure Dart cannot be proven for package exposure
- rollback is not local
- compatibility is not preserved
- public export is wanted but not justified
- consumer migration is needed but not explicitly approved

## Checklist Verdict

Candidate semantic risk verdict:

- `Pass`
- `Blocked`
- `Needs doctrine review`
- `Needs rename`
- `Needs caveats`
- `Needs rollback/compatibility plan`
