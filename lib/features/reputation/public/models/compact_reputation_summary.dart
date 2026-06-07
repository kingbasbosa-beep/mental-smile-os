class CompactReputationSummary {
  const CompactReputationSummary({
    required this.averageRating,
    required this.ratingCount,
    required this.commentPreview,
    required this.hiddenCommentCount,
  });

  final num averageRating;
  final int ratingCount;
  final String commentPreview;
  final int hiddenCommentCount;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'averageRating': averageRating,
      'ratingCount': ratingCount,
      'commentPreview': commentPreview,
      'hiddenCommentCount': hiddenCommentCount,
    };
  }
}
