class RuntimeBootstrapReviewMarker {
  const RuntimeBootstrapReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = RuntimeBootstrapReviewMarker(
    reviewRequired: true,
    reasonKey: 'runtime_bootstrap_review_required',
    clientCanResolve: false,
  );
}
