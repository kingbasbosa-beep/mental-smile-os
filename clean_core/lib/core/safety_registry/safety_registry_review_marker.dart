class SafetyRegistryReviewMarker {
  const SafetyRegistryReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const SafetyRegistryReviewMarker safeDefault =
      SafetyRegistryReviewMarker(
    reviewRequired: true,
    reasonKey: 'safety_registry_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;
}
