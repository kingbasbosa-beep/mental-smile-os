import 'execution_routing_scope.dart';
import 'execution_routing_visibility_scope.dart';

class ExecutionRoutingPolicy {
  const ExecutionRoutingPolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.routingAllowed,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<ExecutionRoutingScope> allowedScopes;
  final Set<ExecutionRoutingVisibilityScope> allowedVisibilityScopes;
  final bool routingAllowed;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;

  static const safeDefault = ExecutionRoutingPolicy(
    policyVersion: '2026-05-os7d',
    allowedScopes: <ExecutionRoutingScope>{
      ExecutionRoutingScope.runtimeActivation,
      ExecutionRoutingScope.runtimeEnablement,
      ExecutionRoutingScope.runtimeWiring,
      ExecutionRoutingScope.governanceFederation,
      ExecutionRoutingScope.runtimeReadiness,
      ExecutionRoutingScope.secureRuntimeEnvelope,
      ExecutionRoutingScope.auditSystems,
      ExecutionRoutingScope.reviewSystems,
      ExecutionRoutingScope.responseComposition,
    },
    allowedVisibilityScopes: <ExecutionRoutingVisibilityScope>{
      ExecutionRoutingVisibilityScope.backendOnly,
      ExecutionRoutingVisibilityScope.auditOnly,
      ExecutionRoutingVisibilityScope.architectureInternal,
      ExecutionRoutingVisibilityScope.routingPlanning,
    },
    routingAllowed: false,
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );
}
