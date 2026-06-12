# S CARD REGISTRY V1

## Constitutional Rule

Only cards carrying `tag: [S]` belong to the constitutional system.

Previous runtime does not become constitutional by receiving a new name. A
contaminated historical surface may appear only as an `ARCHIVE_CARD`, with its
previous boundary stated explicitly.

Every card starts without fingerprints. Fingerprints are added by a future
Signal Magnet mapping wave.

## Card Schema

- cardId
- tag
- cardType
- name
- purpose
- path/route if exists
- status
- audience
- magnetReady
- fingerprintIds
- linkedSignals
- linkedResources
- doNot
- notes
- next

---

## System Cards

### S-CARD-SYSTEM-001

- cardId: S-CARD-SYSTEM-001
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: S Surface Index
- purpose: Canonical index for the City, Capital, Owner, and Personal Space surfaces.
- path/route if exists: `lib/features/s_web_surfaces/presentation/pages/s_web_surface_pages.dart` / `/s`
- status: ACTIVE
- audience: Public and signed-in users
- magnetReady: no
- fingerprintIds: []
- linkedSignals: []
- linkedResources: []
- doNot: Do not expose previous runtime routes as constitutional surfaces.
- notes: None.
- next: Link only registered S system cards.

### S-CARD-SYSTEM-002

- cardId: S-CARD-SYSTEM-002
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Personal Space
- purpose: Client-owned room for identity direction, signals, privacy, preferences, tools, and saved destinations.
- path/route if exists: `lib/features/s_personal_space/presentation/pages/s_personal_space_page.dart` / `/s/personal-space`
- status: ACTIVE
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client goals, interests, accessibility, communication]
- linkedResources: [saved providers, saved centers, saved library items, tools]
- doNot: Keep the room centered on identity, preferences, tools, resources, and voluntary self-discovery.
- notes: Replaces record-first personal room concepts.
- next: Split room sections into linked constitutional cards.

### S-CARD-SYSTEM-003

- cardId: S-CARD-SYSTEM-003
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Support Room
- purpose: Read-only observation of support signals and technical or continuity requests.
- path/route if exists: `lib/features/s_support_room/presentation/pages/s_support_room_page.dart` / `/s/support-room`
- status: ACTIVE
- audience: Owner and support_observer
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [support signals, risk signals]
- linkedResources: [technical guidance, continuity guidance]
- doNot: Keep the room observational, guidance-oriented, and separate from personal journey control.
- notes: Clean replacement for a removed runtime surface.
- next: Add signal fingerprints to read-only request categories.

### S-CARD-SYSTEM-004

- cardId: S-CARD-SYSTEM-004
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Registry Room
- purpose: Read-only visibility into constitutional registries and domain status.
- path/route if exists: `lib/features/s_registry_room/presentation/pages/s_registry_room_page.dart` / `/s/registry-room`
- status: ACTIVE
- audience: Owner and registry_steward
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [domain health, degraded capability]
- linkedResources: [domain registry, capability registry, policy registry, signal registry, tool registry]
- doNot: Keep registry visibility observational and separate from mutation authority.
- notes: Registry-steward writes in Firestore rules remain outside this card boundary.
- next: Make all displayed registry sources observational.

### S-CARD-SYSTEM-005

- cardId: S-CARD-SYSTEM-005
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Readiness Observatory
- purpose: Observe clinician and center declarations, missing signals, completed signals, and visibility readiness.
- path/route if exists: `lib/features/s_declaration_review_room/presentation/pages/s_declaration_review_room_page.dart` / `/s/declaration-review-room`
- status: ACTIVE
- audience: Owner and declaration_reviewer
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [visibility readiness, missing signals, completed signals, document signals]
- linkedResources: [read-only declaration documents]
- doNot: Keep the room read-only and centered on readiness, completeness, documents, and visibility signals.
- notes: Transition display still reads older visibility fields when readiness data is missing.
- next: Remove transition display after readiness backfill.

### S-CARD-SYSTEM-006

- cardId: S-CARD-SYSTEM-006
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: City Center
- purpose: Public discovery surface for providers, centers, knowledge, tools, organizations, programs, and marketplace concepts.
- path/route if exists: `lib/features/s_city/presentation/pages/s_city_district_page.dart` / `/s/city`
- status: FOUNDATION
- audience: Public
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [interest, destination, capability, ecosystem]
- linkedResources: [providers, centers, content, tools]
- doNot: Keep discovery voluntary and separate from transaction or lifecycle control.
- notes: Several district routes remain placeholder views.
- next: Connect each district to registered cards only.

### S-CARD-SYSTEM-007

- cardId: S-CARD-SYSTEM-007
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: City Services District
- purpose: Discovery index for constitutional services without lifecycle control.
- path/route if exists: `/s/city/services`
- status: PLACEHOLDER
- audience: Public
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [support, capability]
- linkedResources: []
- doNot: Keep services as discovery resources, not lifecycle commitments.
- notes: Route currently uses a clean S placeholder.
- next: Populate from TOOL_CARD and PATHWAY_CARD entries.

### S-CARD-SYSTEM-008

- cardId: S-CARD-SYSTEM-008
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: City Tools District
- purpose: Discovery surface for reusable user-facing tools.
- path/route if exists: `/s/city/tools`
- status: PLACEHOLDER
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [tool, accessibility, communication]
- linkedResources: []
- doNot: Present only user-facing tools with clear resource or self-discovery value.
- notes: None.
- next: Populate from TOOL_CARD entries.

### S-CARD-SYSTEM-009

- cardId: S-CARD-SYSTEM-009
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: City Knowledge District
- purpose: Entry surface for library, awareness, education, and guidance content.
- path/route if exists: `/s/city/library`
- status: PLACEHOLDER
- audience: Public
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [library, interest, accessibility]
- linkedResources: [articles, exercises, audio, video, guides]
- doNot: Do not publish sensitive content through authority language.
- notes: Current route is a clean S placeholder; active library remains at `/module/library`.
- next: Link CONTENT_CARD entries.

### S-CARD-SYSTEM-010

- cardId: S-CARD-SYSTEM-010
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Provider Discovery District
- purpose: Discover visible clinicians by category and capability signals.
- path/route if exists: `/s/city/providers`
- status: PLACEHOLDER
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [provider capability, communication, accessibility]
- linkedResources: [provider categories]
- doNot: Keep provider discovery recommendation-oriented and choice-led.
- notes: Active provider directory currently remains under module routes.
- next: Connect readiness-filtered provider cards.

### S-CARD-SYSTEM-011

- cardId: S-CARD-SYSTEM-011
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Center Discovery District
- purpose: Discover visible centers by category, location, capability, and accessibility signals.
- path/route if exists: `/s/city/centers`
- status: PLACEHOLDER
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [center capability, location, media, pricing, accessibility]
- linkedResources: [center categories]
- doNot: Keep center discovery focused on visibility, capabilities, accessibility, and resources.
- notes: Active center directory currently remains under module routes.
- next: Connect readiness-filtered center cards.

### S-CARD-SYSTEM-012

- cardId: S-CARD-SYSTEM-012
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Capital
- purpose: Federation visibility surface for monitoring, incidents, maintenance, broadcasts, and departments.
- path/route if exists: `lib/features/s_capital/presentation/pages/s_capital_operations_office_page.dart` / `/s/capital`
- status: FOUNDATION
- audience: Authorized federation roles
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [monitoring, safety, runtime health]
- linkedResources: [reports]
- doNot: Keep visibility separate from human control over people or journeys.
- notes: None.
- next: Connect clean signal and resource visibility models.

### S-CARD-SYSTEM-013

