class GovernanceCapabilityReviewMarker {
  const GovernanceCapabilityReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const GovernanceCapabilityReviewMarker safeDefault =
      GovernanceCapabilityReviewMarker(
    reviewRequired: true,
    reasonKey: 'governance_capability_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;
}
