# Guide Card Pack V1

Card Pack ID: GUIDE_CARD_PACK_V1  
Source snapshot: GUIDE_SNAPSHOT_V1  
Status: SYSTEM_SYNC_PENDING  
Runtime effect: none

## 1. Card Pack Doctrine

This card pack is generated from the Master Guide System V1 snapshot. It is a governance artifact. It does not imply that missing runtime registries or FUTURE systems have been implemented.

## 2. Domain Card Counts

| Domain | Cards | Status |
| --- | ---: | --- |
| Master system | 1 | GUIDE_DRAFT |
| Cards | 14 | SYSTEM_SYNC_PENDING |
| Signals | 11 runtime signals + 5 signal families | SYSTEM_SYNC_PENDING |
| Surfaces | 16 | SYSTEM_SYNC_PENDING |
| Tools | 9 | SYSTEM_SYNC_PENDING |
| Roles | 8 | SYSTEM_SYNC_PENDING |
| Collections | 18 | SYSTEM_SYNC_PENDING |
| Language | 15 term-family cards | SYSTEM_SYNC_PENDING |
| Assets | 18 asset group cards | SYSTEM_SYNC_PENDING |
| Compliance | 9 lifecycle statuses | GUIDE_DRAFT |

## 3. Active Governance Cards

