class RuntimeEnablementRequirement {
  const RuntimeEnablementRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.readinessRequired,
    required this.rollbackPlanRequired,
    required this.backendApprovalRequired,
    required this.providerApprovalRequired,
    required this.governanceOwnershipRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool readinessRequired;
  final bool rollbackPlanRequired;
  final bool backendApprovalRequired;
  final bool providerApprovalRequired;
  final bool governanceOwnershipRequired;

  static const safeDefault = RuntimeEnablementRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    readinessRequired: true,
    rollbackPlanRequired: true,
    backendApprovalRequired: true,
    providerApprovalRequired: true,
    governanceOwnershipRequired: true,
  );
}
