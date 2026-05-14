class GovernanceLifecycleReviewMarker {
  const GovernanceLifecycleReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const GovernanceLifecycleReviewMarker safeDefault =
      GovernanceLifecycleReviewMarker(
    reviewRequired: true,
    reasonKey: 'governance_lifecycle_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;
}