| Card ID | Domain | Object | Owner | Registry ref | Status | Classification |
| --- | --- | --- | --- | --- | --- | --- |
| CARD-MGS-001 | Master | Master Guide System | Owner | Guide docs | GUIDE_DRAFT | ACTIVE |
| CARD-CARD-001 | Cards | Menu cards | Shared navigation | MISSING_RUNTIME_CARD_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-CARD-002 | Cards | Client dashboard cards | client | MISSING_RUNTIME_CARD_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-CARD-003 | Cards | Personal space cards | client | MISSING_RUNTIME_CARD_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-CARD-004 | Cards | Signal board lane cards | signal governance | MISSING_RUNTIME_CARD_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-CARD-005 | Cards | Support cards | support_observer | MISSING_RUNTIME_CARD_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-CARD-006 | Cards | Declaration review cards | declaration_reviewer | MISSING_RUNTIME_CARD_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-CARD-007 | Cards | Registry domain cards | registry_steward | DomainRegistry + missing card registry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-CARD-008 | Cards | Monitoring cards | monitoring_operator | monitoring registries + missing card registry | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| CARD-CARD-009 | Cards | Owner cards | owner | owner capsule registry deleted | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| CARD-SIG-001 | Signals | goal_selected | signal governance | SignalTypeRegistry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SIG-002 | Signals | interest_selected | signal governance | SignalTypeRegistry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SIG-003 | Signals | accessibility_interest | signal governance | SignalTypeRegistry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SIG-004 | Signals | communication_preference_selected | signal governance | SignalTypeRegistry | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| CARD-SIG-005 | Signals | destination_saved | signal governance/client | SignalTypeRegistry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SIG-006 | Signals | provider_contact_started | signal governance/commercial | SignalTypeRegistry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SIG-007 | Signals | center_contact_started | signal governance/commercial | SignalTypeRegistry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SIG-008 | Signals | support_started | signal governance/support | SignalTypeRegistry | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| CARD-SIG-009 | Signals | library_category_opened | signal governance/content | SignalTypeRegistry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SIG-010 | Signals | provider_profile_opened | signal governance/commercial | SignalTypeRegistry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SIG-011 | Signals | center_profile_opened | signal governance/commercial | SignalTypeRegistry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SURF-001 | Surfaces | Client dashboard | client | Routes/AppRouter | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SURF-002 | Surfaces | Personal space | client | Routes/AppRouter | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SURF-003 | Surfaces | Specialist discovery | commercial | Routes/AppRouter | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SURF-004 | Surfaces | Center discovery | commercial | Routes/AppRouter | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SURF-005 | Surfaces | Web registration | declaration/commercial | Routes/AppRouter | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SURF-006 | Surfaces | Support room | support_observer/owner | Routes/AppRouter | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SURF-007 | Surfaces | Registry room | registry_steward/owner | Routes/AppRouter | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SURF-008 | Surfaces | Declaration review room | declaration_reviewer/owner | Routes/AppRouter | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-SURF-009 | Surfaces | Signal monitoring room | monitoring_operator | Routes/AppRouter | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| CARD-SURF-010 | Surfaces | Owner district | owner | Routes/AppRouter | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-TOOL-001 | Tools | Client library tool | client/content | MISSING_RUNTIME_TOOL_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-TOOL-002 | Tools | Saved destinations | client | SavedDestination model/repository | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-TOOL-003 | Tools | Signal communication board | client/signal governance | MISSING_RUNTIME_TOOL_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-TOOL-004 | Tools | Analytics summary writer | monitoring/admin | Cloud Function constants | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ROLE-001 | Roles | owner | owner | RoleNames/Firestore rules | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ROLE-002 | Roles | monitoring_operator | monitoring | RoleNames/Firestore rules | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ROLE-003 | Roles | registry_steward | registry | RoleNames/Firestore rules | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ROLE-004 | Roles | declaration_reviewer | declaration | RoleNames/Firestore rules | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ROLE-005 | Roles | support_observer | support | RoleNames/Firestore rules | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ROLE-006 | Roles | client | residential | RoleNames/Firestore rules | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ROLE-007 | Roles | center | commercial/center | RoleNames/Firestore rules | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ROLE-008 | Roles | clinician | commercial/provider | RoleNames/Firestore rules | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-COLL-001 | Collections | clients | client | MISSING_RUNTIME_COLLECTION_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-COLL-002 | Collections | clinicians | clinician/declaration | MISSING_RUNTIME_COLLECTION_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-COLL-003 | Collections | centers | center/declaration | MISSING_RUNTIME_COLLECTION_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-COLL-004 | Collections | support_requests | support_observer | MISSING_RUNTIME_COLLECTION_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-COLL-005 | Collections | signal_events | signal governance | MISSING_RUNTIME_COLLECTION_REGISTRY | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-LANG-001 | Language | Residential policy | Legal & Governance | localization docs | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-LANG-002 | Language | Commercial policy | Legal & Governance | localization docs | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-LANG-003 | Language | Administrative policy | Legal & Governance | localization docs | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-LANG-004 | Language | Surface term matrix | Legal & Governance | localization docs | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ASSET-001 | Assets | Branding assets | shared branding | AppAssets partial + docs | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ASSET-002 | Assets | Residential assets | client/content | docs asset registry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ASSET-003 | Assets | Commercial assets | commercial | docs asset registry | SYSTEM_SYNC_PENDING | ACTIVE |
| CARD-ASSET-004 | Assets | Legacy C5 assets | legacy | docs asset registry | OLD_CARD_SUSPENDED | LEGACY |

## 4. Suspended And Blocked Cards

| Card ID | Reason | Status |
| --- | --- | --- |
| CARD-ASSET-004 | Legacy C5 visual system remains but should not be treated as current source without validation. | OLD_CARD_SUSPENDED |
| CARD-TOOL-OLD-001 | Runtime tool registry deleted. | OLD_CARD_SUSPENDED |
| CARD-MON-STORAGE-001 | Monitoring storage runtime package deleted; `signal_aggregates` write-disabled. | OLD_CARD_SUSPENDED |
| CARD-LANG-DEBT-001 | Mojibake/hardcoded runtime language remains. | APPROVAL_BLOCKED |
| CARD-REG-MISSING-001 | Runtime card registry missing. | APPROVAL_BLOCKED |

## 5. Validation Status

| Check | Result |
| --- | --- |
| Generated from GUIDE_SNAPSHOT_V1 | PASS |
| Runtime code modified | NO |
| Missing runtime registries marked | PASS |
| FUTURE systems marked | PASS |
| Old deleted systems not represented as active | PASS |
| Ready for review | YES |

