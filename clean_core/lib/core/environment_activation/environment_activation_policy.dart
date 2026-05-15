import 'environment_activation_environment.dart';
import 'environment_activation_scope.dart';
import 'environment_activation_stage.dart';
import 'environment_activation_visibility_scope.dart';

class EnvironmentActivationPolicy {
  const EnvironmentActivationPolicy({
    required this.policyVersion,
    required this.allowedStages,
    required this.allowedScopes,
    required this.allowedEnvironmentTypes,
    required this.allowedVisibilityScopes,
    required this.environmentAllowed,
    required this.runtimeAllowed,
    required this.providerAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<EnvironmentActivationStage> allowedStages;
  final Set<EnvironmentActivationScope> allowedScopes;
  final Set<EnvironmentActivationEnvironmentType> allowedEnvironmentTypes;
  final Set<EnvironmentActivationVisibilityScope> allowedVisibilityScopes;
  final bool environmentAllowed;
  final bool runtimeAllowed;
  final bool providerAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;

  static const safeDefault = EnvironmentActivationPolicy(
    policyVersion: '2026-05-os7e',
    allowedStages: <EnvironmentActivationStage>{
      EnvironmentActivationStage.environmentReview,
      EnvironmentActivationStage.ownershipReview,
      EnvironmentActivationStage.runtimePermissionReview,
      EnvironmentActivationStage.providerPermissionReview,
      EnvironmentActivationStage.backendPermissionReview,
      EnvironmentActivationStage.routingPermissionReview,
      EnvironmentActivationStage.governancePermissionReview,
      EnvironmentActivationStage.reviewCheckpoint,
      EnvironmentActivationStage.activationDenied,
      EnvironmentActivationStage.fallbackPlanning,
    },
    allowedScopes: <EnvironmentActivationScope>{
      EnvironmentActivationScope.runtimeActivation,
      EnvironmentActivationScope.runtimeEnablement,
      EnvironmentActivationScope.runtimeWiring,
      EnvironmentActivationScope.executionRouting,
      EnvironmentActivationScope.governanceFederation,
      EnvironmentActivationScope.runtimeReadiness,
      EnvironmentActivationScope.secureRuntimeEnvelope,
    },
    allowedEnvironmentTypes: <EnvironmentActivationEnvironmentType>{
      EnvironmentActivationEnvironmentType.localDev,
      EnvironmentActivationEnvironmentType.staging,
      EnvironmentActivationEnvironmentType.restrictedReview,
      EnvironmentActivationEnvironmentType.fallbackOnly,
      EnvironmentActivationEnvironmentType.secureReview,
    },
    allowedVisibilityScopes: <EnvironmentActivationVisibilityScope>{
      EnvironmentActivationVisibilityScope.backendOnly,
      EnvironmentActivationVisibilityScope.auditOnly,
      EnvironmentActivationVisibilityScope.architectureInternal,
      EnvironmentActivationVisibilityScope.environmentPlanning,
    },
    environmentAllowed: false,
    runtimeAllowed: false,
    providerAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );
}
