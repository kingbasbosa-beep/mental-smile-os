# Mental Smile Federated Constitutional Execution Plan

Date: 2026-05-28

Status: planning-only, freeze-preserving, non-runtime

## Executive Verdict

Mental Smile already contains a constitutional nucleus in `mental_smile_clean_core`
covering audit, governance kernel, federation, compliance, capability, lifecycle,
policy runtime, safety decision, trusted backend, trusted pipeline, human review,
and backend boundary contracts.

The current operational app still exposes a broad `admin` surface that mixes
observability, operational recovery, finance/accounting, growth, technical
support, content, maintenance, and gateway previews behind one admin route class.
This is acceptable only as frozen transitional debt. It must not become the
future authority model.

The next architectural move is not a rewrite. It is a governed separation plan:
define constitutional authority first, split owner-room and control-room
capabilities by registry, and progressively replace shared admin assumptions
with scoped claims, audit cases, and tenant-bound authority envelopes.

## Constitutional Alignment

The constitution is the source of authority. App screens, admin documents,
custom claims, and AI services are enforcement participants, not sovereign
authority.

Current alignment signals:

- Firestore rules explicitly state that authorization depends on custom claims,
  while app-side role documents are UI/UX gates only.
- `mental_smile_clean_core` exports passive/declarative models for audit,
  governance, federation, runtime policy, safety decisions, human review, and
  backend boundaries.
- Governance/federation defaults are sealed or disabled by default, which fits
  freeze-preserving constitutional growth.
- Several admin pages already describe themselves as advisory, preview, or
  governance surfaces rather than live automation engines.

Required constitutional doctrine:

- Identity must never imply authority.
- Every authority-bearing mutation must be tied to a policy, case, actor,
  reason, tenant scope, trace, and audit event.
- Admin observation must remain separate from owner-room authority.
- AI may recommend, summarize, and flag. It must not approve, deny, mutate, or
  silently govern.

## Governance Alignment

### Existing Governance Assets

Core package:

- `audit/*`: passive audit event, trace, reference, severity, visibility, and
  retention vocabulary.
- `governance/kernel/*`: constitutional kernel boundary and request vocabulary.
- `governance/federation/*`: federation state, scope, lock, requirement, audit,
  review, and disabled runtime markers.
- `governance/capability/*`: capability scope and requirement vocabulary.
- `governance/compliance/*`: compliance scope, profile, policy, and markers.
- `policy_runtime/*`: runtime policy pack/profile/scope/restriction vocabulary.
- `backend_boundaries/*`: protected fields, cloud-function boundaries, trusted
  operation contracts, AI governance boundary, and server-owned fields.
- `human_review/*`: escalation, review, passive signal, emergency posture, and
  visibility vocabulary.

App/runtime:

- `firestore.rules` separates custom-claim authority from app-side role docs.
- `AppRouter` has a single admin route bucket and separate client, clinician,
  and center route buckets.
- `AccountAccessService` resolves app-side identity from role documents and
  treats admins through `admins` documents.

Governance gap:

- The app has governance vocabulary, but not yet a full registry-enforced
  authority topology.
- `admin` is currently a shared operational identity, not a constitutionally
  separated authority family.

## Operational Isolation Status

Current state: transitional, partially isolated.

Strong boundaries:

- Tenant-facing routes exist for client, clinician, and center workflows.
- Firestore rules deny broad fallback access.
- Protected account fields restrict self-mutation by clients, clinicians, and
  centers.
- System health and alert snapshots are app-read/admin-visible but app-write
  denied.

Weak boundaries:

- Control Room, Owner Room, accounting, marketing, technical support, content,
  and engineering previews are all routed through admin-only access.
- Firestore has collections that allow admin read/write where future separation
  should distinguish observer, operator, owner, finance, governance, and
  deployment authority.
- Some admin flows can mutate operational records directly, making them
  transitional exceptions rather than final constitutional operations.

Required future isolation:

