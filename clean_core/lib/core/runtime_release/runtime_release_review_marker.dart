class RuntimeReleaseReviewMarker {
  const RuntimeReleaseReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = RuntimeReleaseReviewMarker(
    reviewRequired: true,
    reasonKey: 'runtime_release_review_required',
    clientCanResolve: false,
  );
}
