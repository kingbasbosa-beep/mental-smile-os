import 'governance_capability_visibility_scope.dart';

class GovernanceCapabilityPolicy {
  const GovernanceCapabilityPolicy({
    required this.policyVersion,
    required this.allowedVisibilityScopes,
    required this.restrictedEnvironments,
    required this.capabilityEnabled,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  static const GovernanceCapabilityPolicy safeDefault =
      GovernanceCapabilityPolicy(
    policyVersion: '2026-05-os5e',
    allowedVisibilityScopes: <GovernanceCapabilityVisibilityScope>{
      GovernanceCapabilityVisibilityScope.backendOnly,
      GovernanceCapabilityVisibilityScope.auditOnly,
      GovernanceCapabilityVisibilityScope.governanceInternal,
    },
    restrictedEnvironments: <String>{'production'},
    capabilityEnabled: false,
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );

  final String policyVersion;
  final Set<GovernanceCapabilityVisibilityScope> allowedVisibilityScopes;
  final Set<String> restrictedEnvironments;
  final bool capabilityEnabled;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;
}
