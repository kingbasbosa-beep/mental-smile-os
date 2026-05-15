class ArchitectureManifestReviewMarker {
  const ArchitectureManifestReviewMarker({
    required this.reviewRequired,
    required this.reasonKey,
    required this.clientCanResolve,
  });

  static const ArchitectureManifestReviewMarker safeDefault =
      ArchitectureManifestReviewMarker(
    reviewRequired: true,
    reasonKey: 'architecture_manifest_review_required',
    clientCanResolve: false,
  );

  final bool reviewRequired;
  final String reasonKey;
  final bool clientCanResolve;
}
