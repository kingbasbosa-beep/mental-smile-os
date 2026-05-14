import 'governance_capability_scope.dart';

class GovernanceCapabilityRequirement {
  const GovernanceCapabilityRequirement({
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.runtimeMarkerRequired,
    required this.governanceReferenceRequired,
    required this.allowedScopes,
  });

  static const GovernanceCapabilityRequirement safeDefault =
      GovernanceCapabilityRequirement(
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    runtimeMarkerRequired: true,
    governanceReferenceRequired: true,
    allowedScopes: <GovernanceCapabilityScope>{
      GovernanceCapabilityScope.responseComposition,
      GovernanceCapabilityScope.safetyDecision,
      GovernanceCapabilityScope.auditSystem,
    },
  );

  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool runtimeMarkerRequired;
  final bool governanceReferenceRequired;
  final Set<GovernanceCapabilityScope> allowedScopes;
}
