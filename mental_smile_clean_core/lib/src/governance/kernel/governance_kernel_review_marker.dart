class GovernanceKernelReviewMarker {
  const GovernanceKernelReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const GovernanceKernelReviewMarker safeDefault =
      GovernanceKernelReviewMarker(
    reviewRequired: true,
    reasonKey: 'governance_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;

  Map<String, Object?> toMap() {
    return {
      'reviewRequired': reviewRequired,
      'reasonKey': reasonKey,
      'clientCanResolve': clientCanResolve,
    };
  }
}
