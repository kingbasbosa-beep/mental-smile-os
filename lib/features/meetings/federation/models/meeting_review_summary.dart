class MeetingReviewSummary {
  const MeetingReviewSummary({
    required this.summary,
    required this.risks,
    required this.opportunities,
    required this.recommendations,
    required this.followUps,
  });

  final String summary;
  final List<String> risks;
  final List<String> opportunities;
  final List<String> recommendations;
  final List<String> followUps;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'summary': summary,
      'risks': risks,
      'opportunities': opportunities,
      'recommendations': recommendations,
      'followUps': followUps,
    };
  }
}