- Control Room: observe, triage, escalate, report.
- Owner Room: build, deploy, configure constitution, manage registries,
  sovereign finance/legal/infrastructure.
- Tenant Layer: operate independently inside scoped policy envelopes.
- Trusted Backend: execute authority-bearing transitions after case/audit
  validation.

## Tenant Sovereignty Status

Current tenant types:

- Client
- Clinician
- Center

Current sovereignty support:

- Each tenant type has its own route set.
- Firestore read/write checks include self-owned documents and ownership fields.
- Centers and clinicians have profile change request flows rather than direct
  broad mutation after approval.

Missing federation-grade sovereignty:

- No explicit tenant registry yet.
- No tenant-scoped capability registry yet.
- No tenant-bound audit ledger contract yet.
- No tenant policy pack resolution path yet.
- No constitutional distinction between tenant operations and platform
  operations in route authority.

Target tenant doctrine:

- A tenant may operate only through registered workflows.
- A workflow may mutate only tenant-scoped records unless an explicit
  constitutional exception exists.
- A platform actor may observe tenant state only through visibility scopes.
- A platform actor may intervene only through a case, reason, policy reference,
  audit trace, and trusted backend execution path.

## Architecture Plan

### Layer 1: Constitution Layer

Purpose:

- Defines authority, policy, registries, trust, audit, visibility, and allowed
  intervention patterns.

Technical shape:

- Keep `mental_smile_clean_core` as the constitutional vocabulary package.
- Add future registry documents/specs before runtime enforcement:
  - `constitutional_authority_registry`
  - `capability_registry`
  - `domain_registry`
  - `tenant_registry`
  - `policy_pack_registry`
  - `audit_event_registry`
  - `signal_command_registry`
  - `intervention_case_registry`

Rules:

- Constitution changes are owner-room acts, not control-room acts.
- No registry entry becomes executable until it has an audit model, rollback
  model, visibility scope, and blocked-state definition.

### Layer 2: Owner Room

Purpose:

- Development, infrastructure, AI systems, sovereign finance, sovereign legal,
  constitutional management, growth systems, platform evolution, and marketing
  governance.

Allowed authority:

- Create and update constitutional registries.
- Manage deployment/infrastructure outside operational control-room surfaces.
- Manage owner-level finance/legal/platform configuration.
- Approve new modules and federation expansions.

Denied authority:

- No silent tenant record mutation.
- No daily operational case handling unless acting through a recorded
  intervention case.
- No direct clinical continuation.

Technical boundary:

- Future role family should not be `admin`.
- Use scoped owner claims such as `owner.constitution`, `owner.infrastructure`,
  `owner.finance`, `owner.legal`, `owner.growth`, and `owner.ai_systems`.
- Owner-room UI should not live under final `/admin/*` semantics.

### Layer 3: Control Room

Purpose:

- Observability, governance supervision, escalation handling, complaints, audit
  visibility, tenant monitoring, continuity governance, and operational reports.

Allowed authority:

- Read scoped operational status.
- Create escalation/intervention cases.
- Attach reasons, notes, and evidence.
- Request trusted backend actions.
- View audit and continuity reports.

Denied authority:

- No sovereign finance ownership.
- No platform development/deployment authority.
- No marketing ownership.
- No legal ownership.
- No direct tenant operational ownership.
- No God-mode writes.

Technical boundary:

- Future role family should be `control_room.*`, not generic `admin`.
- Control-room write capability should mostly create cases, comments, and
  signals, not directly mutate tenant/system source records.
- Direct mutation in current admin pages must be classified as frozen debt and
  progressively wrapped behind case-driven backend commands.

### Layer 4: Tenant Layer

Purpose:

- Independent operation by client, clinician, center, and future tenant types.

Allowed authority:

- Self-owned workflows.
- Tenant-scoped operational updates.
- Tenant-scoped profile requests.
- Tenant-scoped financial/session/review records.

