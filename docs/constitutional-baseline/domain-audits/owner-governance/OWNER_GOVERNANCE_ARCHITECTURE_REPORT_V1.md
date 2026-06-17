# OWNER_GOVERNANCE_ARCHITECTURE_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7F
Runtime effect: none

## Scope

Owner and Governance Domain includes Owner Room, Registry Room, Declaration Review, Guides, Cards, Registries, Snapshots, Archives, and Operations Registry.

## Active Runtime Surfaces

| Surface | Primary Files | Authority | Classification | Health |
| --- | --- | --- | --- | --- |
| Owner District | `lib/features/s_owner/presentation/pages/s_owner_district_page.dart` | Owner | ACTIVE | PASS |
| Registry Room | `lib/features/s_registry_room/presentation/pages/s_registry_room_page.dart` | Owner / Registry Steward | ACTIVE_READ_ONLY | PASS |
| Declaration Review Room | `lib/features/s_declaration_review_room/presentation/pages/s_declaration_review_room_page.dart` | Owner / Declaration Reviewer | ACTIVE_READ_ONLY | PASS |
| Sovereign Construction Workbench | `lib/features/sovereign_construction/**` | Owner | ACTIVE_PROTECTED | WARNING |
| Owner routes | `lib/app/router/routes.dart`, `app_router.dart` | Owner | ACTIVE | PASS |

## Owner Routes

| Route | Surface | Classification |
| --- | --- | --- |
| `/s/owner` | Owner home | ACTIVE |
| `/s/owner/room` | Owner room | ACTIVE |
| `/s/owner/sovereign-intelligence` | Sovereign intelligence | ACTIVE |
| `/s/owner/strategic-memory` | Strategic memory | ACTIVE |
| `/s/owner/sovereign-vault` | Sovereign vault | ACTIVE |
| `/s/owner/constitutional-memory` | Constitutional memory | ACTIVE |
| `/s/owner/recovery-console` | Recovery console | ACTIVE |
| `/s/owner/capsules` | Owner capsules | ACTIVE |
| `/s/owner/regeneration` | Regeneration board | ACTIVE |
| `/owner/os/construction-workbench` | Construction workbench | ACTIVE_PROTECTED |
| `/s/registry-room` | Registry room | ACTIVE_READ_ONLY |
| `/s/declaration-review-room` | Declaration review room | ACTIVE_READ_ONLY |

## Governance Document Layer

| Layer | Count | Classification |
| --- | ---: | --- |
| Guides | 6 | ACTIVE |
| Archive cards | 6 | ACTIVE |
| Baseline registries | 6 | ACTIVE |
| Snapshots | 3 | ACTIVE |
| Operations files | 7 | ACTIVE |
| Topology files | 10 | ACTIVE |
| Inventory files | 10 | ACTIVE |
| Domain audit reports before 7F | 30 | ACTIVE |

## Measures

| Classification | Items |
| --- | --- |
| Active | Owner room, registry room, declaration review, governance docs, operation logging |
| Legacy | old repository lineage, admin zero transition, booking/C5/C6 archive cards |
| Dead | none confirmed |
| Duplicate | governance appears in runtime rooms and file-backed docs |
| Unknown | Owner approval registry, formal archive card registry for recommended future cards |

## Architecture Health

Owner/Governance architecture is strong and now heavily documented. The strongest part is operation logging and baseline documents. The main weakness is that several recommended registries are still proposed rather than materialized.
