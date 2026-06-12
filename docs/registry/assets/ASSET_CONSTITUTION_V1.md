# ASSET CONSTITUTION V1

Status: Foundational Doctrine  
System: Mental Smile Constitutional Asset System  
Phase: A  
Scope: Doctrine and governance only

This document defines the official constitutional asset governance system for Mental Smile. It does not move files, rename files, delete files, modify code, modify pubspec, or execute migration.

The goal is that every visual asset in Mental Smile becomes:

- Known
- Owned
- Governed
- Observable

## 1. What Is An Asset

### Asset

An asset is any visual, image, icon, logo, background, illustration, button, placeholder, room component, banner, promotional image, or visual resource used or retained by the project.

An asset may be a physical file, a platform-required resource, or a named constitutional visual contract.

### Asset Registry

An Asset Registry is the official owner domain for a class of assets. A registry defines purpose, ownership scope, consumer scope, retention rules, and migration rules.

### Asset Card

An Asset Card is the constitutional record for an asset. It names the asset, identifies its owner, records its current location, defines its canonical destination, lists consumers, and declares lifecycle and migration readiness.

No asset is constitutional without a card.

### Asset Owner

The Asset Owner is the single registry responsible for the asset's meaning, canonical destination, lifecycle, retention, and retirement.

### Asset Consumer

An Asset Consumer is any route, page, feature, room, platform shell, manifest, registry, card, or component that reads, displays, references, or depends on an asset.

A consumer does not own the asset unless it is also the declared registry owner.

### Asset Lifecycle

Asset Lifecycle is the current constitutional state of an asset: ACTIVE, DORMANT, LEGACY, DEAD, or UNCLASSIFIED.

### Canonical Asset

A Canonical Asset is the authoritative asset record and destination for a visual identity or visual function. Duplicate aliases may exist temporarily, but only one canonical asset may own the meaning.

### Dormant Asset

A Dormant Asset is known, owned, and intentionally retained without a current visible runtime consumer. Dormant assets must have an owner, purpose, intended future consumer, and review cycle.

### Legacy Asset

A Legacy Asset belongs to a previous architecture, historical snapshot, extinct runtime, or compatibility history. Legacy is not active. Legacy is not dead. Legacy is historical ownership.

### Dead Asset

A Dead Asset has no proven current consumer, no active constitutional owner need, and no retention reason beyond pending review. Dead assets are not deleted automatically; they enter deletion review.

### Future Concept Asset

A Future Concept Asset is a named, intentional, non-runtime concept with a sponsor registry, concept purpose, review date, and graduation rules.

Unknown files are not Future Concept Assets.

## 2. Ownership Doctrine

Mental Smile follows:

```text
One Asset
One Owner
Many Consumers
```

An asset may be used in many places, but it must have exactly one owner registry.

Ownership follows meaning, not file location.

### Examples

- Logo: owned by BRANDING_SYSTEM, consumed by app shell, web shell, auth, and public pages.
- Client Room Background: owned by CLIENT_ROOM, consumed by Client Room and related personal spaces.
- Navigation Arrow: owned by ICONS_SYSTEM unless uniquely tied to one room theme.
- Exit Cup: owned by CLIENT_ROOM unless reused by two or more rooms, then evaluated for ROOM_SYSTEM.
- Placeholder: owned by PLACEHOLDER_SYSTEM, consumed by features that need empty or missing states.
- Theme Asset: owned by FUTURE_CONCEPTS while experimental, then graduates to CLIENT_ROOM or ROOM_SYSTEM when active.
- Branding Asset: owned by BRANDING_SYSTEM even if displayed inside another room.

### Ownership Rules

- No duplicate ownership.
- No asset may be active without an owner registry.
- Consumers may not copy assets to create private ownership.
- Runtime usage does not override constitutional ownership.
- A duplicate file is an alias or legacy copy, not a new owner.
- Platform-specific required resources may remain separate physical files while sharing one constitutional owner.

## 3. Official Registries

### CLIENT_ROOM

- Purpose: Own personal room visuals and client-controlled identity environment assets.
- Ownership Scope: Client room backgrounds, client-specific controls, personal room components, client identity visuals.
- Consumer Scope: Client Room, Personal Space, client journey surfaces.
- Retention Rules: Retain assets tied to identity, aspiration, support preference, growth, discovery, accessibility, or current room function.
- Migration Rules: Move only after room references, responsive variants, and fallback states are verified.

### CITY_SYSTEM

