class RuntimeWiringRequirement {
  const RuntimeWiringRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.ownerRequired,
    required this.pathApprovalRequired,
    required this.backendGovernanceRequired,
    required this.sealingRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool ownerRequired;
  final bool pathApprovalRequired;
  final bool backendGovernanceRequired;
  final bool sealingRequired;

  static const safeDefault = RuntimeWiringRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    ownerRequired: true,
    pathApprovalRequired: true,
    backendGovernanceRequired: true,
    sealingRequired: true,
  );
}