Denied authority:

- No cross-tenant visibility by default.
- No platform-owned registry mutation.
- No authority escalation through identity documents.

Technical boundary:

- Introduce tenant IDs and tenant scopes before multi-tenant federation grows.
- All future tenant data should include `tenantId`, `tenantType`,
  `authorityScope`, and `policyPackId` where applicable.

### Layer 5: Trusted Backend

Purpose:

- Execute constitutionally valid commands after policy, case, scope, and audit
  checks.

Allowed authority:

- Apply approved transitions.
- Stamp server-owned fields.
- Emit audit events.
- Enforce tenant and capability registry rules.

Denied authority:

- No hidden mutation.
- No untraced repair.
- No AI-only approval path.

Technical boundary:

- Client apps and control-room surfaces submit `CommandRequest` style records.
- Cloud Functions/Admin SDK validate and execute.
- Firestore rules keep direct client writes narrow.

## Registry-Aware Topology

Initial registry map:

| Registry | Owner | Runtime role | Freeze-safe first step |
| --- | --- | --- | --- |
| Constitutional Authority Registry | Owner Room | Defines authority scopes | Markdown/spec only |
| Capability Registry | Owner Room | Maps roles to allowed capabilities | Passive Dart/core vocabulary |
| Domain Registry | Owner Room | Maps modules/domains to ownership and visibility | Docs + static UI labels |
| Tenant Registry | Trusted Backend | Defines tenant identity/scope | Add design spec before data |
| Policy Pack Registry | Constitution Layer | Resolves policy by tenant/workflow/domain | Docs + core model proposal |
| Audit Event Registry | Constitution Layer | Normalizes required audit events | Extend docs before writes |
| Signal/Command Registry | Trusted Backend | Separates observation signals from mutation commands | Design command envelope |
| Intervention Case Registry | Control Room + Trusted Backend | Requires reason/trace before intervention | Replace direct admin writes later |

## Signal/Command Governance

Signal:

- Observable event or status.
- Can be created by app, backend, or control-room observation.
- Does not mutate source-of-truth records.

Command:

- Requested mutation.
- Must include actor, authority scope, tenant scope, reason, policy reference,
  case ID, trace ID, expected transition, and rollback posture.
- Must be executed only by trusted backend after validation.

Rule:

- Control Room may create signals and command requests.
- Trusted Backend executes commands.
- Owner Room defines which commands may exist.
- Constitution governs whether a command is allowed.

## Separation Readiness

Ready now:

- Keep current admin surface frozen as transitional.
- Document all admin routes by future room: control, owner, tenant-support,
  accounting, marketing, engineering, content.
- Introduce passive registry specs and route classification without changing
  behavior.
- Add tests that protect current custom-claim doctrine.

Ready after classification:

- Split admin route guards into scoped guard names while preserving existing
  `admin` compatibility.
- Mark direct mutation flows as `case_required` in design docs.
- Add backend command-envelope models.

Not ready:

- Removing admin routes.
- Rewriting Firestore collection layout.
- Migrating tenants to hard multi-tenant partitioning.
- Replacing current operational workflows with Cloud Function-only execution in
  one wave.

## Frozen Debt

Debt item 1: Shared admin authority

- Current `admin` role gates many unrelated surfaces.
- Risk: governance collapse through accumulated God-mode semantics.
- Freeze posture: do not broaden; classify and progressively split.

Debt item 2: Direct admin mutation paths

- Some control/admin pages can directly update operational records.
- Risk: intervention without full case/reason/trace semantics.
- Freeze posture: keep current flows stable, then wrap future changes in command
  requests.

Debt item 3: Owner-room concepts inside admin surface

- Marketing, technical support, engineering gateways, AI DevOps, accounting, and
  content workspaces currently live under admin routing.
- Risk: operational observers appear to own sovereign systems.
- Freeze posture: treat as preview/transitional, not final authority.

Debt item 4: Missing tenant registry