- cardId: S-CARD-SYSTEM-013
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Monitoring and Intelligence Room
- purpose: Observe signal aggregates, trends, gaps, reports, and distribution visibility.
- path/route if exists: `lib/features/s_capital/presentation/pages/s_signal_monitoring_room_page.dart` / `/s/capital/signal-monitoring-room`
- status: ACTIVE
- audience: monitoring_operator
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [monitoring signals, trend signals, gap signals]
- linkedResources: [reports]
- doNot: Observe readiness and safety signals without directing people or changing records.
- notes: None.
- next: Connect validated aggregate read models.

### S-CARD-SYSTEM-014

- cardId: S-CARD-SYSTEM-014
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Owner Room
- purpose: Constitutional oversight without personal journey control.
- path/route if exists: `lib/features/s_owner/presentation/pages/s_owner_district_page.dart` / `/s/owner/room`
- status: FOUNDATION
- audience: Owner
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [system health, constitutional gaps]
- linkedResources: [strategic memory, constitutional memory, vault, capsules]
- doNot: Do not restore previous lifecycle authority.
- notes: None.
- next: Connect owner memory and oversight records.

### S-CARD-SYSTEM-015

- cardId: S-CARD-SYSTEM-015
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Constitutional Memory
- purpose: Preserve architecture and doctrine history for system continuity.
- path/route if exists: `/s/owner/constitutional-memory`
- status: FOUNDATION
- audience: Owner
- magnetReady: no
- fingerprintIds: []
- linkedSignals: []
- linkedResources: [registry documents, historical decisions]
- doNot: Do not expose runtime authority or mutable runtime queues.
- notes: None.
- next: Link immutable doctrine records.

### S-CARD-SYSTEM-016

- cardId: S-CARD-SYSTEM-016
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Sovereign Vault
- purpose: Protected reference surface for critical constitutional assets.
- path/route if exists: `/s/owner/sovereign-vault`
- status: PLACEHOLDER
- audience: Owner
- magnetReady: no
- fingerprintIds: []
- linkedSignals: []
- linkedResources: [protected constitutional assets]
- doNot: Do not store mutable personal-control records or private journey data.
- notes: None.
- next: Define admissible vault asset classes.

### S-CARD-SYSTEM-017

- cardId: S-CARD-SYSTEM-017
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Federation Recovery Console
- purpose: Observe recovery paths for system continuity after failure.
- path/route if exists: `/s/owner/recovery-console`
- status: PLACEHOLDER
- audience: Owner
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [system degradation, recovery readiness]
- linkedResources: [recovery guidance]
- doNot: Do not become a live runtime control plane.
- notes: None.
- next: Connect read-only recovery metadata.

### S-CARD-SYSTEM-018

- cardId: S-CARD-SYSTEM-018
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Signal Runtime
- purpose: Validate, create, route, emit, and aggregate constitutional signal packages.
- path/route if exists: `lib/features/signals/**`
- status: ACTIVE_FOUNDATION
- audience: System
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [all registered signal types]
- linkedResources: []
- doNot: Do not diagnose, score people, derive authority, or ingest forbidden runtime sources.
- notes: None.
- next: Register stable external signal IDs.

### S-CARD-SYSTEM-019

- cardId: S-CARD-SYSTEM-019
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Visibility Readiness
- purpose: Derive provider and center visibility from required signal completeness.
- path/route if exists: `lib/core/visibility/visibility_readiness.dart`
- status: ACTIVE_COMPATIBILITY_PENDING
- audience: System, providers, centers, observatories
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [completed signals, missing signals, safety block]
- linkedResources: []
- doNot: Derive readiness from signal completeness only.
- notes: Older visibility transition remains until readiness backfill.
- next: Remove fallback after readiness backfill.

### S-CARD-SYSTEM-020

- cardId: S-CARD-SYSTEM-020
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Monitoring Logic
- purpose: Pure logic for signal aggregation, trend analysis, and gap detection without persistence.
- path/route if exists: `lib/features/monitoring/domain/`
- status: ACTIVE_FOUNDATION
- audience: System
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [signal aggregation, monitoring feeds]
- linkedResources: []
- doNot: Do not implement persistence inside domain adapters.
- notes: None.
- next: Connect to Signal Persistence store.

### S-CARD-SYSTEM-021

- cardId: S-CARD-SYSTEM-021
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Trust Foundation
- purpose: Constitutional mappers and contracts for provider trust summaries.
- path/route if exists: `lib/features/trust/domain/`
- status: FOUNDATION
- audience: System
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [trust summary signals]
- linkedResources: [provider profiles]
- doNot: Do not derive trust from non-constitutional sources.
- notes: Future read-surface for rating aggregates.
- next: Connect to Signal Persistence for live summary updates.

### S-CARD-SYSTEM-022

- cardId: S-CARD-SYSTEM-022
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Organization Directory District
- purpose: Discovery surface for NGOs, foundations, and community groups.
- path/route if exists: `/s/city/organizations`
- status: PLACEHOLDER
- audience: Public
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [organization capability, impact signals]
- linkedResources: [organization profiles]
- doNot: Do not become a management or control plane for external entities.
- notes: Clean S placeholder.
- next: Register organization resource cards.

### S-CARD-SYSTEM-023

- cardId: S-CARD-SYSTEM-023
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Marketplace District
- purpose: Discovery surface for services, tools, and professional catalogs.
- path/route if exists: `/s/city/marketplace`
- status: PLACEHOLDER
- audience: Public
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [service interest, tool interest]
- linkedResources: [service catalog, tool catalog]
- doNot: Do not host transaction or lifecycle logic within this discovery surface.
- notes: Clean S placeholder.
- next: Populate from registered service and tool cards.

### S-CARD-SYSTEM-024

- cardId: S-CARD-SYSTEM-024
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Department Operating Surface
- purpose: Observability of federation execution units and operational status.
- path/route if exists: `/s/capital/departments`
- status: PLACEHOLDER
- audience: Authorized federation roles
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [department health, operational signals]
- linkedResources: [department registry]
- doNot: Do not restore staff-led command and control over personal journeys.
- notes: Clean S placeholder.
- next: Connect live department health signals.

### S-CARD-SYSTEM-025

- cardId: S-CARD-SYSTEM-025
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Sovereign Intelligence Hall
- purpose: High-level intelligence overview for executive oversight.
- path/route if exists: `/s/owner/sovereign-intelligence`
- status: PLACEHOLDER
- audience: Owner
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [executive signals, system-wide trends]
- linkedResources: [intelligence reports]
- doNot: Do not expose raw private journey data or PII.
- notes: Clean S placeholder.
- next: Connect aggregated intelligence read-models.

### S-CARD-SYSTEM-026

- cardId: S-CARD-SYSTEM-026
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Survival Capsules Hall
- purpose: Visibility into critical system state snapshots for extreme recovery scenarios.
- path/route if exists: `/s/owner/capsules`
- status: PLACEHOLDER
- audience: Owner
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [capsule readiness, snapshot signals]
- linkedResources: [system state snapshots]
- doNot: Do not store PII or mutable records in survival capsules.
- notes: Clean S placeholder.
- next: Define capsule metadata and provenance.

### S-CARD-SYSTEM-027

- cardId: S-CARD-SYSTEM-027
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Regeneration Board
- purpose: Observe architecture regeneration and doctrine evolution status.
- path/route if exists: `/s/owner/regeneration`
- status: PLACEHOLDER
- audience: Owner
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [regeneration signals, doctrine updates]
- linkedResources: [architecture history]
- doNot: Do not bypass constitutional review for regeneration decisions.
- notes: Clean S placeholder.
- next: Link live architecture state signals.

---

## Signal Cards

### S-CARD-SIGNAL-001

- cardId: S-CARD-SIGNAL-001
- tag: [S]
- cardType: SIGNAL_CARD
- name: Client Identity Signals
- purpose: Express how a client chooses to describe their human identity.
- path/route if exists: `docs/registry/CLIENT_SIGNAL_REGISTRY_V1.md`
- status: FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [kind father, kind mother, loyal friend, helper, loving person]
- linkedResources: []
- doNot: Do not create diagnosis, stigma, deficit, or permanent labels.
- notes: None.
- next: Bind stable signal IDs to client declaration fields.

