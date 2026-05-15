class SystemTopologyReviewMarker {
  const SystemTopologyReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const SystemTopologyReviewMarker safeDefault =
      SystemTopologyReviewMarker(
    reviewRequired: true,
    reasonKey: 'system_topology_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;
}
