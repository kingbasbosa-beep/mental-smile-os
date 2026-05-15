import 'runtime_activation_scope.dart';
import 'runtime_activation_stage.dart';
import 'runtime_activation_visibility_scope.dart';

class RuntimeActivationPolicy {
  const RuntimeActivationPolicy({
    required this.policyVersion,
    required this.allowedStages,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.restrictedEnvironments,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.activationAllowed,
    required this.backendGovernanceRequired,
    required this.extractionRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<RuntimeActivationStage> allowedStages;
  final Set<RuntimeActivationScope> allowedScopes;
  final Set<RuntimeActivationVisibilityScope> allowedVisibilityScopes;
  final Set<String> restrictedEnvironments;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool activationAllowed;
  final bool backendGovernanceRequired;
  final bool extractionRequired;
  final bool failClosed;

  static const safeDefault = RuntimeActivationPolicy(
    policyVersion: '2026-05-os7a',
    allowedStages: <RuntimeActivationStage>{
      RuntimeActivationStage.governanceVerification,
      RuntimeActivationStage.auditVerification,
      RuntimeActivationStage.reviewCheckpoint,
      RuntimeActivationStage.activationDenied,
      RuntimeActivationStage.activationFallback,
    },
    allowedScopes: <RuntimeActivationScope>{
      RuntimeActivationScope.governanceFederation,
      RuntimeActivationScope.runtimeReadiness,
      RuntimeActivationScope.secureRuntimeEnvelope,
      RuntimeActivationScope.providerGovernance,
      RuntimeActivationScope.reviewSystems,
      RuntimeActivationScope.auditSystems,
    },
    allowedVisibilityScopes: <RuntimeActivationVisibilityScope>{
      RuntimeActivationVisibilityScope.backendOnly,
      RuntimeActivationVisibilityScope.auditOnly,
      RuntimeActivationVisibilityScope.architectureInternal,
      RuntimeActivationVisibilityScope.activationPlanning,
    },
    restrictedEnvironments: <String>{'production'},
    runtimeAllowed: false,
    providerAllowed: false,
    activationAllowed: false,
    backendGovernanceRequired: true,
    extractionRequired: false,
    failClosed: true,
  );
}
