class DemandGap {
  const DemandGap({
    required this.name,
    required this.demandCount,
    required this.supplyCount,
  });

  final String name;
  final int demandCount;
  final int supplyCount;

  int get gap => demandCount - supplyCount;
}

class CapabilityGap {
  const CapabilityGap({
    required this.capability,
    required this.requestedCount,
    required this.declaredSupplyCount,
  });

  final String capability;
  final int requestedCount;
  final int declaredSupplyCount;

  int get gap => requestedCount - declaredSupplyCount;
}

class MarketOpportunity {
  const MarketOpportunity({
    required this.opportunityId,
    required this.title,
    required this.sourceGap,
    required this.summary,
  });

  final String opportunityId;
  final String title;
  final String sourceGap;
  final String summary;
}

class EmergingNeed {
  const EmergingNeed({
    required this.needId,
    required this.title,
    required this.signalCount,
    required this.summary,
  });

  final String needId;
  final String title;
  final int signalCount;
  final String summary;
}