### S-CARD-SIGNAL-002

- cardId: S-CARD-SIGNAL-002
- tag: [S]
- cardType: SIGNAL_CARD
- name: Client Strength Signals
- purpose: Express strengths the client recognizes in themselves.
- path/route if exists: `docs/registry/CLIENT_SIGNAL_REGISTRY_V1.md`
- status: FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [courage, patience, kindness, responsibility, persistence]
- linkedResources: []
- doNot: Do not convert strengths into scores or eligibility decisions.
- notes: None.
- next: Add strength selection to Personal Space.

### S-CARD-SIGNAL-003

- cardId: S-CARD-SIGNAL-003
- tag: [S]
- cardType: SIGNAL_CARD
- name: Client Relationship Signals
- purpose: Express important human relationships and belonging.
- path/route if exists: `docs/registry/CLIENT_SIGNAL_REGISTRY_V1.md`
- status: FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [father, mother, friend, partner, child]
- linkedResources: []
- doNot: Do not infer dependency, responsibility, or control over relationships.
- notes: None.
- next: Add optional privacy-aware relationship capture.

### S-CARD-SIGNAL-004

- cardId: S-CARD-SIGNAL-004
- tag: [S]
- cardType: SIGNAL_CARD
- name: Client Motivation Signals
- purpose: Express what gives the client hope and forward movement.
- path/route if exists: `docs/registry/CLIENT_SIGNAL_REGISTRY_V1.md`
- status: FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [family, children, faith, future, success]
- linkedResources: []
- doNot: Do not rank motivations or use them as compliance measures.
- notes: None.
- next: Connect motivations to hope-oriented content.

### S-CARD-SIGNAL-005

- cardId: S-CARD-SIGNAL-005
- tag: [S]
- cardType: SIGNAL_CARD
- name: Communication Preference Signals
- purpose: Express preferred communication formats.
- path/route if exists: `lib/features/signals/domain/models/client_signals.dart`
- status: ACTIVE_FOUNDATION
- audience: Client and support surfaces
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [voice, text, sign language, visual]
- linkedResources: [accessible content and tools]
- doNot: Do not treat communication preference as incapacity.
- notes: None.
- next: Fingerprint accessible resources.

### S-CARD-SIGNAL-006

- cardId: S-CARD-SIGNAL-006
- tag: [S]
- cardType: SIGNAL_CARD
- name: Accessibility Signals
- purpose: Express hearing, speech, visual, simplified-content, and low-stimulation preferences.
- path/route if exists: `lib/features/signals/domain/models/client_signals.dart`
- status: ACTIVE_FOUNDATION
- audience: Client and recommendation system
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [accessibility_interest]
- linkedResources: [captioned, text-based, audio-friendly, visual-support, simplified content]
- doNot: Do not create medical or deficit classifications.
- notes: None.
- next: Link library accessibility metadata.

### S-CARD-SIGNAL-007

- cardId: S-CARD-SIGNAL-007
- tag: [S]
- cardType: SIGNAL_CARD
- name: Support Interest Signals
- purpose: Express areas where support is desired.
- path/route if exists: `docs/registry/CLIENT_SIGNAL_REGISTRY_V1.md`
- status: FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [addiction, mental health, family, education, disability]
- linkedResources: [pathways, providers, centers, content, tools]
- doNot: Do not diagnose or automatically route a person.
- notes: None.
- next: Map support interests to pathway fingerprints.

### S-CARD-SIGNAL-008

- cardId: S-CARD-SIGNAL-008
- tag: [S]
- cardType: SIGNAL_CARD
- name: Provider Declaration Signals
- purpose: Express provider identity, capability, accessibility, communication, learning, document, and safety readiness.
- path/route if exists: `lib/features/signals/domain/models/provider_signals.dart`
- status: ACTIVE_FOUNDATION
- audience: Clinicians and discovery
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [identity, capability, accessibility, communication, learning, document, safety]
- linkedResources: [provider category cards]
- doNot: Keep provider visibility derived from declaration completeness and safety boundaries.
- notes: Registration still writes older visibility transition fields.
- next: Complete declaration signal backfill.

### S-CARD-SIGNAL-009

- cardId: S-CARD-SIGNAL-009
- tag: [S]
- cardType: SIGNAL_CARD
- name: Center Declaration Signals
- purpose: Express center identity, location, capability, pricing, media, document, and safety readiness.
- path/route if exists: `lib/features/signals/domain/models/center_signals.dart`
- status: ACTIVE_FOUNDATION
- audience: Centers and discovery
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [identity, location, capability, pricing, media, document, safety]
- linkedResources: [center category cards]
- doNot: Keep center visibility derived from declaration completeness and safety boundaries.
- notes: Registration still writes older visibility transition fields.
- next: Complete declaration signal backfill.

### S-CARD-SIGNAL-010

- cardId: S-CARD-SIGNAL-010
- tag: [S]
- cardType: SIGNAL_CARD
- name: Readiness Signals
- purpose: Represent completed, missing, fresh, blocked, and visibility-ready declaration state.
- path/route if exists: `docs/registry/SIGNAL_REGISTRY_V1.md`
- status: ACTIVE_DOCTRINE
- audience: System and observatories
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [visibilityReadiness, missingSignals, completedSignals, readinessUpdatedAt, readinessSource]
- linkedResources: []
- doNot: Do not create human-granted visibility.
- notes: Older visibility fields remain transition-only.
- next: Remove transition fields after backfill.

---

## Client Aspiration Cards

### S-CARD-ASPIRATION-001

- cardId: S-CARD-ASPIRATION-001
- tag: [S]
- cardType: CLIENT_ASPIRATION_CARD
- name: Success
- purpose: Express a desire for meaningful personal success.
- path/route if exists: `docs/registry/CLIENT_SIGNAL_REGISTRY_V1.md`
- status: FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client.aspiration.success]
- linkedResources: []
- doNot: Do not define success for the client or turn it into a score.
- notes: None.
- next: Link growth tools and learning content.

### S-CARD-ASPIRATION-002

- cardId: S-CARD-ASPIRATION-002
- tag: [S]
- cardType: CLIENT_ASPIRATION_CARD
- name: Stability
- purpose: Express a desire for greater stability in life.
- path/route if exists: `docs/registry/CLIENT_SIGNAL_REGISTRY_V1.md`
- status: FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client.aspiration.stability]
- linkedResources: []
- doNot: Do not infer instability, risk, or diagnosis.
- notes: None.
- next: Link continuity and practical support resources.

### S-CARD-ASPIRATION-003

- cardId: S-CARD-ASPIRATION-003
- tag: [S]
- cardType: CLIENT_ASPIRATION_CARD
- name: Learning
- purpose: Express a desire to learn and build knowledge.
- path/route if exists: `docs/registry/CLIENT_SIGNAL_REGISTRY_V1.md`
- status: FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client.aspiration.learning]
- linkedResources: [library content, exercises, learning paths]
- doNot: Do not rank intelligence or capability.
- notes: None.
- next: Link content difficulty and format fingerprints.

### S-CARD-ASPIRATION-004

- cardId: S-CARD-ASPIRATION-004
- tag: [S]
- cardType: CLIENT_ASPIRATION_CARD
- name: Family Connection
- purpose: Express a desire for stronger family connection and belonging.
- path/route if exists: `docs/registry/CLIENT_SIGNAL_REGISTRY_V1.md`
- status: FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client.aspiration.family_connection]
- linkedResources: [family awareness, family counseling]
- doNot: Do not infer relationship quality or define family roles for the person.
- notes: None.
- next: Link belonging and communication resources.

### S-CARD-ASPIRATION-005

