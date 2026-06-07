class ReputationAggregate {
  const ReputationAggregate({
    required this.averageRating,
    required this.ratingCount,
    required this.commentCount,
    required this.trustScore,
  });

  final num averageRating;
  final int ratingCount;
  final int commentCount;
  final num trustScore;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'averageRating': averageRating,
      'ratingCount': ratingCount,
      'commentCount': commentCount,
      'trustScore': trustScore,
    };
  }
}
