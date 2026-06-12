# ASSET REGISTRY ARCHITECTURE

Phase 2 target architecture. This document defines destinations and governance only. No current file is moved, renamed, deleted, or reconfigured.

## Target Root

```text
ASSIST_LIBRARY/
|-- ROOM_SYSTEM/
|   |-- shared_components/
|   |-- controls/
|   |-- surfaces/
|   `-- empty_states/
|-- BRANDING_SYSTEM/
|   |-- logos/
|   |-- wordmarks/
|   |-- marks/
|   `-- promotional/
|-- ICONS_SYSTEM/
|   |-- navigation/
|   |-- actions/
|   |-- status/
|   `-- platform/
|-- BACKGROUNDS_SYSTEM/
|   |-- global/
|   |-- menu/
|   |-- home/
|   `-- responsive/
|-- PLACEHOLDER_SYSTEM/
|   |-- people/
|   |-- content/
|   |-- rooms/
|   `-- media/
|-- WEB_SYSTEM/
|   |-- shell/
|   |-- portal/
|   |-- shared_registration/
|   `-- platform/
|-- CITY_SYSTEM/
|   |-- home/
|   |-- navigation/
|   `-- library/
|       |-- backgrounds/
|       |-- categories/
|       |-- cards/
|       `-- brand/
|-- CLIENT_ROOM/
|   |-- backgrounds/
|   |-- identity/
|   |-- controls/
|   |-- tools/
|   `-- themes/
|-- PROVIDER_ROOM/
|   |-- backgrounds/
|   |-- identity/
|   |-- categories/
|   |-- registration/
|   `-- room_components/
|-- CENTER_ROOM/
|   |-- backgrounds/
|   |-- identity/
|   |-- categories/
|   |-- registration/
|   `-- room_components/
|-- OWNER_ROOM/
|   |-- backgrounds/
|   |-- observability/
|   `-- room_components/
|-- MONITORING_ROOM/
|   |-- backgrounds/
|   |-- signal_visuals/
|   |-- safety_visuals/
|   `-- room_components/
|-- FUTURE_CONCEPTS/
|   |-- approved_concepts/
|   |-- experiments/
|   `-- theme_prototypes/
`-- LEGACY_IMPORTS/
    |-- immutable_snapshots/
    |-- extinct_runtime/
    |-- duplicate_sources/
    `-- unclassified_quarantine/
```

`LIBRARY_SYSTEM` from Phase 1 becomes `CITY_SYSTEM/library`. It remains a named subsystem, but not an independent owner. `BACKGROUND_SYSTEM` becomes the required plural form `BACKGROUNDS_SYSTEM`.

## Registry Definitions

### ROOM_SYSTEM

- Registry Purpose: Own reusable visual primitives shared by two or more constitutional rooms.
- Expected Asset Types: ROOM_COMPONENT, BUTTON, CARD_VISUAL, PLACEHOLDER.
- Expected Consumers: Client, Provider, Center, Owner, and Monitoring rooms.
- Ownership Rules: A room-specific visual stays with its room. Only semantically identical cross-room components belong here.
- Retention Rules: Retain while at least two active rooms consume the asset.
- Future Expansion Rules: New components require a stable role, accessibility states, and documented consumers.

### BRANDING_SYSTEM

- Registry Purpose: Own the canonical Mental Smile identity.
- Expected Asset Types: LOGO, BANNER, PROMOTIONAL, brand ILLUSTRATION.
- Expected Consumers: App shell, web shell, authentication, public surfaces, documents.
- Ownership Rules: One canonical file per brand mark and variant. Feature copies are forbidden.
- Retention Rules: Superseded marks move to immutable brand history, never remain as runtime alternatives.
- Future Expansion Rules: New variants require a defined channel, background contrast, and brand version.

### ICONS_SYSTEM

- Registry Purpose: Own reusable navigation, action, state, and platform icons.
- Expected Asset Types: ICON and BUTTON when the bitmap itself is the control visual.
- Expected Consumers: All active surfaces.
- Ownership Rules: Semantic meaning owns the icon, not the first screen that uses it.
- Retention Rules: Retain active state families together; remove isolated obsolete states after consumer migration.
- Future Expansion Rules: Every icon family declares size, directionality, disabled state, and accessibility label source.

### BACKGROUNDS_SYSTEM

- Registry Purpose: Own shared scene and shell backgrounds not unique to a constitutional room.
- Expected Asset Types: BACKGROUND and large BANNER.
- Expected Consumers: Menu, home, shared shells, responsive layouts.
- Ownership Rules: Room identity backgrounds belong to the room registry; shared shell backgrounds belong here.
- Retention Rules: Responsive variants are retained as one family with a shared visual ID.
- Future Expansion Rules: Add variants only for a proven layout class, not arbitrary device names.