- cardId: S-CARD-ASPIRATION-005
- tag: [S]
- cardType: CLIENT_ASPIRATION_CARD
- name: Recovery
- purpose: Express a client-chosen direction toward recovery and renewed life.
- path/route if exists: `docs/registry/CLIENT_SIGNAL_REGISTRY_V1.md`
- status: FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client.aspiration.recovery]
- linkedResources: [recovery pathway, recovery content, provider and center categories]
- doNot: Do not label the client by condition or own recovery.
- notes: None.
- next: Link voluntary recovery resources.

---

## Tool Cards

### S-CARD-TOOL-001

- cardId: S-CARD-TOOL-001
- tag: [S]
- cardType: TOOL_CARD
- name: Support Entry
- purpose: Present voluntary support pathways, providers, centers, content, and support contact.
- path/route if exists: `lib/features/modules/presentation/pages/support_entry_page.dart` / `/module/addiction`, `/module/special_needs`
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [support interest, destination]
- linkedResources: [providers, centers, library, support]
- doNot: Keep the path voluntary, supportive, and resource-led.
- notes: Route names are module-era but runtime is discovery-oriented.
- next: Replace module routes with PATHWAY_CARD routes.

### S-CARD-TOOL-002

- cardId: S-CARD-TOOL-002
- tag: [S]
- cardType: TOOL_CARD
- name: Support Issue Selector
- purpose: Capture a structured support request category.
- path/route if exists: `lib/features/modules/presentation/pages/support_issue_selector_page.dart` / `/module/support-issue-selector`
- status: BLOCKED_CONTAMINATED
- audience: Clients, clinicians, centers
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [support_started]
- linkedResources: [support requests]
- doNot: Keep support requests focused on signals, preferences, and resource direction.
- notes: Active labels still require vocabulary cleanup before magnet mapping.
- next: Rebuild category vocabulary before magnet mapping.

### S-CARD-TOOL-003

- cardId: S-CARD-TOOL-003
- tag: [S]
- cardType: TOOL_CARD
- name: Provider Directory
- purpose: Browse readiness-visible providers by constitutional category.
- path/route if exists: `lib/features/specialists/presentation/` / `/module/specialists`, `/module/specialists/list`, `/module/specialists/details`
- routes: `/module/specialists`, `/module/specialists/list`, `/module/specialists/details`
- reads: Firestore `clinicians`
- writes: None
- signalsConsumed: [visibilityReadiness, provider capability, specialty category]
- signalsEmitted: [providerContactStarted through contact request flow, destinationSaved through saved destination flow]
- relatedCards: [S-CARD-RUNTIME-003, S-CARD-RUNTIME-010, S-CARD-RESOURCE-001, S-CARD-PROVIDER-001, S-CARD-PROVIDER-002, S-CARD-PROVIDER-003, S-CARD-PROVIDER-004, S-CARD-PROVIDER-005]
- level: ACTIVE
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [provider_profile_opened, provider capability]
- linkedResources: [provider category cards]
- doNot: Keep provider discovery recommendation-oriented and choice-led.
- notes: Uses module-era routes pending S City integration.
- next: Move entry point under Provider Discovery District.

### S-CARD-TOOL-004

- cardId: S-CARD-TOOL-004
- tag: [S]
- cardType: TOOL_CARD
- name: Center Directory
- purpose: Browse readiness-visible centers by category.
- path/route if exists: `lib/features/centers/presentation/` / `/module/centers`, `/module/centers/list`, `/module/centers/details`
- routes: `/module/centers`, `/module/centers/list`, `/module/centers/details`
- reads: Firestore `centers`
- writes: None
- signalsConsumed: [visibilityReadiness, center capability, location, center category]
- signalsEmitted: [centerContactStarted through contact request flow, destinationSaved through saved destination flow]
- relatedCards: [S-CARD-RUNTIME-003, S-CARD-RUNTIME-010, S-CARD-RESOURCE-001, S-CARD-CENTER-001, S-CARD-CENTER-002, S-CARD-CENTER-003, S-CARD-CENTER-004]
- level: ACTIVE
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [center_contact_started, center capability, location]
- linkedResources: [center category cards]
- doNot: Keep center discovery focused on capabilities, accessibility, visibility, and resources.
- notes: Uses module-era routes pending S City integration.
- next: Move entry point under Center Discovery District.

### S-CARD-TOOL-005

- cardId: S-CARD-TOOL-005
- tag: [S]
- cardType: TOOL_CARD
- name: Personal Shortcuts
- purpose: Give clients direct access to saved constitutional destinations.
- path/route if exists: `lib/features/s_personal_space/presentation/pages/s_personal_space_page.dart`
- status: ACTIVE_FOUNDATION
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [destination_saved]
- linkedResources: [saved destinations]
- doNot: Do not save dead or previous runtime routes.
- notes: Empty-state heavy; destination validation remains limited.
- next: Validate saved routes against this card registry.

### S-CARD-TOOL-006

- cardId: S-CARD-TOOL-006
- tag: [S]
- cardType: TOOL_CARD
- name: Support Chat
- purpose: Provide human communication and safety escalation entry without directing personal journeys.
- path/route if exists: `lib/features/chat/presentation/pages/chat_page.dart`, `lib/features/chat/presentation/pages/clinician_chat_inbox_page.dart` / `/chat`, `/clinician/chat-inbox`
- routes: `/chat`, `/clinician/chat-inbox`
- reads: Firestore `chat_threads`, `chat_threads/{threadId}/messages`
- writes: Firestore `chat_threads`, `chat_threads/{threadId}/messages`, safety flags on `chat_threads`
- signalsConsumed: [routingSignals, recommendedActions, safetyEscalationLevel]
- signalsEmitted: [chat message activity, safety escalation intent through escalation flow]
- relatedCards: [S-CARD-SAFETY-001, S-CARD-SAFETY-002]
- level: ACTIVE
- status: ACTIVE_PURIFICATION_REQUIRED
- audience: Public and signed-in users
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [support signals, routing signals, safety escalation level]
- linkedResources: [support guidance]
- doNot: Keep chat as support communication, safety signaling, and voluntary guidance.
- notes: Chat models still retain older routing transition fields.
- next: Remove older routing transition fields after data migration.

### S-CARD-TOOL-011

- cardId: S-CARD-TOOL-011
- tag: [S]
- cardType: TOOL_CARD
- name: Archive Assistant
- purpose: Provide supportive guidance and resource direction within the client room.
- path/route if exists: `lib/features/assistant/presentation/widgets/bounded_assistant_panel.dart`
- status: ACTIVE
- audience: Client
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [assistant_interaction]
- linkedResources: [guidance content]
- doNot: Do not diagnose, judge, or coerce users.
- notes: Embedded in Personal Space.
- next: Connect to Signal Magnet for resource recommendations.

---

## Content Cards

### S-CARD-CONTENT-001

- cardId: S-CARD-CONTENT-001
- tag: [S]
- cardType: CONTENT_CARD
- name: Articles
- purpose: Text-based educational and awareness content.
- path/route if exists: `lib/features/library/presentation/pages/library_page.dart` / `/module/library`
- status: ACTIVE
- audience: General public
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [library_category_opened, text_based, basic]
- linkedResources: []
- doNot: Do not present content as diagnosis or treatment decisions.
- notes: None.
- next: Assign topic fingerprints per article.

### S-CARD-CONTENT-002

- cardId: S-CARD-CONTENT-002
- tag: [S]
- cardType: CONTENT_CARD
- name: Exercises
- purpose: Simple self-development exercises.
- path/route if exists: `lib/features/library/presentation/pages/library_page.dart`
- status: ACTIVE
- audience: General public
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [self_development, simplified_content, easy]
- linkedResources: []
- doNot: Do not represent exercises as clinical treatment.
- notes: None.
- next: Add explicit safety and accessibility metadata.

### S-CARD-CONTENT-003

