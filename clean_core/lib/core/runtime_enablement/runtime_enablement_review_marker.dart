class RuntimeEnablementReviewMarker {
  const RuntimeEnablementReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = RuntimeEnablementReviewMarker(
    reviewRequired: true,
    reasonKey: 'runtime_enablement_review_required',
    clientCanResolve: false,
  );
}
