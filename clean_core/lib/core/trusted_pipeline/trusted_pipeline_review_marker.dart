class TrustedPipelineReviewMarker {
  const TrustedPipelineReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const TrustedPipelineReviewMarker safeDefault =
      TrustedPipelineReviewMarker(
    reviewRequired: true,
    reasonKey: 'trusted_pipeline_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;
}
