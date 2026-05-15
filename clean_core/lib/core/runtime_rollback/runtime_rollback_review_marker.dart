class RuntimeRollbackReviewMarker {
  const RuntimeRollbackReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = RuntimeRollbackReviewMarker(
    reviewRequired: true,
    reasonKey: 'runtime_rollback_review_required',
    clientCanResolve: false,
  );
}
