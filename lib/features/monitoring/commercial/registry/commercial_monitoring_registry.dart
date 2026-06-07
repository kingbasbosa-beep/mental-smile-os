import 'package:flutterprojects/features/signals/domain/registries/signal_type_registry.dart';

import '../aggregates/commercial_signal_aggregate.dart';

class CommercialMonitoringRegistry {
  const CommercialMonitoringRegistry._();

  static const String providerSaved = 'provider_saved';
  static const String providerSpecializationDeclared =
      'provider_specialization_declared';
  static const String providerServiceDeclared = 'provider_service_declared';
  static const String providerCapabilityDeclared =
      'provider_capability_declared';
  static const String verificationRequested = 'verification_requested';
  static const String verificationViewed = 'verification_viewed';

  static const String centerProfileOpened = 'center_profile_opened';
  static const String centerSaved = 'center_saved';
  static const String centerProgramDeclared = 'center_program_declared';
  static const String centerServiceDeclared = 'center_service_declared';
  static const String centerSpecialtyDeclared = 'center_specialty_declared';

  static const String marketingServiceViewed = 'marketing_service_viewed';
  static const String marketingServiceRequested = 'marketing_service_requested';
  static const String technicalServiceViewed = 'technical_service_viewed';
  static const String technicalServiceRequested = 'technical_service_requested';
  static const String verificationServiceViewed =
      'verification_service_viewed';
  static const String verificationServiceRequested =
      'verification_service_requested';

  static const String toolOpened = 'tool_opened';
  static const String toolSaved = 'tool_saved';
  static const String toolRequested = 'tool_requested';
  static const String toolAdded = 'tool_added';
  static const String toolRemoved = 'tool_removed';
  static const String toolReplaced = 'tool_replaced';
  static const String toolRequestedWithoutAvailability =
      'tool_requested_without_availability';

  static const String externalAppViewed = 'external_app_viewed';
  static const String externalAppOpened = 'external_app_opened';
  static const String externalAppSaved = 'external_app_saved';
  static const String externalKnowledgeViewed = 'external_knowledge_viewed';
  static const String partnerResourceViewed = 'partner_resource_viewed';

  static const Set<String> providerDemandSignals = <String>{
    SignalTypeRegistry.providerProfileOpened,
    SignalTypeRegistry.providerContactStarted,
    providerSaved,
  };

  static const Set<String> providerCapabilitySignals = <String>{
    providerSpecializationDeclared,
    providerServiceDeclared,
    providerCapabilityDeclared,
  };

  static const Set<String> providerVerificationSignals = <String>{
    verificationRequested,
    verificationViewed,
  };

  static const Set<String> centerDemandSignals = <String>{
    centerProfileOpened,
    SignalTypeRegistry.centerContactStarted,
    centerSaved,
  };

  static const Set<String> centerCapabilitySignals = <String>{
    centerProgramDeclared,
    centerServiceDeclared,
    centerSpecialtyDeclared,
  };

  static const Set<String> centerVerificationSignals = <String>{
    verificationRequested,
    verificationViewed,
  };

  static const Set<String> marketingServiceSignals = <String>{
    marketingServiceViewed,
    marketingServiceRequested,
  };

  static const Set<String> technicalServiceSignals = <String>{
    technicalServiceViewed,
    technicalServiceRequested,
  };

  static const Set<String> verificationServiceSignals = <String>{
    verificationServiceViewed,
    verificationServiceRequested,
  };

  static const Set<String> toolDemandSignals = <String>{
    toolOpened,
    toolSaved,
    toolRequested,
  };

  static const Set<String> toolAdoptionSignals = <String>{
    toolAdded,
    toolRemoved,
    toolReplaced,
  };

  static const Set<String> toolOpportunitySignals = <String>{
    toolRequestedWithoutAvailability,
  };

  static const Set<String> externalAppSignals = <String>{
    externalAppViewed,
    externalAppOpened,
    externalAppSaved,
  };

  static const Set<String> externalKnowledgeSignals = <String>{
    externalKnowledgeViewed,
  };

  static const Set<String> partnerResourceSignals = <String>{
    partnerResourceViewed,
  };

  static final Set<String> allCommercialSignals = <String>{
    ...providerDemandSignals,
    ...providerCapabilitySignals,
    ...providerVerificationSignals,
    ...centerDemandSignals,
    ...centerCapabilitySignals,
    ...centerVerificationSignals,
    ...marketingServiceSignals,
    ...technicalServiceSignals,
    ...verificationServiceSignals,
    ...toolDemandSignals,
    ...toolAdoptionSignals,
    ...toolOpportunitySignals,
    ...externalAppSignals,
    ...externalKnowledgeSignals,
    ...partnerResourceSignals,
  };

  static CommercialAggregateKind? aggregateKindFor(String signalType) {
    if (providerDemandSignals.contains(signalType)) {
      return CommercialAggregateKind.providerDemand;
    }
    if (providerCapabilitySignals.contains(signalType)) {
      return CommercialAggregateKind.providerCapability;
    }
    if (providerVerificationSignals.contains(signalType)) {
      return CommercialAggregateKind.providerVerification;
    }
    if (centerDemandSignals.contains(signalType)) {
      return CommercialAggregateKind.centerDemand;
    }
    if (centerCapabilitySignals.contains(signalType)) {
      return CommercialAggregateKind.centerCapability;
    }
    if (centerVerificationSignals.contains(signalType)) {
      return CommercialAggregateKind.centerVerification;
    }
    if (marketingServiceSignals.contains(signalType)) {
      return CommercialAggregateKind.marketingService;
    }
    if (technicalServiceSignals.contains(signalType)) {
      return CommercialAggregateKind.technicalService;
    }
    if (verificationServiceSignals.contains(signalType)) {
      return CommercialAggregateKind.verificationService;
    }
    if (toolDemandSignals.contains(signalType)) {
      return CommercialAggregateKind.toolDemand;
    }
    if (toolAdoptionSignals.contains(signalType)) {
      return CommercialAggregateKind.toolAdoption;
    }
    if (toolOpportunitySignals.contains(signalType)) {
      return CommercialAggregateKind.toolOpportunity;
    }
    if (externalAppSignals.contains(signalType)) {
      return CommercialAggregateKind.externalApp;
    }
    if (externalKnowledgeSignals.contains(signalType)) {
      return CommercialAggregateKind.externalKnowledge;
    }
    if (partnerResourceSignals.contains(signalType)) {
      return CommercialAggregateKind.partnerResource;
    }
    return null;
  }
}
