# Accessibility Directory Layer V1 Plan

## Purpose

Accessibility Directory Layer V1 creates an initial resource and navigation layer for Mental Smile users with different accessibility needs. It keeps one shared Mental Smile city while providing different access paths into trusted, categorized links and passive observability signals.

Core doctrine: Mental Smile does not separate users. Mental Smile provides different access paths into the same city.

## Scope

- Add a new `lib/features/accessibility/` domain.
- Define Firestore-ready resource models for the `accessibility_resources` collection.
- Define category, disability type, resource type, communication mode, and signal type enums.
- Provide V1 registries for categories, resource type labels, icons, and passive signals.
- Add `/accessibility` as a public named route.
- Add `AccessibilityHubPage` with eight category cards.
- Add `AccessibilityResourceListPage` for category resource listing.
- Add `AccessibilitySignalFactory` for SignalPackage-compatible passive events.
- Use static sample resources only as UI scaffolding until content governance and verification exist.

## Non-Goals

- No diagnosis.
- No medical claims.
- No treatment promises.
- No booking, session, or payment logic.
- No admin approval workflow.
- No provider verification workflow.
- No separate app, deaf-only portal, or segregated accessibility portal.
- No videos, sign-language glossary, or specialized clinical content in V1.

## Proposed File Tree

```text
lib/features/accessibility/
  data/
    accessibility_sample_resources.dart
  domain/
    factories/
      accessibility_signal_factory.dart
    models/
      accessibility_category.dart
      accessibility_communication_mode.dart
      accessibility_disability_type.dart
      accessibility_resource.dart
      accessibility_resource_type.dart
      accessibility_signal_type.dart
    registries/
      accessibility_category_registry.dart
      accessibility_icon_registry.dart
      accessibility_resource_type_registry.dart
      accessibility_signal_registry.dart
  presentation/
    pages/
      accessibility_hub_page.dart
      accessibility_resource_list_page.dart
```

Shared route and signal compatibility updates:

```text
lib/app/router/routes.dart
lib/app/router/app_router.dart
lib/features/signals/domain/registries/signal_type_registry.dart
```

## Collections

### `accessibility_resources`

Fields:

| Field | Type | Notes |
| --- | --- | --- |
| `id` | string | Document id or mirrored id. |
| `titleAr` | string | Arabic resource title. |
| `titleEn` | string | English resource title. |
| `descriptionAr` | string | Arabic short description. |
| `descriptionEn` | string | English short description. |
| `category` | string | One accessibility category key. |
| `disabilityType` | string | Support classification, not diagnosis. |
| `country` | string | Country or `Global`. |
| `language` | string | Resource language code/list. |
| `resourceType` | string | Government, NGO, library, etc. |
| `url` | string | External trusted link. |
| `tags` | array<string> | Discovery tags only. |
| `isVerified` | bool | Display badge only in V1. |
| `isActive` | bool | Client-side visibility filter. |
| `createdAt` | timestamp/string | Firestore-ready timestamp field. |
| `updatedAt` | timestamp/string | Firestore-ready timestamp field. |

## Models

- `AccessibilityResource`: Firestore-ready data model with `fromFirestore`, `fromMap`, and `toMap`.
- `AccessibilityCategory`: eight V1 categories.
- `AccessibilityDisabilityType`: support classification keys that must not be treated as diagnosis.
- `AccessibilityResourceType`: government, NGO, association, library, international, educational, complaint channel, emergency, and accessibility tool.
- `AccessibilitySignalType`: six passive observability event names.
- `AccessibilityCommunicationMode`: V1 values `standard`, `simplified`, `accessibility`; future values documented but not activated as product modes.

## Routes

- `/accessibility`
  - No arguments: opens `AccessibilityHubPage`.
  - With `{'category': '<category_key>'}`: opens `AccessibilityResourceListPage`.

The route is public and does not create a separate application or role-scoped portal.

## UI Component Plan

### `AccessibilityHubPage`

Contains eight cards:

- Deaf & Hard of Hearing
- Blind & Low Vision
- Mobility Support
- Learning & Cognitive Support
- Autism & Neurodiversity
- Mental Health & Addiction Support
- Rights & Complaints
- Global Libraries

Each card includes:

- Icon
- Arabic title
- English title
- Short Arabic/English description
- Resource count placeholder
- Open button

### `AccessibilityResourceListPage`

Each resource card includes:

- Title
- Description
- Country
- Resource type
- Verified badge when `isVerified == true`
- Open link button
- Save button placeholder
- Report broken link button placeholder

The save and report actions emit passive signals only. They do not persist saved resources, create moderation queues, or create admin authority in V1.

## Signal Integration Plan

Signals are observability-only and use the existing Mental Smile Signal Federation path through `SignalPackage`.

V1 signals:

- `accessibility_hub_opened`
- `accessibility_category_opened`
- `accessibility_resource_opened`
- `accessibility_resource_saved`
- `accessibility_resource_broken_link_reported`
- `accessibility_mode_selected`

Signal payload doctrine:

- `signalType`
- `sourceSurface: accessibility`
- `category`
- `disabilityType`
- `resourceId` optional
- `userId` optional
- `timestamp`
- `privacyLevel: internal_aggregate`
- `retentionClass: raw_short_term`

Implementation notes:

- `AccessibilitySignalFactory` creates SignalPackage-compatible events.
- No operational authority is introduced.
- No admin approval, booking, session, payment, or workflow state is introduced.
- Anonymous browsing uses a neutral actor id only to satisfy the existing signal validator; it is not a diagnosis or identity assertion.

## Privacy Doctrine

- No medical condition should be inferred from browsing.
- No diagnosis should be stored.
- No sensitive disability identity should be forced.
- Choosing an accessibility browsing mode is a preference, not a diagnosis.
- `disabilityType` is a resource taxonomy field, not a user identity field.
- `communicationMode` values for V1:
  - `standard`
  - `simplified`
  - `accessibility`
- Optional future values:
  - `deaf_mode`
  - `blind_mode`
  - `easy_language`

## Future Expansion Phases

Mentioned for planning only, not implemented in V1:

- Deaf Mode UI
- Sign Language Glossary
- Egyptian Sign Language video cards
- Screen reader optimization
- Provider accessibility filters
- NGO partnership onboarding
- Accessibility content governance
- Accessibility resource verification workflow

## Final Verification Checklist

- [x] New accessibility domain scaffolded under `lib/features/accessibility/`.
- [x] Required models created.
- [x] Firestore-ready `AccessibilityResource` model created for `accessibility_resources`.
- [x] Eight main categories registered.
- [x] Nine resource types registered.
- [x] `/accessibility` route added.
- [x] Hub and resource list UI scaffolded.
- [x] Passive accessibility signal factory added.
- [x] Shared signal type registry updated for validator compatibility.
- [x] No booking/session/payment/admin logic added.
- [x] No Firebase deployment, commit, push, or destructive runtime change performed.
