class SecureRuntimeRequirement {
  const SecureRuntimeRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.runtimeMarkerRequired,
    required this.governanceReferenceRequired,
    required this.envelopeSealingRequired,
  });

  static const SecureRuntimeRequirement safeDefault =
      SecureRuntimeRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    runtimeMarkerRequired: true,
    governanceReferenceRequired: true,
    envelopeSealingRequired: true,
  );

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool runtimeMarkerRequired;
  final bool governanceReferenceRequired;
  final bool envelopeSealingRequired;
}
