class RuntimeRollbackRequirement {
  const RuntimeRollbackRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.rollbackOwnerRequired,
    required this.rollbackApprovalRequired,
    required this.providerRollbackApprovalRequired,
    required this.backendRollbackApprovalRequired,
    required this.governanceRollbackOwnershipRequired,
    required this.environmentRollbackOwnershipRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool rollbackOwnerRequired;
  final bool rollbackApprovalRequired;
  final bool providerRollbackApprovalRequired;
  final bool backendRollbackApprovalRequired;
  final bool governanceRollbackOwnershipRequired;
  final bool environmentRollbackOwnershipRequired;

  static const safeDefault = RuntimeRollbackRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    rollbackOwnerRequired: true,
    rollbackApprovalRequired: true,
    providerRollbackApprovalRequired: true,
    backendRollbackApprovalRequired: true,
    governanceRollbackOwnershipRequired: true,
    environmentRollbackOwnershipRequired: true,
  );
}
