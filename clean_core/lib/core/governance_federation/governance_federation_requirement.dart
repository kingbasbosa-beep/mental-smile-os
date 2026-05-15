class GovernanceFederationRequirement {
  const GovernanceFederationRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.runtimeMarkerRequired,
    required this.governanceReferenceRequired,
    required this.federationSealingRequired,
  });

  static const GovernanceFederationRequirement safeDefault =
      GovernanceFederationRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    runtimeMarkerRequired: true,
    governanceReferenceRequired: true,
    federationSealingRequired: true,
  );

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool runtimeMarkerRequired;
  final bool governanceReferenceRequired;
  final bool federationSealingRequired;
}