- Purpose: Own public city, library, and public content visual assets.
- Ownership Scope: City home visuals, library cards, content category art, public discovery visuals.
- Consumer Scope: City routes, library, public content and resource surfaces.
- Retention Rules: Dormant library assets must have a content destination or catalog reason.
- Migration Rules: Library assets migrate as CITY_SYSTEM/library, not as an independent registry.

### WEB_SYSTEM

- Purpose: Own platform and web shell assets that are not semantically owned by rooms or brand.
- Ownership Scope: Web shell visuals, platform icons, launch surfaces, install assets.
- Consumer Scope: Web app, platform manifests, browser shell, deployment surfaces.
- Retention Rules: Platform-density variants may remain separate when required by platform conventions.
- Migration Rules: Platform resources require manifest and build-path verification before movement.

### AUTH_SYSTEM

- Purpose: Own authentication and entry-flow visuals.
- Ownership Scope: Login, splash, language selection, account access visuals.
- Consumer Scope: Auth pages, splash pages, login shell, language gates.
- Retention Rules: Retain only while the auth or access flow consumes them.
- Migration Rules: Auth visuals migrate only with login/splash path updates.

### BRANDING_SYSTEM

- Purpose: Own Mental Smile brand identity.
- Ownership Scope: Logos, wordmarks, marks, brand promotional art.
- Consumer Scope: All surfaces that display brand identity.
- Retention Rules: One canonical brand asset per variant; superseded marks become brand history.
- Migration Rules: Brand duplicates consolidate only after channel-specific needs are documented.

### ICONS_SYSTEM

- Purpose: Own reusable icons and directional/action controls.
- Ownership Scope: Navigation arrows, action icons, status icons, platform icon families when semantically shared.
- Consumer Scope: All surfaces.
- Retention Rules: Icon families retain states together: idle, hover, focus, disabled, RTL if applicable.
- Migration Rules: Directional icons require LTR/RTL and accessibility verification.

### BACKGROUNDS_SYSTEM

- Purpose: Own shared backgrounds that are not room-specific.
- Ownership Scope: Menu backgrounds, shared shell backgrounds, public home backgrounds, global scene backgrounds.
- Consumer Scope: Shared shells, menus, public home, responsive layouts.
- Retention Rules: Responsive background families are retained as families.
- Migration Rules: Desktop, tablet, and mobile variants migrate together.

### PLACEHOLDER_SYSTEM

- Purpose: Own intentional empty, missing, locked, and fallback visuals.
- Ownership Scope: Empty states, missing media, locked state visuals, neutral placeholders.
- Consumer Scope: Directories, rooms, cards, library, media loaders, registration previews.
- Retention Rules: Placeholders must have an active fallback contract.
- Migration Rules: Placeholder migration requires replacement of arbitrary feature-local fallback images.

### PROVIDER_ROOM

- Purpose: Own clinician/provider visuals.
- Ownership Scope: Provider registration art, provider identity visuals, clinician room components, provider categories.
- Consumer Scope: Provider discovery, clinician registration, clinician room/profile.
- Retention Rules: Operational legacy action art is not retained as active provider room material.
- Migration Rules: Provider visuals migrate only after declaration/discovery consumer paths are mapped.

### CENTER_ROOM

- Purpose: Own center visuals.
- Ownership Scope: Center registration art, center category art, center room components, center capability visuals.
- Consumer Scope: Center discovery, center registration, center room/profile.
- Retention Rules: Booking, approval, queue, or operation-era visuals cannot remain active by rename.
- Migration Rules: Center visuals migrate by declaration/capability meaning, not by old operational naming.

### OWNER_ROOM

- Purpose: Own future owner room visuals without admin-control semantics.
- Ownership Scope: Owner-only constitutional visuals.
- Consumer Scope: Owner room and owner-only constitutional surfaces.
- Retention Rules: No asset sleeps here without an Owner card and explicit constitutional purpose.
- Migration Rules: Old admin/control-room visuals cannot migrate here by renaming.

### MONITORING_ROOM

- Purpose: Own observational signal, readiness, and safety visuals.
- Ownership Scope: Monitoring visualizations, safety observability art, signal health visuals.
- Consumer Scope: Monitoring room, safety observatory, signal observability surfaces.
- Retention Rules: Retain only while a signal or safety observation contract exists.
- Migration Rules: No asset may imply approval, assignment, or ownership authority.

### FUTURE_CONCEPTS