### PLACEHOLDER_SYSTEM

- Registry Purpose: Own intentional empty, missing-media, and not-yet-configured visuals.
- Expected Asset Types: PLACEHOLDER, empty CARD_VISUAL, neutral ILLUSTRATION.
- Expected Consumers: Cards, directories, rooms, media loaders, registration previews.
- Ownership Rules: Placeholders communicate absence only and cannot masquerade as real people, places, or readiness.
- Retention Rules: Keep only placeholders referenced by an active fallback contract.
- Future Expansion Rules: Every placeholder declares context, aspect ratio, and accessible fallback text.

### WEB_SYSTEM

- Registry Purpose: Own web/platform shell visuals that are not semantically owned by a room or feature.
- Expected Asset Types: BACKGROUND, ICON, LOGO derivative, BANNER, platform OTHER.
- Expected Consumers: Web portal, browser shell, install surfaces, platform launch surfaces.
- Ownership Rules: Provider and center registration art remains with PROVIDER_ROOM or CENTER_ROOM.
- Retention Rules: Platform-required density or manifest variants remain separate when path identity is required.
- Future Expansion Rules: New assets require an active platform consumer and deployment contract.

### CITY_SYSTEM

- Registry Purpose: Own public city navigation and the constitutional library subsystem.
- Expected Asset Types: BACKGROUND, CARD_VISUAL, ICON, ILLUSTRATION, LOGO derivative.
- Expected Consumers: City home, library, content categories, public discovery entry points.
- Ownership Rules: Library assets live under `CITY_SYSTEM/library`; resource content art is owned by its content identity.
- Retention Rules: Dormant library art may sleep only with a catalog ID and intended content destination.
- Future Expansion Rules: New city visuals require a city route, card, content item, or resource destination.

### CLIENT_ROOM

- Registry Purpose: Own the personal visual environment and client-controlled room identity.
- Expected Asset Types: BACKGROUND, ROOM_COMPONENT, CARD_VISUAL, BUTTON, PLACEHOLDER.
- Expected Consumers: Client Room, Personal Space, client identity and signal surfaces.
- Ownership Rules: The client room owns personal scene assets; shared controls reference ROOM_SYSTEM or ICONS_SYSTEM.
- Retention Rules: Theme variants may sleep when registered and complete; extinct lifecycle action art cannot.
- Future Expansion Rules: Additions must map to identity, aspiration, support style, growth, discovery, or accessibility signals.

### PROVIDER_ROOM

- Registry Purpose: Own clinician/provider identity, discovery, registration, and room visuals.
- Expected Asset Types: ILLUSTRATION, BACKGROUND, CARD_VISUAL, PLACEHOLDER, ROOM_COMPONENT.
- Expected Consumers: Provider discovery, clinician registration, clinician room and profile.
- Ownership Rules: Provider-specific assets stay here; shared registration success art belongs to WEB_SYSTEM.
- Retention Rules: Legacy operational action art is not retained as active provider-room material.
- Future Expansion Rules: New visuals require a provider card, declaration signal, discovery category, or room destination.

### CENTER_ROOM

- Registry Purpose: Own center identity, capability discovery, registration, and room visuals.
- Expected Asset Types: ILLUSTRATION, BACKGROUND, CARD_VISUAL, PLACEHOLDER, ROOM_COMPONENT.
- Expected Consumers: Center discovery, center registration, center room and profile.
- Ownership Rules: Center-specific assets stay here; shared web completion art belongs to WEB_SYSTEM.
- Retention Rules: Booking/queue/approval action art cannot remain in the active registry.
- Future Expansion Rules: New visuals require a center card, capability signal, declaration signal, or room destination.

### OWNER_ROOM

- Registry Purpose: Own future constitutional owner-room visuals without administrative control-room semantics.
- Expected Asset Types: BACKGROUND, ROOM_COMPONENT, signal observability CARD_VISUAL.
- Expected Consumers: S Owner and explicitly owner-only constitutional surfaces.
- Ownership Rules: Owner visuals may observe system state but cannot encode approval, assignment, or operational ownership.
- Retention Rules: No asset sleeps here without an active Owner card or approved future concept.
- Future Expansion Rules: Begin empty; additions require an Owner card ID and constitutional purpose.

### MONITORING_ROOM