- Tenant identity currently comes from role-specific collections and ownership
  fields.
- Risk: federation expansion becomes ad hoc.
- Freeze posture: design registry first, migrate later.

Debt item 5: Audit vocabulary is passive

- Core has audit models but no full enforced audit ledger path across all
  interventions.
- Risk: silent or under-specified mutation.
- Freeze posture: mandate audit envelope for new authority-bearing work.

## Risks

High:

- Treating `admin` as final authority instead of a transitional compatibility
  role.
- Adding new write powers to Control Room.
- Letting owner-room systems remain operationally reachable from observer
  surfaces.

Medium:

- Tenant fields becoming inconsistent across collections before a tenant
  registry exists.
- AI features being framed as policy authority rather than recommendation.
- Reports using visibility language without matching Firestore/custom-claim
  enforcement.

Low:

- Passive documentation drift if registry specs are not linked to tests and
  route classification.

## Future-Safe Recommendations

1. Create a route authority classification ledger for every `/admin/*` route:
   `control_room_observe`, `control_room_case`, `owner_room`, `tenant_support`,
   `finance_sovereign`, `preview_only`, or `deprecate`.

2. Freeze the current `admin` claim as compatibility only. Do not add new powers
   to it without a scoped future authority label.

3. Introduce passive constitutional registry specs before data migration.

4. Define a standard intervention case envelope:
   `caseId`, `tenantId`, `actorId`, `actorAuthorityScope`, `reason`,
   `policyReference`, `traceId`, `requestedCommand`, `riskLevel`,
   `rollbackPosture`, `auditEventType`.

5. Separate Control Room writes from source-record writes. Control Room should
   create cases and command requests; trusted backend should mutate.

6. Add tenant sovereignty vocabulary before expanding federation:
   `tenantId`, `tenantType`, `tenantPolicyPackId`, `tenantCapabilitySet`,
   `tenantAuditScope`, `tenantDataBoundary`.

7. Require AI UI copy and service names to state recommendation/signal posture,
   never governance authority.

8. Keep operational stability by using three waves:
   - Wave A: classify and document boundaries.
   - Wave B: add passive registries and compatibility guards.
   - Wave C: move authority-bearing mutations to trusted backend commands.

## Immediate Next-Wave Checklist

No runtime changes:

- Produce admin route classification ledger.
- Produce Firestore collection authority matrix.
- Produce command/request envelope spec.
- Produce tenant registry passive spec.
- Produce owner-room/control-room migration map.

Runtime-compatible only:

- Add scoped guard aliases that still accept current `admin` during transition.
- Add tests proving custom claims remain the real Firestore authority.
- Add static comments/labels to owner-room preview pages so they cannot be
  mistaken for control-room powers.

Deferred:

- Cloud Function command execution.
- Tenant registry migration.
- Route relocation.
- New claims rollout.
- Multi-tenant physical partitioning.

## Report Matrix

| Required report area | Current status | Verdict |
| --- | --- | --- |
| Constitutional alignment | Strong vocabulary, passive enforcement | Aligned but not complete |
| Governance alignment | Core doctrine exists; admin surface too broad | Transitional |
| Operational isolation status | Role routes and rules exist; admin is over-broad | Partial |
| Tenant sovereignty status | Self-owned flows exist; no tenant registry | Partial |
| Risks | Shared admin, direct mutation, missing registry | Manage before expansion |
| Frozen debt | Admin compatibility, direct writes, passive audit | Accept only under freeze |
| Separation readiness | Ready for docs/classification/passive registries | Not ready for rewrite |
| Future-safe recommendations | Registry-first, case-first, command-backed | Proceed in waves |

## Final Doctrine

The platform must evolve from admin-managed operations into constitutionally
scoped federation.

The safe path is:

Constitution defines authority.
Owner Room manages evolution.
Control Room observes and escalates.
Tenants operate independently.
Trusted Backend executes governed commands.
Audit records every intervention.