- Purpose: Hold named, intentional, non-runtime concept assets.
- Ownership Scope: Approved prototypes, theme concepts, experimental visual families.
- Consumer Scope: None in production until graduation.
- Retention Rules: Every concept requires a sponsor, concept ID, purpose, and review date.
- Migration Rules: Future concepts graduate only after a card, owner registry, complete asset family, and consumer exist.

### LEGACY_IMPORTS

- Purpose: Isolate historical snapshots, extinct runtime visuals, compatibility assets, duplicate source copies, and unresolved quarantine.
- Ownership Scope: Historical and non-active asset provenance.
- Consumer Scope: Historical documentation only.
- Retention Rules: Legacy remains historical; it is not active and not automatically dead.
- Migration Rules: Runtime must not import from LEGACY_IMPORTS. Legacy can be retired only after retention review.

## 4. Asset Lifecycle

### ACTIVE

- Meaning: A current runtime, route, platform resource, or visible consumer depends on the asset.
- Allowed Actions: Register, document consumers, prepare migration, verify references.
- Forbidden Actions: Delete without consumer migration; move without path updates; duplicate ownership.
- Promotion Rules: A dormant asset becomes active when a real consumer is added.
- Retirement Rules: Active becomes dormant or legacy only after all consumers are removed or migrated.

### DORMANT

- Meaning: Known and owned, but not currently visible or directly consumed.
- Allowed Actions: Retain with owner, reason, future consumer, and review date.
- Forbidden Actions: Leave ownerless; use as vague storage; treat as future concept without a concept ID.
- Promotion Rules: Dormant becomes active when consumed by a verified surface.
- Retirement Rules: Dormant becomes dead when purpose and retention expire.

### LEGACY

- Meaning: Historical, extinct, snapshot, compatibility, or previous-architecture asset.
- Allowed Actions: Preserve provenance, quarantine runtime use, classify duplicates, review retention.
- Forbidden Actions: Treat as active; migrate by renaming; use as new runtime source.
- Promotion Rules: Legacy cannot become active directly. A new constitutional asset must be created or explicitly re-carded with review.
- Retirement Rules: Legacy may enter deletion review only after historical retention is cleared.

### DEAD

- Meaning: No proven consumer and no active retention reason.
- Allowed Actions: Mark for deletion review, prove no references, verify no platform indirect use.
- Forbidden Actions: Delete without review; silently keep as dormant; use in runtime.
- Promotion Rules: Dead may become dormant only if a legitimate owner and purpose are proven.
- Retirement Rules: Dead may be deleted in a later cleanup wave after verification.

### UNCLASSIFIED

- Meaning: Asset identity or ownership is unknown.
- Allowed Actions: Quarantine, investigate origin, assign owner, or move to deletion review later.
- Forbidden Actions: Use in runtime; classify as future concept without named purpose; leave untracked.
- Promotion Rules: Unclassified becomes active, dormant, legacy, or dead after evidence-based classification.
- Retirement Rules: Unclassified cannot be deleted until classification is complete.

## 5. Asset Card Doctrine

Every asset card must include:

- Asset ID
- Asset Name
- Asset Type
- Owner Registry
- Consumers
- Current Path
- Canonical Path
- Status
- Lifecycle
- Migration Readiness
- Notes

### Rules

- No Asset Without Card.
- No Ownership Without Registry.
- No Consumer Without Reference.
- No active asset without proven consumer.
- No duplicate ownership for byte-identical or semantic duplicates.
- No file path becomes constitutional without an Asset Card.
- No migration happens without the card being updated first.

## 6. Asset Naming Doctrine

Asset names must be stable, semantic, uppercase, and version-aware when needed.

### Naming Pattern

```text
<OWNER>_<MEANING>_<VARIANT>_<VERSION>
```

Examples:

- CLIENT_ROOM_DESKTOP_BACKGROUND_V1
- CLIENT_ROOM_EXIT_CUP_BUTTON
- CLIENT_ROOM_NAV_LEFT_BUTTON
- MENTAL_SMILE_PRIMARY_LOGO
- EMPTY_TOOL_SLOT
- PHARAONIC_ROOM_THEME_V1

### Naming Rules

- Use registry or owning domain as the first segment.
- Use purpose, not temporary appearance.
- Add device variant only when the file is truly responsive-specific.
- Add version when a visual identity may evolve.
- Avoid implementation names that hide meaning.
- Avoid personal names unless the asset legally represents a named person or place.

### Forbidden Names

- final.png
- final2.png
- copy.png
- new_logo.png
- image_test.png
- temp.png
- old.png
- screenshot.png
- unnamed.png

## 7. Migration Governance

