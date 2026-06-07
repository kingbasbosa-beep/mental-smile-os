class CenterTrustProfile {
  const CenterTrustProfile({
    required this.centerId,
    required this.reputationProfileId,
    required this.generalRatingLabel,
    required this.commentVisibilityMode,
    required this.trustSummary,
  });

  final String centerId;
  final String reputationProfileId;
  final String generalRatingLabel;
  final String commentVisibilityMode;
  final String trustSummary;
}
