# Master Signal Guide V1

Status: GUIDE_DRAFT  
Runtime effect: none

## 1. Signal Doctrine

Signals are observations, declarations, preferences, readiness facts, safety indicators, or monitoring inputs. Current runtime has a signal package, signal type registries, signal storage to `signal_events`, in-memory aggregation, and residential/commercial monitoring registries.

## 2. Runtime Signal Registries

| Registry | Runtime path | Owner | Status | Classification |
| --- | --- | --- | --- | --- |
| SignalTypeRegistry | `lib/features/signals/domain/registries/signal_type_registry.dart` | Signal governance | Active | ACTIVE |
| SignalCategoryRegistry | `lib/features/signals/domain/registries/signal_category_registry.dart` | Signal governance | Active | ACTIVE |
| SignalRoutingTarget | `lib/features/signals/domain/registries/signal_routing_target.dart` | Signal governance | Active | ACTIVE |
| SignalPrivacyLevel | `lib/features/signals/domain/registries/signal_privacy_level.dart` | Signal governance/security | Active | ACTIVE |
| SignalRetentionClass | `lib/features/signals/domain/registries/signal_retention_class.dart` | Signal governance/archive | Active | ACTIVE |
| SignalAggregationCategoryRegistry | `lib/features/signals/domain/registries/signal_aggregation_category_registry.dart` | Monitoring | Active | ACTIVE |
| ResidentialMonitoringRegistry | `lib/features/monitoring/residential/domain/residential_monitoring_registry.dart` | Monitoring/residential | Active | ACTIVE |
| CommercialMonitoringRegistry | `lib/features/monitoring/commercial/registry/commercial_monitoring_registry.dart` | Monitoring/commercial | Active | ACTIVE |

## 3. Runtime Signal Package

| Field | Meaning |
| --- | --- |
| signalId | Unique event ID. |
| signalType | Type from registry or extension group. |
| signalCategory | Category such as goal, interest, contact, library. |
| signalDomain | residential, commercial, support, or other governed domain. |
| signalSource | Source surface/service. |
| actorId | User UID or actor identifier. |
| actorRole | Role of actor. |
| targetType | Target object family. |
| targetId | Target object ID or selected signal key. |
| timestamp | Event time stored by package as ISO string. |
| routingTarget | Monitoring destination. |
| retentionClass | Retention policy. |
| privacyLevel | Privacy level. |
| signalVersion | Package version. |

## 4. Current Runtime Signals

| Signal ID | Domain | Category | Producer | Consumer | Status | Classification |
| --- | --- | --- | --- | --- | --- | --- |
| goal_selected | residential | goal | Client registration | residential monitoring, personal space | Active | ACTIVE |
| interest_selected | residential | interest | Client registration | residential monitoring, recommendations lane | Active | ACTIVE |
| accessibility_interest | residential | accessibility | Client registration | residential monitoring | Active | ACTIVE |
| communication_preference_selected | residential | communication | Client registration | signal_events only; aggregation gap | Active with gap | TRANSITIONAL |
| destination_saved | residential | destination | SavedDestinationRepository | client dashboard, signal board, monitoring | Active | ACTIVE |
| provider_contact_started | commercial | contact | Signal factory/contact flows | commercial monitoring | Active | ACTIVE |
| center_contact_started | commercial | contact | Signal factory/contact flows | commercial monitoring | Active | ACTIVE |
| support_started | support | support | Signal factory/support flows | support monitoring target; aggregation gap | Active with gap | TRANSITIONAL |
| library_category_opened | residential | library | Signal factory/library | residential monitoring | Active | ACTIVE |
| provider_profile_opened | commercial | capability | Signal factory/provider discovery | commercial monitoring | Active | ACTIVE |
| center_profile_opened | commercial | capability | Signal factory/center discovery | commercial monitoring | Active | ACTIVE |

## 5. Declaration Signal Families

| Family | Source | Registry state | Consumer | Status |
| --- | --- | --- | --- | --- |
| Client self-expression | `ClientRegisterPage` page-local options | MISSING_RUNTIME_OPTION_REGISTRY | clients doc, signal_events | ACTIVE |
| Provider declaration | `WebClinicianRegisterPortalPage` page-local options | MISSING_RUNTIME_OPTION_REGISTRY | clinicians doc, declaration review | ACTIVE |
| Center declaration | `DeclarationReadiness` plus web center pages | PARTIAL_RUNTIME_DOMAIN | centers doc, declaration review | ACTIVE |
| Chat safety | chat models/services | NO CENTRAL SIGNAL REGISTRY | chat_escalations, support observer | ACTIVE |
| Monitoring aggregate | signal aggregation engine and monitoring adapters | DUAL_PATH | monitoring feeds/snapshots | TRANSITIONAL |

## 6. Signal To Consumer Map

| Signal/record | Consumer | Report | Action |
| --- | --- | --- | --- |
| clientSignals | Client dashboard, personal space | Residential guide report | Validate labels and language. |
| providerSignals | Clinician profile/declaration review | Commercial guide report | Verify attribution and readiness. |
| center declarationSignals | Center profile/declaration review | Commercial guide report | Verify readiness completeness. |
| signal_events | Signal board, monitoring readers | Monitoring guide report | Verify timestamp/query and privacy. |
| signal_aggregates | FUTURE monitoring persistence | Monitoring guide report | Mark write-disabled gap. |
| chat safety fields | Escalation surfaces | Support safety report | Verify no hidden treatment authority. |

## 7. Known Signal Gaps

| Gap | Impact | Required guide status |
| --- | --- | --- |
| No runtime registry for client option keys | Option ownership is page-local. | APPROVAL_BLOCKED for generated cards until mapped. |
| No runtime registry for provider signal options | Provider declarations not centrally governed. | SYSTEM_SYNC_PENDING. |
| Support and communication categories not mapped in generic aggregation engine | Monitoring can miss valid signal families. | TRANSITIONAL. |
| `signal_aggregates` write disabled | Persistent aggregate pipeline is not implemented. | FUTURE/TRANSITIONAL. |
| Chat safety signals not unified with SignalTypeRegistry | Safety signals are model fields, not signal package entries. | TRANSITIONAL. |

