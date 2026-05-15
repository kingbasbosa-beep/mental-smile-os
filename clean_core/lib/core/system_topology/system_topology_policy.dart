import 'system_topology_scope.dart';
import 'system_topology_visibility_scope.dart';

class SystemTopologyPolicy {
  const SystemTopologyPolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.restrictedEnvironments,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  static const SystemTopologyPolicy safeDefault = SystemTopologyPolicy(
    policyVersion: '2026-05-os6f',
    allowedScopes: <SystemTopologyScope>{
      SystemTopologyScope.governanceKernel,
      SystemTopologyScope.governanceFederation,
      SystemTopologyScope.runtimeReadiness,
      SystemTopologyScope.auditSystems,
    },
    allowedVisibilityScopes: <SystemTopologyVisibilityScope>{
      SystemTopologyVisibilityScope.backendOnly,
      SystemTopologyVisibilityScope.auditOnly,
      SystemTopologyVisibilityScope.governanceInternal,
    },
    restrictedEnvironments: <String>{'production'},
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );

  final String policyVersion;
  final Set<SystemTopologyScope> allowedScopes;
  final Set<SystemTopologyVisibilityScope> allowedVisibilityScopes;
  final Set<String> restrictedEnvironments;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;
}
