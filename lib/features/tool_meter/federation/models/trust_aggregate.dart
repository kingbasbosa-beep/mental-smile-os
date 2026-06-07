class TrustAggregate {
  const TrustAggregate({
    required this.ratingScore,
    required this.commentIndicator,
    required this.reputationWeight,
  });

  final num ratingScore;
  final num commentIndicator;
  final num reputationWeight;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'ratingScore': ratingScore,
      'commentIndicator': commentIndicator,
      'reputationWeight': reputationWeight,
    };
  }
}
