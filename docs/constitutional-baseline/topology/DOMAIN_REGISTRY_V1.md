# DOMAIN_REGISTRY_V1

Status: ACTIVE_GOVERNANCE_REGISTRY
Phase: 4
Runtime effect: none

Purpose: Index all constitutional domains, owners, responsibilities, signal roles, isolation levels, and status.

| Domain | Owner | Responsibilities | Signal Sources | Signal Consumers | Isolation Level | Status |
| --- | --- | --- | --- | --- | --- | --- |
| Residential Domain | Client, Clinician, Center, Owner-supervised | Client Room, Provider Room, Center Room, Personal Space | Personal space events, library opens, support requests, chat activity | Role state, profile state, monitoring outcomes | MEDIUM | ACTIVE_WITH_NAMING_DRIFT |
| Commercial Domain | Owner-governed, future domain steward required | Tools, Discovery, Marketplace Layer, External Resources | Discovery intent, tool usage candidates, support pathway intent | Public profiles, safety policy, library policy | LOW_TO_MEDIUM | ACTIVE_WITH_BOUNDARY_RISK |
| Administrative Domain | Declaration Reviewer, Owner-supervised | Registrations, Declarations, Verification Flow | Registration submissions, profile change requests | Auth state, role gateway, review queues | MEDIUM | ACTIVE_ADMIN_ZERO_REQUIRED |
| Library Domain | Owner-governed, future knowledge steward required | Knowledge, Categories, Content, Collections | Library category opened signals | Auth context, policy state, recommendation candidates | MEDIUM_HIGH | ACTIVE_AFTER_C6_PURIFICATION |
| Monitoring Domain | Monitoring Operator, Support Observer, Owner | Monitoring Room, Signals, Escalations, Observability | Signal events, chat escalations, support requests | Domain health, safety context, account state | HIGH | ACTIVE_AUTHORITY_NEEDS_REGISTRY |
| Owner Domain | Owner | Owner Room, Capsules, Governance, Strategic Systems | Findings, reports, archive recommendations, memory gaps | Domain health, registries, operations log | HIGH | ACTIVE_CONSTITUTIONAL_CORE |
| Constitutional Governance Domain | Owner | Guides, Cards, Registries, Archives, Memory, Operations | All executed operations, findings, archive candidates | Owner decisions, runtime permissions, baseline snapshots | VERY_HIGH | ACTIVE_FOUNDATION |

## Registry Rules

- A domain cannot add runtime behavior without an operation record.
- A domain cannot introduce a new collection without a collection registry update.
- A domain cannot introduce a new authority role without Owner approval.
- A domain cannot delete legacy evidence without an archive card.
- A domain cannot activate a new signal without signal ownership.
