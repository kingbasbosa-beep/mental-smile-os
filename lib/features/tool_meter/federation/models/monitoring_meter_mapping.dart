class MonitoringMeterMapping {
  const MonitoringMeterMapping({
    required this.monitoringDomain,
    required this.meterDimensions,
    required this.description,
  });

  final String monitoringDomain;
  final Set<String> meterDimensions;
  final String description;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'monitoringDomain': monitoringDomain,
      'meterDimensions': meterDimensions.toList(),
      'description': description,
    };
  }
}
