class EnvironmentActivationReviewMarker {
  const EnvironmentActivationReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = EnvironmentActivationReviewMarker(
    reviewRequired: true,
    reasonKey: 'environment_activation_review_required',
    clientCanResolve: false,
  );
}
