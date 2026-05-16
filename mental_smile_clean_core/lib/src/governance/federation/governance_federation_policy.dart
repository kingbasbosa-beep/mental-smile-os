import 'governance_federation_scope.dart';
import 'governance_federation_visibility_scope.dart';

class GovernanceFederationPolicy {
  const GovernanceFederationPolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.restrictedEnvironments,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  static const GovernanceFederationPolicy safeDefault =
      GovernanceFederationPolicy(
    policyVersion: '2026-05-os6d',
    allowedScopes: <GovernanceFederationScope>{
      GovernanceFederationScope.governanceKernel,
      GovernanceFederationScope.governanceLifecycle,
      GovernanceFederationScope.governanceCompliance,
      GovernanceFederationScope.audit,
    },
    allowedVisibilityScopes: <GovernanceFederationVisibilityScope>{
      GovernanceFederationVisibilityScope.backendOnly,
      GovernanceFederationVisibilityScope.auditOnly,
      GovernanceFederationVisibilityScope.governanceInternal,
    },
    restrictedEnvironments: <String>{'production'},
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );

  final String policyVersion;
  final Set<GovernanceFederationScope> allowedScopes;
  final Set<GovernanceFederationVisibilityScope> allowedVisibilityScopes;
  final Set<String> restrictedEnvironments;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;
}
