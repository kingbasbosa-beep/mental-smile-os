# Master Tool Guide V1

Status: GUIDE_DRAFT  
Runtime effect: none

## 1. Tool Doctrine

A tool is a user-facing or administrative mechanism that enables navigation, saving, observation, reporting, or governance. A tool must not diagnose, assign, approve treatment, book sessions, or own a client journey.

## 2. Tool Registry State

| Registry | Runtime state | Guide classification |
| --- | --- | --- |
| Runtime tool registry | Deleted from working tree: `lib/features/tools/tool_registry.dart` | FROZEN |
| Tool meter federation | Deleted from working tree | FROZEN |
| Client dashboard tool specs | UI-local `_ToolSpec` | TRANSITIONAL |
| Saved destination repository | Runtime repository | ACTIVE |
| Signal communication board | Runtime widget/tool | ACTIVE |
| Analytics summary writer | Cloud Function backend tool | ACTIVE |

## 3. Current Tools

| Tool ID | Name | Owner | Surface | Registry | Produces | Consumes | Status | Classification |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| tool.client.library | Library tool | Client/content | Residential | UI-local | navigation to library | route | SYSTEM_SYNC_PENDING | ACTIVE |
| tool.client.saved | Saved destinations | Client | Residential | repository model | saved_destination docs and summaries | destination action | SYSTEM_SYNC_PENDING | ACTIVE |
| tool.client.support | Support selector | Support/client | Residential/support | route arg validation | support_requests | supportType | SYSTEM_SYNC_PENDING | ACTIVE |
| tool.client.city | City exploration | Public/commercial | Residential/public | UI-local | navigation | city routes | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| tool.client.add_tool | Add tool placeholder | Client | Residential | UI-local | placeholder card | none | SYSTEM_SYNC_PENDING | FUTURE |
| tool.signal_board | Signal communication board | Signal governance/client | Personal space | missing tool registry | lane cards | signal_events | SYSTEM_SYNC_PENDING | ACTIVE |
| tool.analytics_writer | Analytics summary writer | Monitoring/admin | Backend | function constants | analytics_summaries | BigQuery events | SYSTEM_SYNC_PENDING | ACTIVE |
| tool.domain_status_seeder | Domain status seeder | Registry/owner | Dev/admin | dev script | system_domains | local definitions | SYSTEM_SYNC_PENDING | TRANSITIONAL |
| tool.ai_policy_seeder | AI policy seeder | Admin/AI policy | Dev/admin | dev script | ai_policies | seed definitions | SYSTEM_SYNC_PENDING | UNKNOWN |

## 4. Tool Language Constraints

| Surface | Allowed | Blocked |
| --- | --- | --- |
| Residential | explore, save, learn, contact, choose, support, resource | book, assign, diagnose, approve, treatment plan |
| Commercial | declared service info, contact, save destination | platform booking, platform endorsement, payment authority |
| Administrative | observe, report, analyze, verify, preserve | assign person, accept/reject case, operate treatment |
| Owner | authorize doctrine, preserve archive, review strategy | individual clinical/treatment decision |
| Monitoring | verify signals, detect drift, report mismatch | execute runtime change, approve cards |

## 5. Tool Relationship Map

| Domain | Guide | Registry | Card | Tool | Consumer | Report | Action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Residential | Tool guide | missing runtime tool registry | client tool cards | library/saved/support/city | client dashboard | card pack | create governance cards |
| Commercial | Tool guide | missing tool registry | contact/save cards | contact request/save destination | center/specialist pages | commercial report | ensure attribution |
| Administrative | Tool guide | dev scripts | seeder/admin cards FUTURE | seeders | registry room/backend | admin report | mark dev-only |
| Monitoring | Tool guide | function constants | analytics card FUTURE | analytics writer | monitoring admin | monitoring report | verify function docs |

