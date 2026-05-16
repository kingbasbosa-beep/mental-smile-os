import 'governance_compliance_scope.dart';

class GovernanceComplianceRequirement {
  const GovernanceComplianceRequirement({
    required this.auditLinkRequired,
    required this.policyLinkRequired,
    required this.reviewMarkerRequired,
    required this.runtimeMarkerRequired,
    required this.legalDisclaimerRequired,
    required this.allowedScopes,
  });

  static const GovernanceComplianceRequirement safeDefault =
      GovernanceComplianceRequirement(
    auditLinkRequired: true,
    policyLinkRequired: true,
    reviewMarkerRequired: true,
    runtimeMarkerRequired: true,
    legalDisclaimerRequired: true,
    allowedScopes: <GovernanceComplianceScope>{
      GovernanceComplianceScope.legal,
      GovernanceComplianceScope.storeReview,
      GovernanceComplianceScope.audit,
      GovernanceComplianceScope.policy,
    },
  );

  final bool auditLinkRequired;
  final bool policyLinkRequired;
  final bool reviewMarkerRequired;
  final bool runtimeMarkerRequired;
  final bool legalDisclaimerRequired;
  final Set<GovernanceComplianceScope> allowedScopes;
}
