class RuntimeReadinessReviewMarker {
  const RuntimeReadinessReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const RuntimeReadinessReviewMarker safeDefault =
      RuntimeReadinessReviewMarker(
    reviewRequired: true,
    reasonKey: 'runtime_readiness_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;
}
