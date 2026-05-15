class RuntimeReleaseRequirement {
  const RuntimeReleaseRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.rollbackReadinessRequired,
    required this.observabilityReadinessRequired,
    required this.isolationReadinessRequired,
    required this.releaseOwnerRequired,
    required this.releaseApprovalRequired,
    required this.providerApprovalRequired,
    required this.backendApprovalRequired,
    required this.backendGovernanceRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool rollbackReadinessRequired;
  final bool observabilityReadinessRequired;
  final bool isolationReadinessRequired;
  final bool releaseOwnerRequired;
  final bool releaseApprovalRequired;
  final bool providerApprovalRequired;
  final bool backendApprovalRequired;
  final bool backendGovernanceRequired;

  static const safeDefault = RuntimeReleaseRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    rollbackReadinessRequired: true,
    observabilityReadinessRequired: true,
    isolationReadinessRequired: true,
    releaseOwnerRequired: true,
    releaseApprovalRequired: true,
    providerApprovalRequired: true,
    backendApprovalRequired: true,
    backendGovernanceRequired: true,
  );
}