- Registry Purpose: Own observational readiness, safety, and signal-health visuals.
- Expected Asset Types: CARD_VISUAL, ICON, ROOM_COMPONENT, BACKGROUND.
- Expected Consumers: Monitoring and safety observatories.
- Ownership Rules: Monitoring visuals display signals and safety state; they never represent authority or mutation.
- Retention Rules: Retain only while the observed signal contract exists.
- Future Expansion Rules: Begin empty; additions require a monitoring input, display contract, and no ownership action.

### FUTURE_CONCEPTS

- Registry Purpose: Hold intentional, named, non-runtime concepts approved for future evaluation.
- Expected Asset Types: ILLUSTRATION, BACKGROUND, ROOM_COMPONENT, prototype OTHER.
- Expected Consumers: None in production.
- Ownership Rules: Every concept needs a sponsor registry, concept ID, hypothesis, and review date.
- Retention Rules: Expire or renew at review date. Unknown files are forbidden here.
- Future Expansion Rules: Concepts graduate to an owning registry only after a card and consumer exist.

### LEGACY_IMPORTS

- Registry Purpose: Isolate immutable historical imports, extinct runtime visuals, duplicate source copies, and unresolved quarantine.
- Expected Asset Types: Any, but never as a new active dependency.
- Expected Consumers: Historical documentation only.
- Ownership Rules: No runtime import may originate here. Original path, hash, source era, and disposition are mandatory.
- Retention Rules: Immutable snapshots may remain; extinct runtime and duplicates require a later evidence-based disposition.
- Future Expansion Rules: No newly designed asset may enter this registry.

## Ownership Model

1. Every asset receives one `assetId`, one owning registry, one canonical destination, and zero or more consumers.
2. A file can serve multiple consumers, but cannot have multiple owners.
3. Semantic ownership outranks physical source location.
4. Shared brand, icon, background, placeholder, and room primitives are centralized only when their meaning is truly shared.
5. Duplicate hashes point to one canonical asset record. Alias paths may exist during migration, but are not independent assets.
6. Consumer registries reference canonical IDs; they do not copy files.
7. OWNER_ROOM and MONITORING_ROOM remain empty until a real constitutional visual contract exists.

## Asset Lifecycle Model

```text
DISCOVERED
  -> CLASSIFIED
  -> REGISTERED
  -> ACTIVE
  -> DORMANT
  -> ACTIVE
  -> DEPRECATED
  -> LEGACY_IMPORTS or REMOVAL_REVIEW
```

- DISCOVERED: Path and hash known; ownership unresolved.
- CLASSIFIED: Registry and type assigned.
- REGISTERED: Canonical destination, consumers, and lifecycle metadata recorded.
- ACTIVE: At least one proven runtime/platform consumer.
- DORMANT: No runtime consumer, but a named destination and retention reason exist.
- DEPRECATED: Replacement or constitutional mismatch is proven.
- LEGACY_IMPORTS: Historical-only, immutable, and barred from runtime.
- REMOVAL_REVIEW: No consumer, retention contract, or historical obligation.

Movement is allowed only after canonical ownership, duplicate resolution, consumer migration, and verification. Deletion is allowed only after reference count is zero, aliases are retired, retention obligations are cleared, and the asset is not the canonical member of a surviving duplicate group.

## Dormant Asset Handling

- Dormant assets require an owner, intended consumer/card, sleep reason, and review date.
- A dormant asset cannot be imported by runtime until activated through its owner registry.
- Dormancy without a destination becomes ORPHAN after review.
- Responsive families sleep and wake together unless a variant is independently obsolete.

## Legacy Asset Handling

- Archive snapshots remain immutable and preserve original paths.
- Extinct booking, session, approval, assignment, admin-control, and operational archive visuals cannot migrate into active registries by renaming.
- A legacy file byte-identical to an active canonical asset is recorded as a duplicate source, not a second owned asset.
- Runtime references to `LEGACY_IMPORTS` are forbidden.

## Future Concept Handling

- Future concepts require `conceptId`, sponsor registry, purpose, variants, dependencies, and review date.
- Concepts have no runtime consumers and cannot be listed as ACTIVE.
- Unknown files go to `LEGACY_IMPORTS/unclassified_quarantine`, not FUTURE_CONCEPTS.
- Theme concepts must follow `FUTURE_THEME_SYSTEM.md` before graduation.

## Registry Decision Contract

For any registered asset, the registry record must answer:

- Who owns it? The single owning registry.
- Where does it belong? The canonical `ASSIST_LIBRARY` destination.
- Who consumes it? Explicit routes, pages, platform contracts, cards, or `none`.
- Can it move? Only after consumer and duplicate migration gates pass.
- Can it be deleted? Only after zero-consumer and retention proof.
- Can it sleep? Only with a named owner, destination, reason, and review date.
