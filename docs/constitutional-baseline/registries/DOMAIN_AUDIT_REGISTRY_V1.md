# DOMAIN_AUDIT_REGISTRY_V1

Status: ACTIVE_GOVERNANCE_REGISTRY
Phase: 8C
Operation: OP-PHASE-8C-MEMORY-ARCHIVE-SIGNAL-GOVERNANCE-V1
Runtime effect: none

## Purpose

Index completed domain audits as constitutional memory sources. This registry answers which domain audit produced which reports, findings, recommendations, and downstream governance needs.

## Domain Audit Entries

| Audit | Phase | Domain | Reports | Findings | Recommended Cards | Registry Needs | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Residential Deep Audit | 7A | Residential | 8 | 5 | 3 | Signal, route, collection, localization | Owner | Residential, Monitoring | runtime code inspection, inventory | residential, support, chat | `clients`, `saved_destinations`, `support_requests`, `chat_threads`, `signal_events` | COMPLETED | Baseline audit | ACTIVE_MEMORY |
| Commercial Deep Audit | 7B | Commercial | 7 | 5 | 3 | route, collection, signal, tool status, terminology | Owner | Commercial, Administrative | runtime code inspection, inventory | provider, center, tool, marketplace | `clinicians`, `centers`, `provider_contact_requests`, `center_contact_requests`, `tool_registry` | COMPLETED | Baseline audit | ACTIVE_MEMORY |
| Administrative Deep Audit | 7C | Administrative | 6 | 5 | 3 | declaration review, route, collection, alias, fields | Owner | Administrative, Owner | registration and declaration routes | registration, declaration readiness | `clinicians`, `centers`, profile change requests | COMPLETED | Baseline audit | ACTIVE_MEMORY |
| Library Deep Audit | 7D | Library | 5 | 5 | 3 | content, route, knowledge signal, policy, recommendation | Owner | Library, Owner | library routes/assets/content structure | knowledge/category signals | content collections unknown | COMPLETED | Baseline audit | ACTIVE_MEMORY |
| Monitoring Deep Audit | 7E | Monitoring | 4 | 6 | 3 | authority, escalation, aggregate lifecycle, observability routes | Owner | Monitoring, Residential, Owner | signal models and monitoring routes | monitoring, escalation, aggregate | `signal_events`, `support_requests`, `chat_escalations`, `system_domains` | COMPLETED | Baseline audit | ACTIVE_MEMORY |
| Owner Governance Deep Audit | 7F | Owner/Governance | 6 | 4 critical findings | 3 | archive recommendation, domain audit, runtime memory, governance decision | Owner | All domains | baseline governance docs | governance memory signals | operations and governance docs | COMPLETED | Baseline audit | ACTIVE_MEMORY |

## Current Audit Memory Flow

Finding -> Audit Report -> Scorecard -> Recommendation -> Registry -> Owner Decision -> Card/Guide/Runtime Change -> Archive -> Memory

## Coverage

Domain audit registry coverage: 100% of Phase 7A-7F deep audits are indexed.

