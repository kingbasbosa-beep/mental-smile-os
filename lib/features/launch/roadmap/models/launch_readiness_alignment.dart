class LaunchReadinessAlignment {
  const LaunchReadinessAlignment({
    required this.readinessGapId,
    required this.requirementId,
    required this.roadmapItemId,
  });

  final String readinessGapId;
  final String requirementId;
  final String roadmapItemId;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'readinessGapId': readinessGapId,
      'requirementId': requirementId,
      'roadmapItemId': roadmapItemId,
    };
  }
}
