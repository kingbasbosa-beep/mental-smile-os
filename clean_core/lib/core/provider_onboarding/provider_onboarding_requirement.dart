class ProviderOnboardingRequirement {
  const ProviderOnboardingRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.providerOwnerRequired,
    required this.providerApprovalRequired,
    required this.providerIsolationRequired,
    required this.observabilityRequired,
    required this.rollbackReadinessRequired,
    required this.backendGovernanceRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool providerOwnerRequired;
  final bool providerApprovalRequired;
  final bool providerIsolationRequired;
  final bool observabilityRequired;
  final bool rollbackReadinessRequired;
  final bool backendGovernanceRequired;

  static const safeDefault = ProviderOnboardingRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    providerOwnerRequired: true,
    providerApprovalRequired: true,
    providerIsolationRequired: true,
    observabilityRequired: true,
    rollbackReadinessRequired: true,
    backendGovernanceRequired: true,
  );
}
