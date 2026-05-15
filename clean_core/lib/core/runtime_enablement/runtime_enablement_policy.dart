import 'runtime_enablement_scope.dart';
import 'runtime_enablement_stage.dart';
import 'runtime_enablement_visibility_scope.dart';

class RuntimeEnablementPolicy {
  const RuntimeEnablementPolicy({
    required this.policyVersion,
    required this.allowedStages,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.restrictedEnvironments,
    required this.enablementAllowed,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<RuntimeEnablementStage> allowedStages;
  final Set<RuntimeEnablementScope> allowedScopes;
  final Set<RuntimeEnablementVisibilityScope> allowedVisibilityScopes;
  final Set<String> restrictedEnvironments;
  final bool enablementAllowed;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;

  static const safeDefault = RuntimeEnablementPolicy(
    policyVersion: '2026-05-os7c',
    allowedStages: <RuntimeEnablementStage>{
      RuntimeEnablementStage.candidateReview,
      RuntimeEnablementStage.governanceReview,
      RuntimeEnablementStage.auditReview,
      RuntimeEnablementStage.secureEnvelopeReview,
      RuntimeEnablementStage.activationReview,
      RuntimeEnablementStage.rollbackPlanning,
      RuntimeEnablementStage.enablementDenied,
      RuntimeEnablementStage.fallbackPlanning,
    },
    allowedScopes: <RuntimeEnablementScope>{
      RuntimeEnablementScope.activationGateway,
      RuntimeEnablementScope.runtimeWiring,
      RuntimeEnablementScope.governanceFederation,
      RuntimeEnablementScope.runtimeReadiness,
      RuntimeEnablementScope.secureRuntimeEnvelope,
      RuntimeEnablementScope.providerGovernance,
      RuntimeEnablementScope.auditSystems,
      RuntimeEnablementScope.reviewSystems,
    },
    allowedVisibilityScopes: <RuntimeEnablementVisibilityScope>{
      RuntimeEnablementVisibilityScope.backendOnly,
      RuntimeEnablementVisibilityScope.auditOnly,
      RuntimeEnablementVisibilityScope.architectureInternal,
      RuntimeEnablementVisibilityScope.enablementPlanning,
    },
    restrictedEnvironments: <String>{'production'},
    enablementAllowed: false,
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );
}
