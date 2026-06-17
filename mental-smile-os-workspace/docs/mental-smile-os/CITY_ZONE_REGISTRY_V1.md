# City Zone Registry V1

Status: ACTIVE_CITY_ZONE_REGISTRY
City: Mental Smile City
Prompt Asset: PROMPT_ASSET_019
Latest Gateway Prompt: PROMPT_ASSET_031
Latest Federation Authority Prompt: PROMPT_ASSET_033
Latest Library Zone Prompt: PROMPT_ASSET_035
Latest Library District Constitution Prompt: PROMPT_ASSET_036
Latest Library Zone Closure Prompt: PROMPT_ASSET_039
Latest Provider Federation Split Prompt: PROMPT_ASSET_040
Latest Center Federation Split Prompt: PROMPT_ASSET_042
Latest Commercial Web Closure Prompt: PROMPT_ASSET_043
Latest Governance Federation Prompt: PROMPT_ASSET_044
Latest City Generation 1 Snapshot Prompt: PROMPT_ASSET_045
Latest Active Workspace Declaration Prompt: PROMPT_ASSET_049

## Zones

| Zone ID | Zone Name | Purpose | Surface Relationship | Primary Gateway | Status |
| --- | --- | --- | --- | --- | --- |
| APP_ROOM_ZONE | App Room Zone | Primary app room experience and App Surface screen flow. | App Surface | APP_ROOM_ZONE_GATEWAY | REGISTERED |
| LIBRARY_WEB_ZONE | Library and Tools Web Zone | Knowledge, education, discovery, research, tools, references, guides, resources, learning, accessibility, recovery, family, and professional knowledge. | Library Web Surface | LIBRARY_WEB_ZONE_GATEWAY | READY |
| PROVIDER_WEB_ZONE | Provider Public Profiles Zone | Legacy placeholder superseded by Provider Registration/Public split. | Public Profiles Web Surface | SUPERSEDED_BY_PROVIDER_SPLIT | SUPERSEDED |
| PROVIDER_REGISTRATION_WEB_ZONE | Provider Registration Web Zone | Provider onboarding, registration, credential submission, document collection, profile draft creation, review preparation, and status tracking. | Provider Registration Web Surface | PROVIDER_REGISTRATION_WEB_ZONE_GATEWAY | READY |
| PROVIDER_PUBLIC_WEB_ZONE | Provider Public Web Zone | Provider discovery, public profiles, service visibility, contact pathways, and trust display. | Provider Public Web Surface | PROVIDER_PUBLIC_WEB_ZONE_GATEWAY | READY |
| CENTER_WEB_ZONE | Center Public Profiles Zone | Legacy placeholder superseded by Center Registration/Public split. | Public Profiles Web Surface | SUPERSEDED_BY_CENTER_SPLIT | SUPERSEDED |
| CENTER_REGISTRATION_WEB_ZONE | Center Registration Web Zone | Center onboarding, registration, document submission, service declaration, partnership requests, contract preparation, profile draft creation, and status tracking. | Center Registration Web Surface | CENTER_REGISTRATION_WEB_ZONE_GATEWAY | READY |
| CENTER_PUBLIC_WEB_ZONE | Center Public Web Zone | Center discovery, public profile, service visibility, trust visibility, contact pathways, and public resources. | Center Public Web Surface | CENTER_PUBLIC_WEB_ZONE_GATEWAY | READY |
| ADMIN_OWNER_ZONE | Owner, Admin, Strategic Planning, Construction Studio | Owner OS and governance/planning/construction workspace. | Admin Owner Web Surface | ADMIN_OWNER_ZONE_GATEWAY | REGISTERED |
| OWNER_ZONE | Owner Zone | Constitution ownership, federation evolution, legal authority, strategic approval, infrastructure direction, AI Labs direction, emergency authority. | Governance Federation Layer | OWNER_ZONE_GATEWAY | DEFINED |
| MONITORING_ZONE | Monitoring Zone | Observability, signal monitoring, gateway monitoring, continuity monitoring, health monitoring, escalation visibility. | Governance Federation Layer | MONITORING_ZONE_GATEWAY | DEFINED |
| STRATEGIC_INTELLIGENCE_ZONE | Strategic Intelligence Zone | Federation analysis, trend analysis, signal summaries, growth analysis, strategic reports, AI analytical reports. | Governance Federation Layer | STRATEGIC_INTELLIGENCE_ZONE_GATEWAY | DEFINED |
| SMART_ARCHIVE_ZONE | Smart Archive Zone | Archive, snapshots, clone packages, historical cards, historical reports, recovery assets, continuity assets. | Governance Federation Layer | SMART_ARCHIVE_ZONE_GATEWAY | DEFINED |

