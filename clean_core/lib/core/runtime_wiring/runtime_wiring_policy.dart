import 'runtime_wiring_scope.dart';
import 'runtime_wiring_visibility_scope.dart';

class RuntimeWiringPolicy {
  const RuntimeWiringPolicy({
    required this.policyVersion,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.wiringAllowed,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<RuntimeWiringScope> allowedScopes;
  final Set<RuntimeWiringVisibilityScope> allowedVisibilityScopes;
  final bool wiringAllowed;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;

  static const safeDefault = RuntimeWiringPolicy(
    policyVersion: '2026-05-os7b',
    allowedScopes: <RuntimeWiringScope>{
      RuntimeWiringScope.runtimeActivationGateway,
      RuntimeWiringScope.governanceFederation,
      RuntimeWiringScope.runtimeReadiness,
      RuntimeWiringScope.secureRuntimeEnvelope,
      RuntimeWiringScope.safetyRegistry,
      RuntimeWiringScope.auditSystems,
      RuntimeWiringScope.humanReview,
      RuntimeWiringScope.responseComposition,
    },
    allowedVisibilityScopes: <RuntimeWiringVisibilityScope>{
      RuntimeWiringVisibilityScope.backendOnly,
      RuntimeWiringVisibilityScope.auditOnly,
      RuntimeWiringVisibilityScope.architectureInternal,
      RuntimeWiringVisibilityScope.wiringPlanning,
    },
    wiringAllowed: false,
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );
}
