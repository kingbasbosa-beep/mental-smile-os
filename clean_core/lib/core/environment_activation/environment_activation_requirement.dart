class EnvironmentActivationRequirement {
  const EnvironmentActivationRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.ownerRequired,
    required this.runtimePermissionRequired,
    required this.providerPermissionRequired,
    required this.backendPermissionRequired,
    required this.routingPermissionRequired,
    required this.governancePermissionRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool ownerRequired;
  final bool runtimePermissionRequired;
  final bool providerPermissionRequired;
  final bool backendPermissionRequired;
  final bool routingPermissionRequired;
  final bool governancePermissionRequired;

  static const safeDefault = EnvironmentActivationRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    ownerRequired: true,
    runtimePermissionRequired: true,
    providerPermissionRequired: true,
    backendPermissionRequired: true,
    routingPermissionRequired: true,
    governancePermissionRequired: true,
  );
}