## Rule

Home may link to APP_ROOM_ZONE, LIBRARY_WEB_ZONE, PROVIDER_WEB_ZONE, and CENTER_WEB_ZONE only.

Home may not link to ADMIN_OWNER_ZONE or SMART_ARCHIVE_ZONE.

## Gateway Rule

Each zone has exactly one primary signal gateway.

Internal components may communicate with their local gateway only. Cross-zone transfer must use Signal Pipe governance.

## App Room Gateway Status

APP_ROOM_ZONE_GATEWAY is the foundational cloneable gateway package for Mental Smile OS.

Status: FOUNDATIONAL.

Cloneable: YES.

District Constitution: LIBRARY_DISTRICT_CONSTITUTION_V1.

Zone Signal: ZONE_SIGNAL_001 ZONE_READY.

## Federation Sovereignty Rule

Each zone owns its internal runtime, signals, reports, cards, registries, and memory.

Other zones may not mutate these assets directly.

Zone Failure does not equal Federation Failure.

## Library Web Zone Status

LIBRARY_WEB_ZONE is the first independent Web Zone.

Classification: WEB_ZONE.

Independent: YES.

Cloneable: YES.

## Provider Web Federation Split

Provider registration and provider public presentation are separate zones.

PROVIDER_REGISTRATION_WEB_ZONE owns onboarding and registration records.

PROVIDER_PUBLIC_WEB_ZONE owns approved public profile presentation.

The mixed PROVIDER_WEB_ZONE placeholder is superseded and must not be used as one combined operational zone.

## Center Web Federation Split

Center registration and center public presentation are separate zones.

CENTER_REGISTRATION_WEB_ZONE owns onboarding, documents, service declaration, partnership, contract preparation, drafts, and status tracking.

CENTER_PUBLIC_WEB_ZONE owns approved public profile, service visibility, trust visibility, contact pathways, and public resources.

The mixed CENTER_WEB_ZONE placeholder is superseded and must not be used as one combined operational zone.

## Commercial Web Zones Closure

Provider Registration, Provider Public, Center Registration, and Center Public zones are READY.

ZONE_SIGNAL_001 ZONE_READY emitted for the commercial web layer.

## Governance Federation Layer

Governance Federation Layer is defined with OWNER_ZONE, MONITORING_ZONE, STRATEGIC_INTELLIGENCE_ZONE, and SMART_ARCHIVE_ZONE.

Governance observes, audits, archives, strategizes, and protects continuity and constitutional evolution.

Governance does not operate the platform.

## Mental Smile City Generation 1 Snapshot

MENTAL_SMILE_CITY_SNAPSHOT_V1 captures Generation 1 city structure, zones, gateways, pipes, authority, clone packages, recreation prompts, pure Firebase rules doctrine, pure YAML doctrine, and the City purity ruleset.

CITY_SIGNAL_001 CITY_GENERATION_1_SNAPSHOT_CREATED emitted.

Snapshot Status: CREATED.

## Active Workspace Declaration

ACTIVE_CITY: Mental Smile OS.

ACTIVE_GENERATION: GENERATION_1.

ACTIVE_CITY_SNAPSHOT: MENTAL_SMILE_CITY_SNAPSHOT_V1.

ACTIVE_CLONE_PACKAGE: MENTAL_SMILE_CITY_CLONE_PACKAGE_V1.

ACTIVE_REBIRTH_PROMPT: MENTAL_SMILE_CITY_REBIRTH_PROMPT_V1.

ACTIVE_DOCUMENTATION_ROOT: mental-smile-os-workspace.

CITY_SIGNAL_003 ACTIVE_WORKSPACE_DECLARED emitted.

CITY_SIGNAL_004 GENERATION_1_CONSTITUTIONAL_FREEZE_CERTIFIED emitted.
