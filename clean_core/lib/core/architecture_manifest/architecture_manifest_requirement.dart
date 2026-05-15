class ArchitectureManifestRequirement {
  const ArchitectureManifestRequirement({
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.runtimeMarkerRequired,
    required this.freezeRequired,
    required this.extractionReviewRequired,
  });

  static const ArchitectureManifestRequirement safeDefault =
      ArchitectureManifestRequirement(
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    runtimeMarkerRequired: true,
    freezeRequired: true,
    extractionReviewRequired: true,
  );

  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool runtimeMarkerRequired;
  final bool freezeRequired;
  final bool extractionReviewRequired;
}
