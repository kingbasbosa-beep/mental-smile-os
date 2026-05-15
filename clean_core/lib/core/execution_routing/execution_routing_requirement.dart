class ExecutionRoutingRequirement {
  const ExecutionRoutingRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.ownerRequired,
    required this.routeApprovalRequired,
    required this.backendGovernanceRequired,
    required this.sealingRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool ownerRequired;
  final bool routeApprovalRequired;
  final bool backendGovernanceRequired;
  final bool sealingRequired;

  static const safeDefault = ExecutionRoutingRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    ownerRequired: true,
    routeApprovalRequired: true,
    backendGovernanceRequired: true,
    sealingRequired: true,
  );
}
