class ProviderTrustProfile {
  const ProviderTrustProfile({
    required this.providerId,
    required this.reputationProfileId,
    required this.generalRatingLabel,
    required this.commentVisibilityMode,
    required this.trustSummary,
  });

  final String providerId;
  final String reputationProfileId;
  final String generalRatingLabel;
  final String commentVisibilityMode;
  final String trustSummary;
}
