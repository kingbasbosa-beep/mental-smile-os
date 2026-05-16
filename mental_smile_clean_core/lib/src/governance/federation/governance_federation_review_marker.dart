class GovernanceFederationReviewMarker {
  const GovernanceFederationReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const GovernanceFederationReviewMarker safeDefault =
      GovernanceFederationReviewMarker(
    reviewRequired: true,
    reasonKey: 'governance_federation_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;
}