- cardId: S-CARD-CONTENT-003
- tag: [S]
- cardType: CONTENT_CARD
- name: Audio Guidance
- purpose: Audio-friendly educational and awareness content.
- path/route if exists: `lib/features/library/presentation/pages/library_page.dart`
- status: ACTIVE
- audience: General public
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [audio, audio_friendly, easy]
- linkedResources: []
- doNot: Do not imply live clinical guidance.
- notes: None.
- next: Add language and transcript fingerprints.

### S-CARD-CONTENT-004

- cardId: S-CARD-CONTENT-004
- tag: [S]
- cardType: CONTENT_CARD
- name: Video Guidance
- purpose: Visual educational and awareness content.
- path/route if exists: `lib/features/library/presentation/pages/library_page.dart`
- status: ACTIVE
- audience: General public
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [video, visual_support, easy]
- linkedResources: []
- doNot: Do not publish sensitive material without safety classification.
- notes: Library policy still contains older publication-control wording.
- next: Replace with safety and resource-quality publication criteria.

### S-CARD-CONTENT-005

- cardId: S-CARD-CONTENT-005
- tag: [S]
- cardType: CONTENT_CARD
- name: Family Awareness
- purpose: Support family understanding, communication, and belonging.
- path/route if exists: `lib/features/library/data/library_signal_metadata.dart`
- status: ACTIVE_METADATA
- audience: Families and caregivers
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [family_support, communication, family, caregivers]
- linkedResources: []
- doNot: Do not create family blame or define responsibility for the person.
- notes: None.
- next: Link family aspiration and relationship signals.

### S-CARD-CONTENT-006

- cardId: S-CARD-CONTENT-006
- tag: [S]
- cardType: CONTENT_CARD
- name: Prevention Awareness
- purpose: Provide accessible prevention and mental health awareness.
- path/route if exists: `lib/features/library/data/library_signal_metadata.dart`
- status: ACTIVE_METADATA
- audience: General public, children, and families
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [prevention, mental_health, child_friendly, simplified_content]
- linkedResources: []
- doNot: Do not diagnose or frighten users into action.
- notes: None.
- next: Add age and sensitivity boundaries.

---

## Resource Cards

### S-CARD-RESOURCE-001

- cardId: S-CARD-RESOURCE-001
- tag: [S]
- cardType: RESOURCE_CARD
- name: Saved Destinations
- purpose: Preserve client-selected providers, centers, content, and tool destinations as voluntary resource signals.
- path/route if exists: `lib/features/saved_destinations/data/saved_destination_repository.dart`
- routes: No direct route; used by provider details, center details, client dashboard, and Personal Space.
- reads: Firestore `saved_destinations`
- writes: Firestore `saved_destinations`
- signalsConsumed: [client goal signals, interest signals, accessibility signals, destination signal tags]
- signalsEmitted: [destinationSaved]
- relatedCards: [S-CARD-SYSTEM-002, S-CARD-RUNTIME-005, S-CARD-TOOL-003, S-CARD-TOOL-004]
- level: ACTIVE
- status: ACTIVE
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [destinationSaved, goalSignals, interestSignals, accessibilitySignals]
- linkedResources: [providers, centers, articles, exercises, audio, video, tools]
- doNot: Do not save dead, previous, or unsafe external destinations.
- notes: Former card name only covered library destinations; runtime also stores providers and centers.
- next: Enforce registered destination types.

### S-CARD-RESOURCE-002

- cardId: S-CARD-RESOURCE-002
- tag: [S]
- cardType: RESOURCE_CARD
- name: Public Resource Registry
- purpose: Represent safe public links, support numbers, complaint channels, and education resources.
- path/route if exists: Firestore `resources`
- status: BLOCKED_AUTHORITY_REVIEW
- audience: Signed-in users
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [support, safety, education, accessibility]
- linkedResources: []
- doNot: Expose only verified resources with clear safety and provenance boundaries.
- notes: `registry_steward` currently has write authority in Firestore rules.
- next: Define read-only publication and safety provenance.

### S-CARD-RESOURCE-003

- cardId: S-CARD-RESOURCE-003
- tag: [S]
- cardType: RESOURCE_CARD
- name: AI Policy Registry
- purpose: Store and publish constitutional AI behavior and safety policies.
- path/route if exists: Firestore `ai_policies`
- status: ACTIVE
- audience: System and observers
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [policy health, safety status]
- linkedResources: [AI behavior definitions]
- doNot: Do not allow AI policies to override the Constitution.
- notes: Seeded from `lib/dev/ai_policy_seeder.dart`.
- next: Link to Capital observability.

---

## Provider Category Cards

### S-CARD-PROVIDER-001

- cardId: S-CARD-PROVIDER-001
- tag: [S]
- cardType: PROVIDER_CATEGORY_CARD
- name: Psychologists
- purpose: Discover psychologists and clinical psychologists.
- path/route if exists: `/module/specialists/list?category=psychologists`
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [mental_health, provider capability]
- linkedResources: [provider profiles]
- doNot: Do not rank providers through authority or direct client choice.
- notes: Route remains module-era.
- next: Add capability and accessibility fingerprints.

### S-CARD-PROVIDER-002

- cardId: S-CARD-PROVIDER-002
- tag: [S]
- cardType: PROVIDER_CATEGORY_CARD
- name: Family Counseling
- purpose: Discover family guidance and relationship support providers.
- path/route if exists: `/module/specialists/list?category=family_counseling`
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [family_support, communication, family_connection]
- linkedResources: [provider profiles, family awareness]
- doNot: Do not infer family dysfunction or define relationship responsibility.
- notes: Route remains module-era.
- next: Link relationship and belonging signals.

### S-CARD-PROVIDER-003

- cardId: S-CARD-PROVIDER-003
- tag: [S]
- cardType: PROVIDER_CATEGORY_CARD
- name: Speech Specialists
- purpose: Discover speech and communication specialists.
- path/route if exists: `/module/specialists/list?category=speech_specialists`
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [communication, accessibility]
- linkedResources: [provider profiles]
- doNot: Do not treat communication preference as diagnosis.
- notes: Catalog description still uses older service-format terminology.
- next: Replace older wording with support capability wording.

### S-CARD-PROVIDER-004

- cardId: S-CARD-PROVIDER-004
- tag: [S]
- cardType: PROVIDER_CATEGORY_CARD
- name: Coaching
- purpose: Discover development and motivation support providers.
- path/route if exists: `/module/specialists/list?category=coaching`
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [growth, learning, motivation]
- linkedResources: [provider profiles, exercises]
- doNot: Do not present coaching as clinical treatment.
- notes: Route remains module-era.
- next: Link aspiration fingerprints.

### S-CARD-PROVIDER-005

- cardId: S-CARD-PROVIDER-005
- tag: [S]
- cardType: PROVIDER_CATEGORY_CARD
- name: Addiction Counseling
- purpose: Discover voluntary recovery and addiction support providers.
- path/route if exists: `/module/specialists/list?category=addiction`
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [recovery, addiction support]
- linkedResources: [provider profiles, recovery content]
- doNot: Keep recovery support voluntary, dignity-centered, and choice-led.
- notes: Catalog description still uses older service-format terminology.
- next: Replace older wording and link recovery aspiration.

---

## Center Category Cards

### S-CARD-CENTER-001

- cardId: S-CARD-CENTER-001
- tag: [S]
- cardType: CENTER_CATEGORY_CARD
- name: Rehabilitation Centers
- purpose: Discover centers offering recovery and rehabilitation capabilities.
- path/route if exists: `/module/centers/list?category=recovery`
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [recovery, center capability, location]
- linkedResources: [center profiles]
- doNot: Keep center category discovery separate from lifecycle or transaction control.
- notes: Route remains module-era.
- next: Add capability, accessibility, and readiness fingerprints.

### S-CARD-CENTER-002

- cardId: S-CARD-CENTER-002
- tag: [S]
- cardType: CENTER_CATEGORY_CARD
- name: Detox Centers
- purpose: Discover centers declaring detox and medical-support capabilities.
- path/route if exists: `/module/centers/list?category=detox`
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [detox capability, safety, location]
- linkedResources: [center profiles]
- doNot: Do not claim safety without verified declaration signals.
- notes: Landing copy still needs medical-continuity language review.
- next: Define required detox safety signals.

