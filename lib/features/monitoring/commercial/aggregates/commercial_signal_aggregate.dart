import 'package:mental_smile_os/features/signals/domain/models/signal_package.dart';

class CommercialSignalAggregate {
  const CommercialSignalAggregate({
    required this.aggregateKey,
    required this.signalType,
    required this.count,
    required this.firstSeen,
    required this.lastSeen,
    required this.aggregationWindow,
  });

  final String aggregateKey;
  final String signalType;
  final int count;
  final DateTime firstSeen;
  final DateTime lastSeen;
  final String aggregationWindow;

  CommercialSignalAggregate incremented(DateTime seenAt) {
    final seenUtc = seenAt.toUtc();
    return CommercialSignalAggregate(
      aggregateKey: aggregateKey,
      signalType: signalType,
      count: count + 1,
      firstSeen: firstSeen,
      lastSeen: seenUtc.isAfter(lastSeen) ? seenUtc : lastSeen,
      aggregationWindow: aggregationWindow,
    );
  }
}

class ProviderDemandAggregate extends CommercialSignalAggregate {
  const ProviderDemandAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class ProviderCapabilityAggregate extends CommercialSignalAggregate {
  const ProviderCapabilityAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class ProviderVerificationAggregate extends CommercialSignalAggregate {
  const ProviderVerificationAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class CenterDemandAggregate extends CommercialSignalAggregate {
  const CenterDemandAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class CenterCapabilityAggregate extends CommercialSignalAggregate {
  const CenterCapabilityAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class CenterVerificationAggregate extends CommercialSignalAggregate {
  const CenterVerificationAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class MarketingServiceAggregate extends CommercialSignalAggregate {
  const MarketingServiceAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class TechnicalServiceAggregate extends CommercialSignalAggregate {
  const TechnicalServiceAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class VerificationServiceAggregate extends CommercialSignalAggregate {
  const VerificationServiceAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class ToolDemandAggregate extends CommercialSignalAggregate {
  const ToolDemandAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class ToolAdoptionAggregate extends CommercialSignalAggregate {
  const ToolAdoptionAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class ToolOpportunityAggregate extends CommercialSignalAggregate {
  const ToolOpportunityAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class ExternalAppAggregate extends CommercialSignalAggregate {
  const ExternalAppAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class ExternalKnowledgeAggregate extends CommercialSignalAggregate {
  const ExternalKnowledgeAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

class PartnerResourceAggregate extends CommercialSignalAggregate {
  const PartnerResourceAggregate({
    required super.aggregateKey,
    required super.signalType,
    required super.count,
    required super.firstSeen,
    required super.lastSeen,
    required super.aggregationWindow,
  });
}

CommercialSignalAggregate commercialAggregateSeed({
  required SignalPackage signal,
  required String aggregateKey,
  required String aggregationWindow,
  required CommercialAggregateKind kind,
}) {
  final timestamp = signal.timestamp.toUtc();
  final args = (
    aggregateKey: aggregateKey,
    signalType: signal.signalType,
    count: 1,
    firstSeen: timestamp,
    lastSeen: timestamp,
    aggregationWindow: aggregationWindow,
  );
  switch (kind) {
    case CommercialAggregateKind.providerDemand:
      return ProviderDemandAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.providerCapability:
      return ProviderCapabilityAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.providerVerification:
      return ProviderVerificationAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.centerDemand:
      return CenterDemandAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.centerCapability:
      return CenterCapabilityAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.centerVerification:
      return CenterVerificationAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.marketingService:
      return MarketingServiceAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.technicalService:
      return TechnicalServiceAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.verificationService:
      return VerificationServiceAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.toolDemand:
      return ToolDemandAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.toolAdoption:
      return ToolAdoptionAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.toolOpportunity:
      return ToolOpportunityAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.externalApp:
      return ExternalAppAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.externalKnowledge:
      return ExternalKnowledgeAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
    case CommercialAggregateKind.partnerResource:
      return PartnerResourceAggregate(
        aggregateKey: args.aggregateKey,
        signalType: args.signalType,
        count: args.count,
        firstSeen: args.firstSeen,
        lastSeen: args.lastSeen,
        aggregationWindow: args.aggregationWindow,
      );
  }
}

enum CommercialAggregateKind {
  providerDemand,
  providerCapability,
  providerVerification,
  centerDemand,
  centerCapability,
  centerVerification,
  marketingService,
  technicalService,
  verificationService,
  toolDemand,
  toolAdoption,
  toolOpportunity,
  externalApp,
  externalKnowledge,
  partnerResource,
}
