class ProviderOnboardingReviewMarker {
  const ProviderOnboardingReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = ProviderOnboardingReviewMarker(
    reviewRequired: true,
    reasonKey: 'provider_onboarding_review_required',
    clientCanResolve: false,
  );
}
