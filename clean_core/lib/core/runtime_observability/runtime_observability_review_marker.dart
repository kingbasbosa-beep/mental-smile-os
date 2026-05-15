class RuntimeObservabilityReviewMarker {
  const RuntimeObservabilityReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = RuntimeObservabilityReviewMarker(
    reviewRequired: true,
    reasonKey: 'runtime_observability_review_required',
    clientCanResolve: false,
  );
}
