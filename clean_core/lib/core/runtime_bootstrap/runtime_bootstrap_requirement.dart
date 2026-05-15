class RuntimeBootstrapRequirement {
  const RuntimeBootstrapRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.releaseApprovalRequired,
    required this.rollbackReadinessRequired,
    required this.observabilityReadinessRequired,
    required this.isolationReadinessRequired,
    required this.bootstrapOwnerRequired,
    required this.bootstrapApprovalRequired,
    required this.providerStartupApprovalRequired,
    required this.backendStartupApprovalRequired,
    required this.backendGovernanceRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool releaseApprovalRequired;
  final bool rollbackReadinessRequired;
  final bool observabilityReadinessRequired;
  final bool isolationReadinessRequired;
  final bool bootstrapOwnerRequired;
  final bool bootstrapApprovalRequired;
  final bool providerStartupApprovalRequired;
  final bool backendStartupApprovalRequired;
  final bool backendGovernanceRequired;

  static const safeDefault = RuntimeBootstrapRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    releaseApprovalRequired: true,
    rollbackReadinessRequired: true,
    observabilityReadinessRequired: true,
    isolationReadinessRequired: true,
    bootstrapOwnerRequired: true,
    bootstrapApprovalRequired: true,
    providerStartupApprovalRequired: true,
    backendStartupApprovalRequired: true,
    backendGovernanceRequired: true,
  );
}
