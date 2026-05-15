class RuntimeActivationReviewMarker {
  const RuntimeActivationReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = RuntimeActivationReviewMarker(
    reviewRequired: true,
    reasonKey: 'activation_review_required',
    clientCanResolve: false,
  );
}
