class TrustedBackendRequirement {
  const TrustedBackendRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.runtimeMarkerRequired,
    required this.governanceReferenceRequired,
  });

  static const TrustedBackendRequirement safeDefault =
      TrustedBackendRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    runtimeMarkerRequired: true,
    governanceReferenceRequired: true,
  );

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool runtimeMarkerRequired;
  final bool governanceReferenceRequired;
}