### S-CARD-CENTER-003

- cardId: S-CARD-CENTER-003
- tag: [S]
- cardType: CENTER_CATEGORY_CARD
- name: Hospitals
- purpose: Discover hospitals declaring integrated medical and mental health capabilities.
- path/route if exists: `/module/centers/list?category=hospital`
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [medical capability, mental health capability, location, safety]
- linkedResources: [center profiles]
- doNot: Do not imply certification beyond declaration readiness.
- notes: Route remains module-era.
- next: Add document and safety fingerprints.

### S-CARD-CENTER-004

- cardId: S-CARD-CENTER-004
- tag: [S]
- cardType: CENTER_CATEGORY_CARD
- name: Special Needs Centers
- purpose: Discover centers declaring accessibility, rehabilitation, and specialized support capabilities.
- path/route if exists: `/module/centers/list?category=special_needs`
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [accessibility, specialized support, location]
- linkedResources: [center profiles]
- doNot: Do not use deficit-first or labeling language.
- notes: Pricing model contains older service-format labels.
- next: Separate capability discovery from previous pricing vocabulary.

---

## Safety Cards

### S-CARD-SAFETY-001

- cardId: S-CARD-SAFETY-001
- tag: [S]
- cardType: SAFETY_CARD
- name: Safety Escalation Observatory
- purpose: Observe open safety escalations, risk classification, reports, and resolution state.
- path/route if exists: `lib/features/safety/presentation/pages/chat_escalations_page.dart` / `/chat/escalations`
- routes: `/chat/escalations`
- reads: Firestore `chat_escalations`, `chat_threads`, `chat_escalations/{escalationId}/reports`
- writes: Firestore `chat_escalations` safety resolution fields and `system_domains/chat` health snapshot
- signalsConsumed: [safetyEscalationLevel, routingSignals, risk classification]
- signalsEmitted: [chat domain health snapshot]
- relatedCards: [S-CARD-TOOL-006, S-CARD-SAFETY-002]
- level: SAFETY
- status: ACTIVE
- audience: support_observer
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [safetyEscalationLevel, routingSignals, risk classification]
- linkedResources: [safety reports, escalation guidance]
- doNot: Keep safety visibility separate from staff direction or provider selection.
- notes: None.
- next: Connect safety guidance cards.

### S-CARD-SAFETY-002

- cardId: S-CARD-SAFETY-002
- tag: [S]
- cardType: SAFETY_CARD
- name: Safety Escalation Report
- purpose: Read a structured safety escalation report and its evidence.
- path/route if exists: `lib/features/chat/presentation/pages/chat_escalation_report_page.dart` / `/chat/escalation/report`
- routes: `/chat/escalation/report`
- reads: Firestore `chat_escalations`, `chat_escalations/{escalationId}/reports`
- writes: Firestore `chat_escalations/{escalationId}/reports`
- signalsConsumed: [risk classification, safety escalation level, safety report context]
- signalsEmitted: [safety report submitted]
- relatedCards: [S-CARD-SAFETY-001, S-CARD-TOOL-006]
- level: SAFETY
- status: ACTIVE
- audience: Authorized safety observers
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [risk classification, safety escalation level]
- linkedResources: [report evidence]
- doNot: Use the report only for safety understanding, continuity, and guidance.
- notes: Report schema still contains an older context transition section.
- next: Rename transition section after historical data migration.

### S-CARD-SAFETY-003

- cardId: S-CARD-SAFETY-003
- tag: [S]
- cardType: SAFETY_CARD
- name: Trust and Safety District
- purpose: Constitutional entry point for safety visibility and guidance.
- path/route if exists: `/s/capital/trust-safety`
- status: PLACEHOLDER
- audience: support_observer
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [safety signals, risk signals]
- linkedResources: [crisis guidance, complaint channels, legal resources]
- doNot: Keep the district as safety visibility and guidance, not personal journey control.
- notes: None.
- next: Link clean safety cards and resources.

---

## Memory Cards

### S-CARD-ARCHIVE-001

- cardId: S-CARD-ARCHIVE-001
- tag: [S]
- cardType: ARCHIVE_CARD
- name: Strategic Memory
- purpose: Preserve strategic constitutional history for owner reference.
- path/route if exists: `/s/owner/strategic-memory`
- status: FOUNDATION
- audience: Owner
- magnetReady: no
- fingerprintIds: []
- linkedSignals: []
- linkedResources: [historical strategy records]
- doNot: Do not expose mutable runtime authority.
- notes: None.
- next: Define immutable memory metadata.

---

## Magnet Cards

### S-CARD-MAGNET-001

- cardId: S-CARD-MAGNET-001
- tag: [S]
- cardType: MAGNET_CARD
- name: Signal Fingerprint Registry
- purpose: Define the required structure for signal fingerprints.
- path/route if exists: `lib/features/recommendations/domain/signal_magnet/registry/signal_fingerprint_registry.dart`
- status: FOUNDATION
- audience: System
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [signalId, signalCategory, signalWeight, signalTags, signalPriority]
- linkedResources: []
- doNot: Do not diagnose, classify people, or grant authority.
- notes: No runtime generation exists yet.
- next: Register fingerprints for canonical signal cards.

### S-CARD-MAGNET-002

- cardId: S-CARD-MAGNET-002
- tag: [S]
- cardType: MAGNET_CARD
- name: Resource Fingerprint Registry
- purpose: Define signal fingerprints carried by tools, content, resources, providers, and centers.
- path/route if exists: `lib/features/recommendations/domain/signal_magnet/registry/resource_fingerprint_registry.dart`
- status: FOUNDATION
- audience: System
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [resourceSignals, resourcePriority, resourceStatus]
- linkedResources: [all magnet-eligible cards]
- doNot: Do not publish or activate resources through registry authority.
- notes: No populated resource registry exists yet.
- next: Assign resource IDs to magnet-ready cards.

### S-CARD-MAGNET-003

- cardId: S-CARD-MAGNET-003
- tag: [S]
- cardType: MAGNET_CARD
- name: Recommendation Candidate Registry
- purpose: Define candidate records produced by future fingerprint matching.
- path/route if exists: `lib/features/recommendations/domain/signal_magnet/registry/recommendation_candidate_registry.dart`
- status: FOUNDATION
- audience: System
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [matchedSignals, matchScore, attractionScore]
- linkedResources: [candidate resources]
- doNot: Keep matching as opportunity discovery and never as authority over people.
- notes: No candidate generation runtime exists yet.
- next: Define transparent scoring boundaries.

### S-CARD-MAGNET-004

- cardId: S-CARD-MAGNET-004
- tag: [S]
- cardType: MAGNET_CARD
- name: Signal Magnet Registry
- purpose: Version and connect signal, resource, and recommendation candidate registries.
- path/route if exists: `lib/features/recommendations/domain/signal_magnet/models/signal_magnet_registry.dart`
- status: FOUNDATION
- audience: System and registry observers
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [signal registry reference]
- linkedResources: [resource registry reference, recommendation candidate registry]
- doNot: Do not become an authority or runtime routing engine.
- notes: Foundation only.
- next: Publish registry metadata V1.

---

## Pathway Cards

### S-CARD-PATHWAY-001

- cardId: S-CARD-PATHWAY-001
- tag: [S]
- cardType: PATHWAY_CARD
- name: Recovery Support Pathway
- purpose: Offer voluntary access to recovery providers, centers, content, tools, and support.
- path/route if exists: `/module/addiction`
- status: ACTIVE_LANGUAGE_REVIEW
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client.aspiration.recovery, client.support.addiction]
- linkedResources: [addiction counseling, rehabilitation centers, detox centers, recovery content]
- doNot: Keep recovery support voluntary, dignity-centered, and resource-led.
- notes: Route name and some content retain addiction-era language.
- next: Introduce a clean `/s/pathways/recovery` route.

