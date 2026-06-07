class MonitoringConsumptionProfile {
  const MonitoringConsumptionProfile({
    required this.profileId,
    required this.canBeObserved,
    required this.canBeAggregated,
    required this.canBeReported,
  });

  final String profileId;
  final Set<String> canBeObserved;
  final Set<String> canBeAggregated;
  final Set<String> canBeReported;
}

class MonitoringConsumptionAlignment {
  const MonitoringConsumptionAlignment({
    required this.source,
    required this.observatoryTarget,
    required this.allowedUse,
  });

  final String source;
  final String observatoryTarget;
  final String allowedUse;
}
