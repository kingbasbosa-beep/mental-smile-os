class RuntimeIsolationReviewMarker {
  const RuntimeIsolationReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = RuntimeIsolationReviewMarker(
    reviewRequired: true,
    reasonKey: 'runtime_isolation_review_required',
    clientCanResolve: false,
  );
}
