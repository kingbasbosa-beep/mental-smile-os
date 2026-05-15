import 'runtime_readiness_scope.dart';
import 'runtime_readiness_visibility_scope.dart';

class RuntimeReadinessPolicy {
  const RuntimeReadinessPolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.restrictedEnvironments,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  static const RuntimeReadinessPolicy safeDefault = RuntimeReadinessPolicy(
    policyVersion: '2026-05-os6e',
    allowedScopes: <RuntimeReadinessScope>{
      RuntimeReadinessScope.governanceSystems,
      RuntimeReadinessScope.safetyRegistry,
      RuntimeReadinessScope.auditSystems,
    },
    allowedVisibilityScopes: <RuntimeReadinessVisibilityScope>{
      RuntimeReadinessVisibilityScope.backendOnly,
      RuntimeReadinessVisibilityScope.auditOnly,
      RuntimeReadinessVisibilityScope.governanceInternal,
    },
    restrictedEnvironments: <String>{'production'},
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );

  final String policyVersion;
  final Set<RuntimeReadinessScope> allowedScopes;
  final Set<RuntimeReadinessVisibilityScope> allowedVisibilityScopes;
  final Set<String> restrictedEnvironments;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;
}
