# SIGNAL_GOVERNANCE_REGISTRY_V1

Status: ACTIVE_GOVERNANCE_REGISTRY
Phase: 8C
Operation: OP-PHASE-8C-MEMORY-ARCHIVE-SIGNAL-GOVERNANCE-V1
Runtime effect: none

## Purpose

Govern signal creation, ownership, routing, aggregation, visibility, retention, escalation, and memory use before new signal-producing features are added.

## Signal Governance Rules

| Rule | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A signal must have a domain owner before activation | Owner | All domains | Domain Ownership registries | all signals | signal collections | ACTIVE | Permanent | GOVERNANCE_RULE |
| Monitoring observes and aggregates unless Owner-approved intervention exists | Owner | Monitoring | Monitoring Authority Registry | monitoring, escalation | `signal_events`, `chat_escalations` | ACTIVE | Permanent | AUTHORITY_RULE |
| Cross-domain signals require boundary documentation | Owner | Residential, Commercial, Monitoring, Library | Domain Boundary Registry | support, chat, marketplace, escalation | multiple | ACTIVE | Permanent | BOUNDARY_RULE |
| Runtime signal emission must identify consumer and memory impact | Owner | Runtime surfaces, registries | Signal Ownership Registry | all emitted signals | signal collections | ACTIVE | Permanent | MEMORY_RULE |
| Aggregate signals require lifecycle and retention classification | Owner | Monitoring, Owner | Signal Aggregate Lifecycle Registry | aggregate signals | aggregate/read-model stores | RECOMMENDED | Pending registry | LIFECYCLE_RULE |
| Archive-relevant signals must create finding or archive recommendation memory | Owner | Governance | Finding Memory Registry, Archive Recommendation Registry | governance signals | governance docs | ACTIVE | Permanent | ARCHIVE_RULE |

## Signal Governance Areas

| Area | Source | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Residential signals | Phase 7A, Phase 8B | Residential Owner | Client, Personal Space, Monitoring | Residential Signal Ownership Registry | client, support, chat, saved destination | `clients`, `signal_events`, `support_requests`, `chat_threads` | ACTIVE | Runtime | DOMAIN_SIGNAL |
| Commercial signals | Phase 7B, Phase 8B | Commercial Owner | Discovery, marketplace, Monitoring | Commercial Signal Ownership Registry | provider, center, tool, discovery | `provider_contact_requests`, `center_contact_requests`, `tool_registry` | ACTIVE | Runtime | DOMAIN_SIGNAL |
| Administrative signals | Phase 7C, Phase 8A/8B | Administrative Owner | Registration, Declaration Review, Owner | Declaration Review Registry | registration, declaration readiness | `clinicians`, `centers` | ACTIVE | Runtime | AUTHORITY_SIGNAL |
| Library signals | Phase 7D, Phase 8B | Library Owner | Library, Monitoring, Owner | Library Content Registry | category, featured, recommendation | `signal_events`, content collections unknown | ACTIVE_WITH_UNKNOWN_CONTENT | Runtime/Future | KNOWLEDGE_SIGNAL |
| Monitoring signals | Phase 7E, Phase 8A | Monitoring Owner | Monitoring Room, Owner | Monitoring Authority Registry | escalation, aggregate, observability | `signal_events`, `chat_escalations`, `system_domains` | ACTIVE | Runtime | OBSERVABILITY_SIGNAL |
| Governance signals | Phase 7F, Phase 8A-8C | Owner | All domains | Operations, findings, archive, memory registries | owner decisions, operations, findings | governance docs | ACTIVE | Constitutional memory | GOVERNANCE_SIGNAL |

## Coverage

Signal governance coverage: 92%. Domain signal families are governed; aggregate lifecycle and future content/recommendation signals still require future dedicated registries before activation.

