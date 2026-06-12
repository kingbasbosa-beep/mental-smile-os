# Master Card Guide V1

Status: GUIDE_DRAFT  
Runtime effect: none

## 1. Card Doctrine

Cards are governance-visible units that describe a visible UI object, workflow object, registry object, or compliance object. In the current runtime, most cards are private Flutter widgets and are not governed by a runtime card registry.

| Rule ID | Rule |
| --- | --- |
| CARD-R01 | A card is not authoritative unless it maps to a guide snapshot. |
| CARD-R02 | A runtime widget is not automatically an approved governance card. |
| CARD-R03 | A card must have owner, surface, consumer, source guide, source registry, and status. |
| CARD-R04 | Cards with no runtime owner are `APPROVAL_BLOCKED` until ownership is assigned in governance. |
| CARD-R05 | FUTURE cards must not be described as implemented. |

## 2. Card Object Schema

| Field | Required | Notes |
| --- | --- | --- |
| cardId | YES | Stable ID. |
| name | YES | Human-readable card name. |
| guideId | YES | Source guide. |
| snapshotId | YES | Source snapshot. |
| objectId | YES | Runtime or governance object represented. |
| owner | YES | Role or domain owner. |
| surface | YES | Residential, Commercial, Administrative, Owner, Monitoring, Shared, FUTURE. |
| registryRef | YES | Runtime registry or `MISSING_RUNTIME_REGISTRY`. |
| consumers | YES | Screens, reports, routes, or roles. |
| produces | YES | UI, signal, report, route, or governance state. |
| consumes | YES | Collection, signal, asset, route, policy, or static text. |
| status | YES | Card status model from Master Guide System. |
| classification | YES | ACTIVE, TRANSITIONAL, LEGACY, FROZEN, ORPHANED, UNKNOWN, FUTURE. |

## 3. Current Card Families

| Card family ID | Cards | Owner | Registry | Surface | Status | Classification |
| --- | --- | --- | --- | --- | --- | --- |
| card.family.menu | Menu module cards, role shortcut, library teaser cards | Shared navigation | MISSING_RUNTIME_CARD_REGISTRY | Shared/public | SYSTEM_SYNC_PENDING | ACTIVE |
| card.family.client_dashboard | Theme catalog, active tools, signal summary, saved summary, next steps, guidance cards | Client/residential | MISSING_RUNTIME_CARD_REGISTRY | Residential | SYSTEM_SYNC_PENDING | ACTIVE |
| card.family.personal_space | Overview, signal summary, health, district, placeholder district, signal board lane cards | Client/residential | MISSING_RUNTIME_CARD_REGISTRY | Residential | SYSTEM_SYNC_PENDING | ACTIVE |
| card.family.signal_board | Signal Notes, Safety Notices, Recommendations, Resource Updates | Signal governance/client | MISSING_RUNTIME_CARD_REGISTRY | Residential/monitoring | SYSTEM_SYNC_PENDING | ACTIVE |
| card.family.support | Support path cards, addiction cards, support request cards | Support observer/residential support | MISSING_RUNTIME_CARD_REGISTRY | Support | SYSTEM_SYNC_PENDING | ACTIVE |
| card.family.declaration_review | Declaration record cards, summary cards | Declaration reviewer | MISSING_RUNTIME_CARD_REGISTRY | Administrative | SYSTEM_SYNC_PENDING | ACTIVE |
| card.family.registry_room | Registry domain cards | Registry steward/owner | DomainRegistry exists, card registry missing | Administrative | SYSTEM_SYNC_PENDING | ACTIVE |
| card.family.monitoring | Capital cards, signal monitoring control/section cards | Monitoring operator | Monitoring registries exist, card registry missing | Monitoring | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| card.family.owner | Owner overview, district, capsule cards | Owner | Owner capsule runtime registry deleted | Owner | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| card.family.city | City overview/district cards and generic web surface cards | Public/commercial | MISSING_RUNTIME_CARD_REGISTRY | Public/commercial | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| card.family.library | Featured heart cards, carousel cards, policy cards | Content/residential | MISSING_RUNTIME_CARD_REGISTRY | Residential/public | SYSTEM_SYNC_PENDING | ACTIVE |
| card.family.registration | Client signal option cards, provider signal option cards, center step/form cards | Declaration/residential/commercial | Missing option/card registries | Registration | SYSTEM_SYNC_PENDING | ACTIVE |
| card.family.asset_docs | Asset card docs under `docs/registry/assets` | Asset governance | Documentation registry only | Governance | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| card.family.language_docs | Term cards and language docs | Legal & Governance | Documentation registry only | Governance | SYSTEM_SYNC_PENDING | TRANSITIONAL |

## 4. Card To Signal/Tool/Surface Map

| Card family | Signal/tool/surface | Consumer | Report | Action |
| --- | --- | --- | --- | --- |
| client_dashboard | clientSignals, enabledToolKeys, saved_destinations | Client dashboard | snapshot/card pack | validate ownership and language |
| personal_space | signal_events, clients | Personal space | signal compliance report | verify signal board copy |
| signal_board | SignalPackage stream | Client | monitoring report | check signal/event mismatch |
| registration | declarationSignals, providerSignals, center readiness | Firestore docs, declaration review | declaration readiness report | verify required signals |
| support | support_requests, chat routes | support room/chat | support monitoring report | verify no case/assignment language |
| monitoring | signal_events, signal_aggregates FUTURE | monitoring operator | monitoring verification report | mark data feed gaps |
| owner | owner routes and capsules | owner | owner governance report | mark capsule registry gap |
| library | library categories and assets | client/public | language/asset reports | validate content ownership |

## 5. Approval Rules

| Approval check | Pass condition |
| --- | --- |
| Snapshot sync | `snapshotId` matches current guide snapshot. |
| Runtime sync | Card object exists or is marked FUTURE/FROZEN honestly. |
| Registry sync | Runtime registry exists, or gap is marked. |
| Owner sync | Owner is explicit. |
| Language sync | Surface language policy passes. |
| Status sync | Old card suspended before new card approval. |

