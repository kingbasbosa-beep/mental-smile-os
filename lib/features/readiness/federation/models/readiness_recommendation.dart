class ReadinessRecommendation {
  const ReadinessRecommendation({
    required this.recommendationId,
    required this.surface,
    required this.description,
    required this.priority,
  });

  final String recommendationId;
  final String surface;
  final String description;
  final String priority;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'recommendationId': recommendationId,
      'surface': surface,
      'description': description,
      'priority': priority,
    };
  }
}
