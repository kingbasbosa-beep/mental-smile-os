class RuntimeWiringReviewMarker {
  const RuntimeWiringReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  static const safeDefault = RuntimeWiringReviewMarker(
    reviewRequired: true,
    reasonKey: 'runtime_wiring_review_required',
    clientCanResolve: false,
  );
}