### S-CARD-PATHWAY-002

- cardId: S-CARD-PATHWAY-002
- tag: [S]
- cardType: PATHWAY_CARD
- name: Accessibility and Specialized Support Pathway
- purpose: Offer voluntary access to accessible providers, centers, content, tools, and communication options.
- path/route if exists: `/module/special_needs`
- status: ACTIVE_LANGUAGE_REVIEW
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [accessibility, communication, client.support.disability]
- linkedResources: [speech specialists, specialized support centers, accessible content]
- doNot: Do not use deficit-first labels or infer diagnosis.
- notes: Route retains older accessibility terminology.
- next: Introduce a clean accessibility pathway route and language.

### S-CARD-PATHWAY-003

- cardId: S-CARD-PATHWAY-003
- tag: [S]
- cardType: PATHWAY_CARD
- name: Learning and Growth Pathway
- purpose: Connect learning aspirations to content, exercises, coaching, and tools.
- path/route if exists: `/s/city/programs`
- status: PLACEHOLDER
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client.aspiration.learning, growth, motivation]
- linkedResources: [articles, exercises, coaching, learning paths]
- doNot: Do not rank people or make educational eligibility decisions.
- notes: None.
- next: Build from registered content and provider cards.

### S-CARD-PATHWAY-004

- cardId: S-CARD-PATHWAY-004
- tag: [S]
- cardType: PATHWAY_CARD
- name: Family Connection Pathway
- purpose: Connect family aspirations and relationship signals to content and voluntary support.
- path/route if exists: No dedicated route.
- status: FOUNDATION
- audience: Clients and families
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client.aspiration.family_connection, relationship signals, family motivation]
- linkedResources: [family awareness, family counseling, communication resources]
- doNot: Keep family connection voluntary, supportive, and non-coercive.
- notes: None.
- next: Add a clean S pathway route.

---

## Runtime Coverage Cards

### S-CARD-RUNTIME-001

- cardId: S-CARD-RUNTIME-001
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Authentication Shell
- purpose: Resolve authenticated entry, role landing, blocked-account state, language selection, and menu routing.
- path/route if exists: `lib/features/auth/presentation/pages/login_page.dart`, `lib/features/home/**`, `lib/app/router/app_router.dart` / `/login`, `/language`, `/menu`, `/home`, `/account-blocked`, `/splash`
- routes: `/login`, `/language`, `/menu`, `/home`, `/account-blocked`, `/splash`
- reads: Firebase Auth; Firestore `clients`, `clinicians`, `centers`
- writes: None
- signalsConsumed: [role, accountAccess, visibilityReadiness, safety block]
- signalsEmitted: []
- relatedCards: [S-CARD-SYSTEM-002, S-CARD-SYSTEM-003, S-CARD-SYSTEM-004, S-CARD-SYSTEM-005]
- level: ACTIVE
- status: ACTIVE
- audience: All signed-in users
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [accountAccess, visibilityReadiness]
- linkedResources: []
- doNot: Keep entry routing based on role, readiness, and safety boundaries.
- notes: Account access still carries older transition fields while readiness fallback exists.
- next: Remove previous transition after readiness backfill.

### S-CARD-RUNTIME-002

- cardId: S-CARD-RUNTIME-002
- tag: [S]
- cardType: CONTENT_CARD
- name: Portal
- purpose: Present public entry, about, library, contact, and request-intent surfaces without lifecycle control.
- path/route if exists: `lib/features/web_portal/presentation/pages/portal_skeleton_pages.dart` / `/`, `/about`, `/library`, `/register/provider`, `/request/service`, `/request/package`, `/contact`, `/web/library`, `/web/library/policy`
- routes: `/`, `/about`, `/library`, `/register/provider`, `/request/service`, `/request/package`, `/contact`, `/web/library`, `/web/library/policy`
- reads: None
- writes: None
- signalsConsumed: []
- signalsEmitted: []
- relatedCards: [S-CARD-RUNTIME-003, S-CARD-CONTENT-001, S-CARD-CONTENT-002, S-CARD-CONTENT-003, S-CARD-CONTENT-004]
- level: CONTENT
- status: ACTIVE_STATIC
- audience: Public
- magnetReady: no
- fingerprintIds: []
- linkedSignals: []
- linkedResources: [public library, contact entry, registration entry]
- doNot: Keep portal requests informational until a carded runtime action exists.
- notes: Request pages are active static surfaces, not lifecycle systems.
- next: Card any future runtime action before connecting writes.

### S-CARD-RUNTIME-003

- cardId: S-CARD-RUNTIME-003
- tag: [S]
- cardType: TOOL_CARD
- name: Public Discovery
- purpose: Let public and client users discover providers, centers, content, support paths, and library resources.
- path/route if exists: `/module/specialists`, `/module/specialists/list`, `/module/specialists/details`, `/module/centers`, `/module/centers/list`, `/module/centers/details`, `/module/library`, `/module/addiction`, `/module/special_needs`
- routes: `/module/specialists`, `/module/specialists/list`, `/module/specialists/details`, `/module/centers`, `/module/centers/list`, `/module/centers/details`, `/module/library`, `/module/addiction`, `/module/special_needs`
- reads: Firestore `clinicians`, `centers`
- writes: None directly
- signalsConsumed: [visibilityReadiness, provider category, center category, library metadata]
- signalsEmitted: []
- relatedCards: [S-CARD-TOOL-003, S-CARD-TOOL-004, S-CARD-CONTENT-001, S-CARD-CONTENT-002, S-CARD-CONTENT-003, S-CARD-CONTENT-004, S-CARD-PATHWAY-001, S-CARD-PATHWAY-002]
- level: ACTIVE
- status: ACTIVE
- audience: Public and clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [readiness, category, interest]
- linkedResources: [providers, centers, content, pathways]
- doNot: Keep discovery voluntary, recommendation-oriented, and free of treatment decisions.
- notes: Module-era route names remain pending S City migration.
- next: Move public discovery under registered S City cards.

### S-CARD-RUNTIME-004

- cardId: S-CARD-RUNTIME-004
- tag: [S]
- cardType: TOOL_CARD
- name: Client Registration
- purpose: Create a client profile and initial client signal package.
- path/route if exists: `lib/features/auth/presentation/pages/client_register_page.dart` / `/register/client`
- routes: `/register/client`
- reads: Firebase Auth
- writes: Firestore `clients`
- signalsConsumed: [selected goals, selected interests, accessibility interests, communication preference]
- signalsEmitted: [goalSelected, interestSelected, accessibilityInterest, communicationPreferenceSelected]
- relatedCards: [S-CARD-SYSTEM-002, S-CARD-SIGNAL-005, S-CARD-SIGNAL-006, S-CARD-SIGNAL-007]
- level: ACTIVE
- status: ACTIVE
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client goals, interests, accessibility, communication]
- linkedResources: []
- doNot: Ask identity, preference, aspiration, accessibility, and communication questions first.
- notes: None.
- next: Convert remaining profile fields into explicit signal cards.

### S-CARD-RUNTIME-005

- cardId: S-CARD-RUNTIME-005
- tag: [S]
- cardType: S_SYSTEM_CARD
- name: Client Dashboard
- purpose: Give clients access to their profile state, saved destinations, Personal Space, support, discovery, and library paths.
- path/route if exists: `lib/features/client/presentation/pages/client_dashboard_page.dart` / `/client/dashboard`
- routes: `/client/dashboard`
- reads: Firestore `clients`, `saved_destinations`
- writes: None directly
- signalsConsumed: [client identity fields, saved destination signals]
- signalsEmitted: []
- relatedCards: [S-CARD-SYSTEM-002, S-CARD-RESOURCE-001, S-CARD-RUNTIME-003]
- level: ACTIVE
- status: ACTIVE
- audience: Client
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [client profile, destinationSaved]
- linkedResources: [saved destinations, support, library, discovery]
- doNot: Keep the dashboard focused on self-discovery, resources, saved destinations, and support entry.
- notes: None.
- next: Split dashboard tools into discrete tool cards if they gain independent runtime.

