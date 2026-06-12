# ASSET REGISTRY REFERENCE

Status: Reference  
Source: ASSET_CONSTITUTION_V1.md

## Official Registries

| Registry | Purpose | Owns | Consumers | Retention | Migration |
|---|---|---|---|---|---|
| CLIENT_ROOM | Personal room and client-controlled visual identity | Room backgrounds, client controls, identity visuals | Client Room, Personal Space | Retain identity, aspiration, support, growth, discovery, accessibility visuals | Migrate with room references and responsive variants |
| CITY_SYSTEM | Public city and library visuals | City home, library, content category art | City routes, library, public content | Dormant library art needs content destination | Library maps to CITY_SYSTEM/library |
| WEB_SYSTEM | Web/platform shell visuals | Web shell, platform icons, launch surfaces | Web app, manifests, install surfaces | Platform density variants may remain separate | Requires manifest/build verification |
| AUTH_SYSTEM | Authentication and entry visuals | Login, splash, language access visuals | Auth pages, splash, language gates | Retain only while access flow consumes | Migrate with auth path updates |
| BRANDING_SYSTEM | Mental Smile brand identity | Logos, wordmarks, marks, promotional brand art | All brand displays | One canonical asset per brand variant | Consolidate after channel policy |
| ICONS_SYSTEM | Reusable icons and controls | Navigation, actions, status icons | All surfaces | Retain state families together | Verify LTR/RTL/accessibility |
| BACKGROUNDS_SYSTEM | Shared non-room backgrounds | Menu, shell, public home backgrounds | Shared shells and menus | Responsive families retained together | Move variants together |
| PLACEHOLDER_SYSTEM | Empty and fallback visuals | Empty, missing, locked, neutral placeholders | Directories, cards, rooms, media loaders | Must have fallback contract | Replace feature-local fallbacks |
| PROVIDER_ROOM | Clinician/provider visuals | Provider registration, identity, categories | Provider discovery, clinician registration/room | Legacy operational art not active | Migrate by declaration/discovery meaning |
| CENTER_ROOM | Center visuals | Center registration, category, capability visuals | Center discovery, registration, room | Booking/approval/queue art not active | Migrate by capability/declaration meaning |
| OWNER_ROOM | Future owner room visuals | Owner-only constitutional visuals | Owner room | Requires Owner card and purpose | Old admin visuals cannot migrate here by rename |
| MONITORING_ROOM | Observational signal and safety visuals | Signal health, readiness, safety observability | Monitoring room, safety observatory | Must map to signal/safety observation | Cannot imply approval/assignment/ownership |
| FUTURE_CONCEPTS | Named non-runtime concepts | Theme concepts, approved prototypes | None in production | Requires sponsor, concept ID, review date | Graduates only after card and consumer exist |
| LEGACY_IMPORTS | Historical and extinct imports | Snapshots, extinct runtime, compatibility, quarantine | Historical documentation only | Legacy is historical, not active | Runtime must not import from here |

## Registry Selection Rules

1. Logo assets belong to BRANDING_SYSTEM.
2. Directional arrows belong to ICONS_SYSTEM unless uniquely tied to a room theme.
3. Cup exit button belongs to CLIENT_ROOM unless reused by two or more rooms.
4. Client room background belongs to CLIENT_ROOM.
5. Future unused theme art belongs to FUTURE_CONCEPTS only if it has a named purpose.
6. Unknown files go to LEGACY_IMPORTS/unclassified_quarantine.
7. Shared backgrounds belong to BACKGROUNDS_SYSTEM.
8. Placeholders belong to PLACEHOLDER_SYSTEM.
9. Historical and extinct runtime visuals belong to LEGACY_IMPORTS.
10. A current path does not determine ownership by itself.

## Empty Registry Rule

A registry may intentionally have zero assets. Empty is valid when:

- The registry has a defined purpose.
- No current asset meets that purpose.
- No unrelated asset is forced into it.

Owner Room and Monitoring Room may remain empty until constitutional visual contracts exist.

## Duplicate Ownership Rule

Duplicate bytes do not create duplicate ownership.

One duplicate group must resolve to:

- One canonical asset, or
- Explicit KEEP_SEPARATE status when identical bytes represent different semantic meanings.

## Legacy Boundary

LEGACY_IMPORTS is not a runtime registry. It is a containment registry for history, extinct runtime, compatibility, and quarantine.

No asset in LEGACY_IMPORTS may be treated as active without a new constitutional review.
