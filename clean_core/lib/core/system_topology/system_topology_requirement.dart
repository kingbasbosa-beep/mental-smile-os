class SystemTopologyRequirement {
  const SystemTopologyRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.runtimeMarkerRequired,
    required this.dependencyReferencesRequired,
    required this.topologySealingRequired,
  });

  static const SystemTopologyRequirement safeDefault =
      SystemTopologyRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    runtimeMarkerRequired: true,
    dependencyReferencesRequired: true,
    topologySealingRequired: true,
  );

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool runtimeMarkerRequired;
  final bool dependencyReferencesRequired;
  final bool topologySealingRequired;
}
