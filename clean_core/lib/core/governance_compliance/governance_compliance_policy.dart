import 'governance_compliance_visibility_scope.dart';

class GovernanceCompliancePolicy {
  const GovernanceCompliancePolicy({
    required this.policyVersion,
    required this.allowedVisibilityScopes,
    required this.restrictedEnvironments,
    required this.providerAllowed,
    required this.runtimeAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  static const GovernanceCompliancePolicy safeDefault =
      GovernanceCompliancePolicy(
    policyVersion: '2026-05-os5c',
    allowedVisibilityScopes: <GovernanceComplianceVisibilityScope>{
      GovernanceComplianceVisibilityScope.backendOnly,
      GovernanceComplianceVisibilityScope.auditOnly,
      GovernanceComplianceVisibilityScope.restrictedReview,
    },
    restrictedEnvironments: <String>{'production'},
    providerAllowed: false,
    runtimeAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );

  final String policyVersion;
  final Set<GovernanceComplianceVisibilityScope> allowedVisibilityScopes;
  final Set<String> restrictedEnvironments;
  final bool providerAllowed;
  final bool runtimeAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;
}
