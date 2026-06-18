# FINDING_MEMORY_REGISTRY_V1

Status: ACTIVE_GOVERNANCE_REGISTRY
Phase: 8C
Operation: OP-PHASE-8C-MEMORY-ARCHIVE-SIGNAL-GOVERNANCE-V1
Runtime effect: none

## Purpose

Preserve findings as memory material, not bugs. Findings become constitutional inputs for cards, guides, registries, owner decisions, audits, and archive lineage.

## Finding Memory Entries

| Finding Group | Source | Severity Profile | Memory Meaning | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Residential signal ownership gap | `MS-RES-FINDING-001` | HIGH | Residential signals need clear owner before expansion | Owner | Residential, Monitoring | Residential Signal Ownership Registry | residential, support, chat | `clients`, `signal_events`, `support_requests`, `chat_threads` | ACTIVE_MEMORY | Open until registry hardened | GOVERNANCE_GAP |
| Residential localization and support duplication | `MS-RES-FINDING-002..004` | MEDIUM | Inline language and support pathways need boundary memory | Owner | Residential | localization registry, support boundary card | support signals | `support_requests` | ACTIVE_MEMORY | Open | BOUNDARY_MEMORY |
| Commercial tool and terminology gap | `MS-COM-FINDING-001..002` | HIGH/MEDIUM | Tool surfaces and provider/clinician language need governance | Owner | Commercial, Administrative | Tool registry, terminology map | tool, provider, clinician | `tool_registry`, `clinicians` | ACTIVE_MEMORY | Open | GOVERNANCE_GAP |
| Commercial discovery boundary | `MS-COM-FINDING-003..005` | MEDIUM/LOW | Discovery, support, marketplace, and assets need ownership clarity | Owner | Commercial, Residential | commercial ownership registries | discovery signals | `saved_destinations` | ACTIVE_MEMORY | Open | CROSS_DOMAIN_MEMORY |
| Administrative declaration authority | `MS-ADM-FINDING-001` | HIGH | Declaration observation must not become ungoverned mutation | Owner | Administrative, Owner | Declaration Review Registry | declaration readiness | `clinicians`, `centers` | ACTIVE_MEMORY | Open until approval policy exists | AUTHORITY_MEMORY |
| Administrative registration aliases | `MS-ADM-FINDING-002..005` | MEDIUM/LOW | Provider language and route aliases need lineage | Owner | Administrative | alias registry, declaration field registry | registration signals | `clinicians`, `centers` | ACTIVE_MEMORY | Open | ROUTE_LINEAGE_MEMORY |
| Library content ownership | `MS-LIB-FINDING-001` | HIGH | Content expansion requires content registry first | Owner | Library | Library Content Registry | knowledge signals | content collections unknown | ACTIVE_MEMORY | Open | CONTENT_GOVERNANCE_GAP |
| Library policy, route, recommendation, C6 lineage | `MS-LIB-FINDING-002..005` | MEDIUM/LOW | Library future systems and legacy lineage need memory | Owner | Library | policy, recommendation, route registries | library signals | unknown | ACTIVE_MEMORY | Open | KNOWLEDGE_MEMORY |
| Monitoring authority and escalation ownership | `MS-MON-FINDING-001..002` | HIGH | Monitoring must remain observability-governed | Owner | Monitoring, Residential | Monitoring Authority Registry, escalation ownership | monitoring, escalation | `signal_events`, `chat_escalations` | ACTIVE_MEMORY | Open | AUTHORITY_MEMORY |
| Monitoring aggregate lifecycle and Control-era residue | `MS-MON-FINDING-003..006` | MEDIUM/LOW | Aggregates, support observation, and language need boundaries | Owner | Monitoring, Owner | aggregate lifecycle, support observer, observability route registries | aggregate signals | `system_domains`, `support_requests` | ACTIVE_MEMORY | Open | OBSERVABILITY_MEMORY |
| Owner governance memory gaps | Phase 7F scorecard | HIGH/MEDIUM | Owner approval, runtime memory surfaces, and recommendations need registries | Owner | All domains | Phase 8A, 8B, 8C registries | governance signals | governance docs | ACTIVE_MEMORY | Closing through Phase 8C | GOVERNANCE_MEMORY |
| Client identity extraction and fresh signal doctrine | `FINDING-FRESH-SIGNALS-OVER-STORED-PREFERENCES-V1`, `FINDING-CLIENT-PROFILE-COMPLEXITY-V1` | HIGH/MEDIUM | Client identity simplification needs memory before runtime removal; fresh repeated intent signals should not be overwritten by stale saved preferences | Owner | Residential, Signals, Runtime | Client Identity Extraction Decision, Client Profile Complexity Archive Card | room, tool, mode, content signals | `clients`, `signal_events` | ACTIVE_MEMORY | Open until Owner-approved runtime extraction | SIGNAL_DOCTRINE_MEMORY |

## Coverage

Finding memory coverage: 100% of Phase 7A-7F finding groups are represented as memory entries.
