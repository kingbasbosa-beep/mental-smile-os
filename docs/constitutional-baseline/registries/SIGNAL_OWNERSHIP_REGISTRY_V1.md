# SIGNAL_OWNERSHIP_REGISTRY_V1

Status: ACTIVE_GOVERNANCE_REGISTRY
Phase: 8C
Operation: OP-PHASE-8C-MEMORY-ARCHIVE-SIGNAL-GOVERNANCE-V1
Runtime effect: none

## Purpose

Provide a cross-domain ownership view for signal families. Domain-specific ownership registries remain the detailed source; this registry is the constitutional signal map.

## Signal Ownership Entries

| Signal Family | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Client profile and goal signals | Residential | Client Room, Personal Space, Monitoring | Residential ownership registry | client goals, interests, accessibility | `clients`, `signal_events` | ACTIVE | Runtime | RESIDENTIAL_SIGNAL |
| Saved destination signals | Residential | Personal Space, Discovery, Monitoring | Residential collection ownership | saved destination | `saved_destinations`, `signal_events` | ACTIVE | Runtime | RESIDENTIAL_SIGNAL |
| Support request signals | Residential with Monitoring observation | Support Room, Monitoring | Support boundary governance | support issue, risk support | `support_requests` | ACTIVE_CROSS_DOMAIN | Runtime | CROSS_DOMAIN_SIGNAL |
| Chat escalation signals | Residential with Monitoring observation | Chat, Monitoring, Owner | Escalation ownership registry recommended | chat escalation, report, resolution | `chat_threads`, `chat_escalations` | ACTIVE_CROSS_DOMAIN | Runtime | CROSS_DOMAIN_SIGNAL |
| Provider/clinician contact signals | Commercial | Specialists, Discovery, Administrative | Commercial ownership registry, terminology map | provider contact, clinician interest | `provider_contact_requests`, `clinicians` | ACTIVE_WITH_TERMINOLOGY_RISK | Runtime | COMMERCIAL_SIGNAL |
| Center contact signals | Commercial | Centers, Discovery, Monitoring | Commercial ownership registry | center contact, center discovery | `center_contact_requests`, `centers` | ACTIVE | Runtime | COMMERCIAL_SIGNAL |
| Tool and marketplace signals | Commercial | Tools, Marketplace, Owner | Tool registry decision | tool usage, marketplace intent | `tool_registry` | UNKNOWN_ACTIVE_SURFACE | Future/runtime | COMMERCIAL_SIGNAL |
| Registration declaration signals | Administrative | Registration, Declaration Review, Owner | Declaration Review Registry | declaration readiness, profile change | `clinicians`, `centers`, profile change requests | ACTIVE | Runtime | ADMINISTRATIVE_SIGNAL |
| Library category signals | Library | Library, Monitoring, Owner | Library Content Registry | category opened, featured opened | `signal_events` | ACTIVE | Runtime | LIBRARY_SIGNAL |
| Library recommendation signals | Library | Library, Owner | Library Recommendation Registry recommended | recommendation future signals | unknown | FUTURE_REQUIRES_APPROVAL | Future | LIBRARY_SIGNAL |
| Monitoring aggregate signals | Monitoring | Monitoring Room, Owner | Monitoring Authority Registry, aggregate lifecycle registry | aggregate, status, observability | `signal_events`, `system_domains` | ACTIVE_WITH_LIFECYCLE_GAP | Runtime | MONITORING_SIGNAL |
| Governance memory signals | Owner | Operations, Archive, Memory, Registries | Executed Operations Registry, Finding Memory Registry | operation, finding, owner decision | governance docs | ACTIVE | Constitutional memory | GOVERNANCE_SIGNAL |

## Phase 9 Accessibility Signal Entries

| Signal Family | Owner | Consumers | Dependencies | Signals | Collections | Status | Lifecycle | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Accessible communication contact signals | Accessibility / Commercial | Provider pages, Center pages, Monitoring | Accessibility Gateway cards, Commercial signal ownership registry | accessible_contact_requested, accessible_contact_completed, accessible_provider_selected, accessible_center_selected | `signal_events`, `provider_contact_requests`, `center_contact_requests` | ACTIVE_PENDING_OWNER_MANUAL_VERIFICATION | Runtime | ACCESSIBILITY_COMMERCIAL_SIGNAL |

## Coverage

Signal ownership coverage: 90%. Known runtime signal families have owners; unknown/future tool, recommendation, and aggregate lifecycle areas require Owner decisions before expansion.
