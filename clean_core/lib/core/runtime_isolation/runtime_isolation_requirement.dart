class RuntimeIsolationRequirement {
  const RuntimeIsolationRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.runtimeIsolationRequired,
    required this.providerIsolationRequired,
    required this.environmentIsolationRequired,
    required this.fallbackIsolationRequired,
    required this.boundaryIsolationRequired,
    required this.backendGovernanceRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool runtimeIsolationRequired;
  final bool providerIsolationRequired;
  final bool environmentIsolationRequired;
  final bool fallbackIsolationRequired;
  final bool boundaryIsolationRequired;
  final bool backendGovernanceRequired;

  static const safeDefault = RuntimeIsolationRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    runtimeIsolationRequired: true,
    providerIsolationRequired: true,
    environmentIsolationRequired: true,
    fallbackIsolationRequired: true,
    boundaryIsolationRequired: true,
    backendGovernanceRequired: true,
  );
}