### S-CARD-RUNTIME-006

- cardId: S-CARD-RUNTIME-006
- tag: [S]
- cardType: TOOL_CARD
- name: Clinician Registration
- purpose: Capture clinician declaration signals and readiness fields through completeness.
- path/route if exists: `lib/features/web_registration/presentation/pages/web_clinician_register_portal_page.dart`, `web_clinician_profile_page.dart`, `web_clinician_documents_page.dart` / `/web/clinician/register`, `/web/clinician/profile`, `/web/clinician/documents`, `/register/clinician`, `/web/register/success`
- routes: `/web/clinician/register`, `/web/clinician/profile`, `/web/clinician/documents`, `/register/clinician`, `/web/register/success`
- reads: Firebase Auth; Firestore `clinicians`
- writes: Firestore `clinicians`
- signalsConsumed: [clinician declaration fields, document signals, readiness requirements]
- signalsEmitted: [declarationSignals, completedSignals, missingSignals, visibilityReadiness]
- relatedCards: [S-CARD-SIGNAL-008, S-CARD-SIGNAL-010, S-CARD-SYSTEM-005]
- level: ACTIVE
- status: ACTIVE_COMPATIBILITY_PENDING
- audience: Clinicians
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [provider declaration signals, readiness signals]
- linkedResources: [documents]
- doNot: Keep registration centered on declarations, documents, readiness, and visibility.
- notes: Writes older visibility transition fields temporarily.
- next: Remove transition fields after backfill.

### S-CARD-RUNTIME-007

- cardId: S-CARD-RUNTIME-007
- tag: [S]
- cardType: TOOL_CARD
- name: Center Registration
- purpose: Capture center declaration signals and readiness fields through completeness.
- path/route if exists: `lib/features/web_registration/presentation/pages/web_center_register_portal_page.dart`, `web_center_profile_page.dart`, `web_center_media_page.dart`, `web_center_pricing_page.dart`, `web_center_documents_page.dart` / `/web/center/register`, `/web/center/profile`, `/web/center/media`, `/web/center/pricing`, `/web/center/documents`, `/register/center`, `/web/register/success`
- routes: `/web/center/register`, `/web/center/profile`, `/web/center/media`, `/web/center/pricing`, `/web/center/documents`, `/register/center`, `/web/register/success`
- reads: Firebase Auth; Firestore `centers`
- writes: Firestore `centers`
- signalsConsumed: [center declaration fields, media signals, document signals, readiness requirements]
- signalsEmitted: [declarationSignals, completedSignals, missingSignals, visibilityReadiness]
- relatedCards: [S-CARD-SIGNAL-009, S-CARD-SIGNAL-010, S-CARD-SYSTEM-005]
- level: ACTIVE
- status: ACTIVE_COMPATIBILITY_PENDING
- audience: Centers
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [center declaration signals, readiness signals]
- linkedResources: [documents, media]
- doNot: Keep registration centered on declarations, documents, media, readiness, and visibility.
- notes: Writes older visibility transition fields temporarily.
- next: Remove transition fields after backfill.

### S-CARD-RUNTIME-008

- cardId: S-CARD-RUNTIME-008
- tag: [S]
- cardType: TOOL_CARD
- name: Clinician Declaration Flow
- purpose: Let clinicians submit profile update declarations and observe their profile state.
- path/route if exists: `lib/features/clinician/presentation/pages/clinician_room_page.dart` / `/clinician/room`, `/clinician/profile-edit-request`
- routes: `/clinician/room`, `/clinician/profile-edit-request`
- reads: Firestore `clinicians`, `clinician_profile_change_requests`
- writes: Firestore `clinician_profile_change_requests`, clinician profile fields owned by the clinician flow
- signalsConsumed: [clinician identity, profileSignals, changeSummary]
- signalsEmitted: [profile update declaration submitted]
- relatedCards: [S-CARD-RUNTIME-006, S-CARD-SYSTEM-005]
- level: ACTIVE
- status: ACTIVE_DECLARATION_FLOW
- audience: Clinicians
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [provider declaration signals, profile update declaration]
- linkedResources: []
- doNot: Keep clinician updates as declarations and self-maintained profile signals.
- notes: Former route name remains active and needs language cleanup.
- next: Rename route and UI language to clinician room/declaration language.

### S-CARD-RUNTIME-009

- cardId: S-CARD-RUNTIME-009
- tag: [S]
- cardType: TOOL_CARD
- name: Center Declaration Flow
- purpose: Let centers submit profile update declarations and observe center profile state.
- path/route if exists: `lib/features/centers/presentation/pages/center_dashboard_page.dart`, `center_room_page.dart` / `/center/dashboard`, `/center/room`, `/center/profile-edit-request`
- routes: `/center/dashboard`, `/center/room`, `/center/profile-edit-request`
- reads: Firestore `centers`, `center_profile_change_requests`
- writes: Firestore `center_profile_change_requests`, center profile fields owned by the center flow
- signalsConsumed: [center identity, profileSignals, changeSummary]
- signalsEmitted: [profile update declaration submitted]
- relatedCards: [S-CARD-RUNTIME-007, S-CARD-SYSTEM-005]
- level: ACTIVE
- status: ACTIVE_DECLARATION_FLOW
- audience: Centers
- magnetReady: no
- fingerprintIds: []
- linkedSignals: [center declaration signals, profile update declaration]
- linkedResources: []
- doNot: Keep center updates as declarations and self-maintained profile signals.
- notes: Route name and pricing vocabulary still need later purification.
- next: Rename route and UI language to center room/declaration language.

### S-CARD-RUNTIME-010

- cardId: S-CARD-RUNTIME-010
- tag: [S]
- cardType: TOOL_CARD
- name: Contact Requests
- purpose: Store voluntary client contact intent for providers and centers while emitting non-authority contact signals.
- path/route if exists: `lib/features/contact_requests/data/contact_request_repository.dart`
- routes: No direct route; invoked from `/module/specialists/details` and `/module/centers/details`.
- reads: None
- writes: Firestore `provider_contact_requests`, `center_contact_requests`
- signalsConsumed: [goalSignals, interestSignals, accessibilitySignals]
- signalsEmitted: [providerContactStarted, centerContactStarted]
- relatedCards: [S-CARD-TOOL-003, S-CARD-TOOL-004, S-CARD-RUNTIME-003]
- level: TOOL
- status: ACTIVE
- audience: Clients
- magnetReady: yes
- fingerprintIds: []
- linkedSignals: [providerContactStarted, centerContactStarted]
- linkedResources: [providers, centers]
- doNot: Keep contact requests as voluntary intent signals and resource connection.
- notes: None.
- next: Add explicit contact-intent signal fingerprints.

## Skipped Items

The following items receive no constitutional card in V1:

- Deleted former authority-surface planning, handoff, gateway, governance, employee, maintenance, and work surfaces.
- Older visibility transition fields.
- Older chat routing transition fields.
- Dead routes, deleted pages, placeholders removed by cleanup waves, and orphan utilities.
- `AccountBlockingService` because no active caller proves runtime use.
- Generated localization symbols that only preserve older visibility labels.

## Blocked Items

- Support Issue Selector cannot become magnet-ready until older support-category labels are rebuilt.
- Public Resource Registry cannot be canonical while registry-steward write authority remains unresolved.
- Readiness transition fallback requires data backfill before deletion.
- Provider and center module routes need S City route migration.

## Registry Status

- status: FOUNDATIONAL_CANONICAL_REGISTRY
- version: V1
- cards may be added only when they satisfy the schema and carry `tag: [S]`
- fingerprints remain empty until a dedicated mapping wave
