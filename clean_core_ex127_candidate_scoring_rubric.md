# EX-127 Candidate Scoring Rubric

## Scope

Docs/rubric only. This rubric is used after the EX-126 candidate intake
template is completed. It scores future proposals before any package contract,
barrel export, host mapper, consumer migration, passive vocabulary,
queue/boundary concept, runtime/provider diagnostic, Firebase/persistence
change, AI/safety label, or operational/admin surface change.

EX-127 does not approve implementation. It does not create contracts, mappers,
exports, imports, consumer reconnects, provider behavior, Firebase behavior,
or runtime activation.

## Score Scale

Each dimension receives a score from 0 to 4.

| Score | Meaning | Default Handling |
| --- | --- | --- |
| 0 | No meaningful risk; evidence is clear | May proceed to taxonomy review |
| 1 | Low risk; caveats or documentation needed | May remain docs-only/internal |
| 2 | Medium risk; needs narrowed scope or additional gate | Downgrade at least one category |
| 3 | High risk; likely requires doctrine review | Usually blocked or host-only |
| 4 | Critical risk or automatic blocker | Blocked |

Scores do not grant permission. They classify eligibility for a later
explicitly scoped wave.

## Scoring Dimensions

### 1. Semantic Risk

- 0: passive fact only; no operational reading
- 1: passive but needs caveat
- 2: partly ambiguous; requires rename or narrower scope
- 3: likely to imply authority, workflow, or proof
- 4: directly implies execution, enforcement, emergency handling, provider
  causality, retry, fallback recovery, or write authority

### 2. Authority/Fake Guarantee Risk

- 0: name cannot reasonably be read as a command, permission, or guarantee
- 1: low naming risk; caveat sufficient
- 2: name could be misread without strong caveats
- 3: name sounds authoritative or proof-like
- 4: name creates fake guarantee or operational promise

### 3. Runtime/Provider Proximity

- 0: unrelated to runtime/provider behavior
- 1: mentions reference metadata only
- 2: adjacent to provider/runtime labels but passive
- 3: implies provider trust, provider capability, runtime state, adapter
  execution, or backend availability
- 4: creates runtime/provider diagnostic contract, mapper, export, or consumer
  reconnect

### 4. Queue/Boundary Proximity

- 0: unrelated to queue or boundary concepts
- 1: reference-only or audit-only metadata
- 2: adjacent to queue/boundary vocabulary but caveated
- 3: implies routing, admission, reviewer/team ownership, boundary
  enforcement, or workflow state
- 4: exposes queue admission, `accepts` behavior, boundary enforcement, or
  emergency routing

### 5. Firebase/Persistence Proximity

- 0: no persistence concern
- 1: passive reference to host persistence only
- 2: host mapper may be needed but package remains clean
- 3: proposal risks coupling package surface to persistence behavior
- 4: introduces Firestore/Firebase/Timestamp/FieldValue behavior into package
  contracts or exports

### 6. Public API Risk

- 0: docs-only or internal-only
- 1: package-internal and unexported
- 2: export might be justified but needs separate gate
- 3: public API could be misunderstood or hard to remove
- 4: public API breaks compatibility, exposes holdbacks, or uses wildcard or
  directory export

### 7. Consumer Migration Risk

- 0: no consumer change
- 1: consumer change not needed for value
- 2: future migration possible but not required
- 3: proposal depends on consumer reconnect
- 4: reconnects consumers without explicit approval or activates runtime,
  provider, Firebase, or adapter behavior

### 8. Rollback Locality

- 0: rollback is docs-only or single-file local
- 1: rollback is limited and isolated
- 2: rollback spans package and host docs or internal files
- 3: rollback requires coordinated host/package/consumer changes
- 4: rollback is not local or requires runtime/provider/Firebase changes

### 9. Compatibility Preservation

- 0: no compatibility impact
- 1: compatible additive docs/internal addition
- 2: additive public candidate with compatibility caveats
- 3: likely public behavior or API compatibility risk
- 4: breaking change without explicit compatibility plan

### 10. Test/Verification Readiness

- 0: static verification is sufficient and specified
- 1: static checks plus targeted review specified
- 2: verification plan has gaps
- 3: requires tooling/runtime not approved by the wave
- 4: cannot be verified without activating blocked runtime/provider/Firebase
  behavior

## Total Risk Bands

| Total Score | Initial Classification |
| --- | --- |
| 0-4 | Low risk; taxonomy may classify as docs-only, internal-only, package-internal unexported, or narrowly export-eligible |
| 5-9 | Moderate risk; downgrade at least one level and require caveats/evidence |
| 10-16 | High risk; host-only, backend-only, docs-only, or blocked unless doctrine review reopens it |
| 17+ | Blocked by risk profile |

Automatic blockers override total score.

## Approval Thresholds

- `DOCS_ONLY`: no automatic blockers; total score may be any value if no code
  change is proposed.
- `INTERNAL_ONLY`: no score 4, total score 9 or lower, rollback local.
- `HOST_ONLY`: no package exposure; Firebase/persistence score may be 2-3 only
  if host ownership is explicit.
- `BACKEND_ONLY`: no package/client exposure; used when semantics require
  backend authority.
- `PACKAGE_INTERNAL_UNEXPORTED`: no score above 2, total score 8 or lower,
  rollback local, no consumers.
- `EXPORT_ELIGIBLE`: all dimensions 0-1 except public API risk may be 2; total
  score 6 or lower; explicit export gate still required.
- `MAPPER_ELIGIBLE`: host mapper only; Firebase/persistence score no higher
  than 2; package mapper score must be 0.
- `MIGRATION_ELIGIBLE`: target export already approved, consumer migration risk
  no higher than 2, rollback local, explicit migration gate still required.
- `BLOCKED`: any automatic blocker or total score 17+.

## Required Evidence Per Score

Each scored dimension must cite:

- EX-126 intake section
- exact candidate name and file scope
- risk rationale
- caveat or mitigation, if any
- rollback evidence
- compatibility evidence
- verification evidence

## Rubric Verdict

Pass. This rubric classifies risk and eligibility only. It does not authorize
implementation, export, mapper creation, migration, or runtime activation.