Assets can move only when:

- Asset Card exists.
- Owner registry is known.
- Canonical destination is known.
- Consumers are enumerated.
- Duplicate group is resolved.
- Pubspec/platform references are mapped.
- Rollback path is known.

### Who Approves Movement

Movement is approved by the owning registry doctrine and the current implementation wave owner. For protected shared assets, the affected consumer registry must also acknowledge the migration.

Monitoring may observe migration readiness. Monitoring does not approve movement.

### How Migration Is Recorded

Every migration records:

- Asset ID
- Previous path
- New canonical path
- Consumer references updated
- Pubspec/platform updates
- Duplicate aliases retired or retained
- Verification performed
- Rollback path

### How References Are Verified

Reference verification must include:

- Source search
- Pubspec search
- Platform manifest/resource search
- Runtime constant search
- Generated asset manifest search when available
- Duplicate path search

### How Rollback Is Performed

Rollback restores:

- Previous file path
- Previous references
- Previous pubspec/platform declarations
- Previous Asset Card migration state

Rollback must not restore extinct doctrine or legacy runtime.

## 8. Dormant Vault Doctrine

A Dormant Asset is allowed to sleep only when it has:

- Owner registry
- Asset Card
- Purpose
- Intended future consumer
- Review date
- Retention reason

### Review Cycle

Dormant assets are reviewed on each asset registry audit or before any migration wave touching their registry.

### Reactivation Rules

Dormant assets reactivate only when:

- A current consumer is added.
- The asset still matches registry purpose.
- Accessibility and responsive requirements are satisfied.
- Duplicate status is resolved.

### Expiration Rules

Dormant assets expire into deletion review when:

- Purpose is no longer valid.
- No future consumer exists.
- Review date passes without renewal.
- Asset conflicts with current doctrine.

### Future Concept Handling

Future concepts are not generic dormant storage. They require concept ID, sponsor, theme or feature purpose, expected consumers, and review date.

## 9. Legacy Import Doctrine

### Legacy Asset

A Legacy Asset is a known asset from a previous architecture, extinct runtime, or historical source.

### Historical Asset

A Historical Asset preserves project provenance and may remain immutable.

### Extinct Asset

An Extinct Asset belongs to a removed runtime, removed feature, or abolished doctrine.

### Compatibility Asset

A Compatibility Asset exists temporarily to avoid breaking current consumers during migration.

### Rules

- Legacy is not Active.
- Legacy is not Dead.
- Legacy is historical ownership.
- Legacy cannot gain runtime consumers.
- Legacy cannot be purified by renaming.
- Legacy may inspire a new constitutional asset, but the old file remains legacy unless explicitly re-carded.

## 10. Asset Observability

The asset system must track:

- Total Assets
- Active Assets
- Dormant Assets
- Legacy Assets
- Dead Assets
- Unclassified Assets
- Duplicate Groups
- Ownerless Assets
- Registry Distribution
- Migration Readiness

Optional future metrics:

- Assets by consumer
- Assets by route
- Assets by platform
- Assets by accessibility readiness
- Assets by duplicate risk
- Assets awaiting review
- Assets blocked by pubspec/platform references

## 11. Constitutional Restrictions

Forbidden:

- Unknown Assets
- Unnamed Assets
- Multiple Owners
- Untracked Migration
- Unregistered Assets
- Consumerless Active Assets
- Unclassified Runtime Assets
- Runtime imports from LEGACY_IMPORTS
- Future concepts without named purpose
- Deleting assets without deletion review
- Copying assets to create private feature ownership

## 12. Future Evolution

### Asset Factory

A future Asset Factory may create assets only from registry-approved briefs and must emit an Asset Card before runtime use.

### Theme Factory

A Theme Factory may create room theme families only when the full theme contract is known: background, controls, board, TV, notebook, profile screen, accessibility states, and fallback.

### Asset Validator

An Asset Validator checks names, paths, owners, duplicates, consumers, lifecycle, accessibility metadata, and registry fit.

### Asset Generator

An Asset Generator may generate images, icons, placeholders, or theme assets only under an approved owner registry and card.

### Asset Assistant

An Asset Assistant may answer:

- Who owns this asset?
- Where does it belong?
- Who consumes it?
- Can it move?
- Can it be deleted?
- Can it sleep as dormant?

### Future AI-Assisted Asset Governance

AI-assisted governance is allowed only when the output is auditable. AI may classify, suggest, generate, and validate, but cannot bypass ownership, lifecycle, reference verification, accessibility review, or migration governance.
