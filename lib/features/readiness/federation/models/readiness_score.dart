class ReadinessScore {
  const ReadinessScore({
    required this.score,
    required this.classification,
    required this.assessedAt,
  });

  final num score;
  final String classification;
  final DateTime assessedAt;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'score': score,
      'classification': classification,
      'assessedAt': assessedAt.toIso8601String(),
    };
  }
}
