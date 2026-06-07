class ToolMeterSnapshot {
  const ToolMeterSnapshot({
    required this.assetId,
    required this.assetType,
    required this.usageScore,
    required this.adoptionScore,
    required this.trustScore,
    required this.impactScore,
    required this.measurementPeriod,
    required this.createdAt,
  });

  final String assetId;
  final String assetType;
  final num usageScore;
  final num adoptionScore;
  final num trustScore;
  final num impactScore;
  final String measurementPeriod;
  final DateTime createdAt;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'assetId': assetId,
      'assetType': assetType,
      'usageScore': usageScore,
      'adoptionScore': adoptionScore,
      'trustScore': trustScore,
      'impactScore': impactScore,
      'measurementPeriod': measurementPeriod,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
