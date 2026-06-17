# RESIDENTIAL_ARCHITECTURE_REPORT_V1

Status: ACTIVE_DOMAIN_AUDIT
Phase: 7A
Runtime effect: none

## Scope

Residential Domain includes Client Room, Personal Space, Chat, Support Room, Saved Destinations, Residential Signals, Residential Collections, Residential Routes, Residential Assets, Residential Localization, and Residential Dependencies.

## Active Architecture

| Surface/System | Primary Files | Status |
| --- | --- | --- |
| Client Room | `lib/features/client/presentation/pages/client_dashboard_page.dart` | ACTIVE |
| Personal Space | `lib/features/s_personal_space/presentation/pages/s_personal_space_page.dart` | ACTIVE |
| Signal Communication Board | `lib/features/s_personal_space/presentation/widgets/signal_communication_board.dart` | ACTIVE |
| Chat | `lib/features/chat/presentation/pages/chat_page.dart` | ACTIVE |
| Chat Controller | `lib/features/chat/controller/chat_controller.dart` | ACTIVE |
| Chat Firestore Service | `lib/features/chat/data/services/chat_firestore_service.dart` | ACTIVE |
| Chat Models | `lib/features/chat/data/models/*.dart` | ACTIVE |
| Support Room | `lib/features/s_support_room/presentation/pages/s_support_room_page.dart` | ACTIVE |
| Support Issue Selector | `lib/features/modules/presentation/pages/support_issue_selector_page.dart` | ACTIVE |
| Support Entry | `lib/features/modules/presentation/pages/support_entry_page.dart` | ACTIVE |
| Saved Destinations | `lib/features/saved_destinations/**` | ACTIVE |

## Responsibilities

- Client Room: residential hub, signal preview, navigation, saved destination access, support entry.
- Personal Space: read-only personal signal overview and continuity surface.
- Chat: structured support conversation and escalation source.
- Support Room: read-only support request observation.
- Saved Destinations: client-owned continuation bookmarks with signal tags.

## Dependencies

| Dependency | Purpose | Status |
| --- | --- | --- |
| Firebase Auth | current user identity | ACTIVE |
| Cloud Firestore | clients, support, chat, signals, saved records | ACTIVE |
| App Router | route ownership and role gates | ACTIVE |
| Role Access Gateway | role authorization | ACTIVE |
| Signals package | signal types and storage | ACTIVE |
| Asset path utility | image path normalization | ACTIVE |
| Shared UI kit | surface styling | ACTIVE |
| Flutter localization runtime | locale detection and route fallback strings | PARTIAL |

## Measures

| Classification | Items |
| --- | --- |
| Active | Client Room, Personal Space, Chat, Support Room, Saved Destinations, Support Issue Selector |
| Legacy | Provider naming in wider topology; booking-era language risk outside direct residential code |
| Dead | none confirmed |
| Unknown | dedicated residential registry, dedicated signal registry, complete localization coverage |
| Duplicate | support entry and support issue selector overlap as residential support entry points |
| Missing | Residential boundary card, residential registry update, signal ownership registry |

## Architecture Health

The Residential Domain is active and coherent. Its strongest areas are route presence, collection presence, and signal continuity. Its weakest areas are localization consistency, registry hardening, and boundary clarity between support, monitoring, and chat.
