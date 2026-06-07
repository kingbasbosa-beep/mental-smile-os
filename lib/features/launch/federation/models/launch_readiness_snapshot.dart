class LaunchReadinessSnapshot {
  const LaunchReadinessSnapshot({
    required this.surfaceId,
    required this.readinessScore,
    required this.blockers,
    required this.warnings,
    required this.dependencies,
  });

  final String surfaceId;
  final num readinessScore;
  final List<String> blockers;
  final List<String> warnings;
  final List<String> dependencies;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'surfaceId': surfaceId,
      'readinessScore': readinessScore,
      'blockers': blockers,
      'warnings': warnings,
      'dependencies': dependencies,
    };
  }
}
