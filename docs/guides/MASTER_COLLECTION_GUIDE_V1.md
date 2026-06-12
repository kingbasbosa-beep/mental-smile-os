# Master Collection Guide V1

Status: GUIDE_DRAFT  
Runtime effect: none

## 1. Collection Doctrine

Firestore collections are governed data surfaces. This guide documents observed collections and authority boundaries; it does not change Firestore rules. Runtime collection names are currently scattered across services, pages, and rules. There is no central runtime collection registry.

## 2. Collection Registry State

| Registry need | Current reality | Guide status |
| --- | --- | --- |
| Runtime collection registry | Missing | SYSTEM_SYNC_PENDING |
| Firestore rules | Present in `firestore.rules` | ACTIVE |
| Collection ownership docs | This guide and snapshot | GUIDE_DRAFT |
| Client SDK access | Spread across pages/services | ACTIVE with governance gap |
| Backend access | Cloud Function writes analytics summaries | ACTIVE |

## 3. Current Collections

| Collection ID | Owner | Producers | Consumers | Rules authority | Surface | Classification |
| --- | --- | --- | --- | --- | --- | --- |
| clients | client/residential | client registration, client updates | client dashboard, personal space, access service | own create/update/read constraints | Residential | ACTIVE |
| clinicians | clinician/declaration | clinician web registration/profile/docs | specialists, clinician room, declaration review, access service | self until ready; public if ready; declaration reviewer read | Commercial/provider | ACTIVE |
| centers | center/declaration | center web registration/profile/media/pricing/docs | centers pages, center room/dashboard, declaration review | self until ready; public if ready; declaration reviewer read | Commercial/center | ACTIVE |
| clinician_profile_change_requests | declaration reviewer | clinician room/profile request | declaration review, clinician self | create-only by clinician; read reviewer/self | Administrative/provider | ACTIVE |
| center_profile_change_requests | declaration reviewer | center room/profile request | declaration review, center self | create-only by center; read reviewer/self | Administrative/center | ACTIVE |
| support_requests | support observer | support issue selector | support room, creator | create by signed-in structured support; read support observer/creator | Support | ACTIVE |
| provider_contact_requests | support/commercial | contact request repository | support observer/client/provider | create by client; read related parties | Commercial/support | ACTIVE |
| center_contact_requests | support/commercial | contact request repository | support observer/client/center | create by client; read related parties | Commercial/support | ACTIVE |
| saved_destinations | client | saved destination repository | client dashboard, repository watchers | create/update by client; read support observer/client | Residential | ACTIVE |
| chat_threads | support/chat | chat page/service | chat page, support observer | participant/support observer read/update bounds | Support | ACTIVE |
| chat_threads.messages | support/chat | chat page/service | chat page, support observer | signed-in create; participant/support read | Support | ACTIVE |
| chat_escalations | support/safety | chat service/escalation creation | safety pages, recommended clinicians | support observer/recommended clinician read; resolved update | Support/monitoring | ACTIVE |
| chat_escalations.reports | support/safety | chat service/report page | report pages | signed-in create; restricted read | Support/monitoring | ACTIVE |
| system_domains | owner/registry steward | dev seeder/backend ops | registry room/domain status service | read owner/registry steward; client write false | Administrative | ACTIVE |
| signal_events | signal governance | signal storage service | signal board, owner/monitoring/support readers | actor create/read; owner/monitoring/support read | Monitoring/shared | ACTIVE |
| signal_aggregates | monitoring | FUTURE backend or none observed | monitoring/owner | read owner/monitoring; write false | Monitoring | TRANSITIONAL |
| analytics_summaries | monitoring/admin | Cloud Function | no Flutter consumer observed | falls to deny for client | Monitoring/backend | TRANSITIONAL |
| ai_policies | admin/AI policy | dev seeder | no runtime consumer observed | falls to deny for client | Administrative | UNKNOWN |

## 4. Collection Relationship Map

| Domain | Guide | Registry | Card | Collection | Consumer | Report | Action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Residential | Collection guide | missing runtime collection registry | client/saved/signal cards | clients, saved_destinations, signal_events | client dashboard, personal space | residential collection report | mark missing registry |
| Commercial | Collection guide | missing runtime collection registry | provider/center cards | clinicians, centers, contact requests | specialists, centers, registration | commercial collection report | validate attribution/readiness |
| Administrative | Collection guide | Firestore rules, missing central registry | support/declaration/registry cards | support_requests, profile requests, system_domains | S rooms | admin report | verify rules vs guide |
| Monitoring | Collection guide | signal registries | monitoring cards | signal_events, signal_aggregates, analytics_summaries | signal board, monitoring | monitoring report | mark persistence gaps |
| Legal & Governance | Collection guide | language/authority docs | compliance cards | all governed collections | guide system | compliance report | interpret boundaries |
| Technical | Collection guide | runtime string literals | implementation cards FUTURE | all collections | runtime code | implementation report | execute only in future block |

## 5. Collection Gaps

| Gap | Impact | Required card status |
| --- | --- | --- |
| No collection registry | Ownership cannot be resolved mechanically. | SYSTEM_SYNC_PENDING |
| `storage.rules` referenced but not observed in root listing | Firebase config drift. | APPROVAL_BLOCKED until verified |
| `signal_aggregates` write disabled | Monitoring persistence is FUTURE. | TRANSITIONAL |
| `analytics_summaries` no Flutter consumer observed | Backend output may be orphaned in app. | TRANSITIONAL |
| `ai_policies` seeded but not ruled/routed | Admin AI policy surface unknown. | UNKNOWN |

