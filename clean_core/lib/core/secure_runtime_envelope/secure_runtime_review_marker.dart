class SecureRuntimeReviewMarker {
  const SecureRuntimeReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const SecureRuntimeReviewMarker safeDefault =
      SecureRuntimeReviewMarker(
    reviewRequired: true,
    reasonKey: 'secure_runtime_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;
}
