import 'safety_registry_scope.dart';
import 'safety_registry_visibility_scope.dart';

class SafetyRegistryPolicy {
  const SafetyRegistryPolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.auditRequired,
    required this.reviewRequired,
    required this.backendGovernanceRequired,
    required this.providerAllowed,
    required this.registrationLocked,
    required this.failClosed,
  });

  static const SafetyRegistryPolicy safeDefault = SafetyRegistryPolicy(
    policyVersion: '2026-05-os5d',
    allowedScopes: <SafetyRegistryScope>{
      SafetyRegistryScope.governanceKernel,
      SafetyRegistryScope.governanceLifecycle,
      SafetyRegistryScope.governanceCompliance,
      SafetyRegistryScope.audit,
    },
    allowedVisibilityScopes: <SafetyRegistryVisibilityScope>{
      SafetyRegistryVisibilityScope.backendOnly,
      SafetyRegistryVisibilityScope.auditOnly,
      SafetyRegistryVisibilityScope.registryInternal,
    },
    auditRequired: true,
    reviewRequired: true,
    backendGovernanceRequired: true,
    providerAllowed: false,
    registrationLocked: true,
    failClosed: true,
  );

  final String policyVersion;
  final Set<SafetyRegistryScope> allowedScopes;
  final Set<SafetyRegistryVisibilityScope> allowedVisibilityScopes;
  final bool auditRequired;
  final bool reviewRequired;
  final bool backendGovernanceRequired;
  final bool providerAllowed;
  final bool registrationLocked;
  final bool failClosed;
}
