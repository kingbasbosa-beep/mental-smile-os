class PublicRating {
  const PublicRating({
    required this.targetType,
    required this.targetId,
    required this.ratingValue,
    required this.createdAt,
    required this.classification,
  });

  final String targetType;
  final String targetId;
  final num ratingValue;
  final DateTime createdAt;
  final String classification;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'targetType': targetType,
      'targetId': targetId,
      'ratingValue': ratingValue,
      'createdAt': createdAt.toIso8601String(),
      'classification': classification,
    };
  }
}
