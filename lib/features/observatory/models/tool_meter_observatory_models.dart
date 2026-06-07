class ToolMeterObservatoryProfile {
  const ToolMeterObservatoryProfile({
    required this.profileId,
    required this.meterDimensions,
    required this.reportTargets,
  });

  final String profileId;
  final Set<String> meterDimensions;
  final Set<String> reportTargets;
}

class ToolMeterObservatoryAlignment {
  const ToolMeterObservatoryAlignment({
    required this.toolMeterReference,
    required this.monitoringReference,
    required this.reportReference,
    required this.readinessReference,
  });

  final String toolMeterReference;
  final String monitoringReference;
  final String reportReference;
  final String readinessReference;
}
