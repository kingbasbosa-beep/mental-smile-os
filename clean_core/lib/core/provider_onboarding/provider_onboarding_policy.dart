import 'provider_onboarding_scope.dart';
import 'provider_onboarding_stage.dart';
import 'provider_onboarding_visibility_scope.dart';

class ProviderOnboardingPolicy {
  const ProviderOnboardingPolicy({
    required this.policyVersion,
    required this.allowedStages,
    required this.allowedScopes,
    required this.allowedVisibilityScopes,
    required this.onboardingAllowed,
    required this.runtimeAllowed,
    required this.networkingAllowed,
    required this.backendGovernanceRequired,
    required this.failClosed,
  });

  final String policyVersion;
  final Set<ProviderOnboardingStage> allowedStages;
  final Set<ProviderOnboardingScope> allowedScopes;
  final Set<ProviderOnboardingVisibilityScope> allowedVisibilityScopes;
  final bool onboardingAllowed;
  final bool runtimeAllowed;
  final bool networkingAllowed;
  final bool backendGovernanceRequired;
  final bool failClosed;

  static const safeDefault = ProviderOnboardingPolicy(
    policyVersion: '2026-05-os8a',
    allowedStages: <ProviderOnboardingStage>{
      ProviderOnboardingStage.onboardingRequest,
      ProviderOnboardingStage.governanceReview,
      ProviderOnboardingStage.auditReview,
      ProviderOnboardingStage.capabilityReview,
      ProviderOnboardingStage.isolationReview,
      ProviderOnboardingStage.observabilityReview,
      ProviderOnboardingStage.rollbackReview,
      ProviderOnboardingStage.providerDenied,
      ProviderOnboardingStage.onboardingFallback,
    },
    allowedScopes: <ProviderOnboardingScope>{
      ProviderOnboardingScope.llmProvider,
      ProviderOnboardingScope.moderationProvider,
      ProviderOnboardingScope.embeddingsProvider,
      ProviderOnboardingScope.safetyProvider,
      ProviderOnboardingScope.backendProvider,
      ProviderOnboardingScope.orchestrationProvider,
      ProviderOnboardingScope.runtimeExecutionProvider,
      ProviderOnboardingScope.trustedBackendProvider,
    },
    allowedVisibilityScopes: <ProviderOnboardingVisibilityScope>{
      ProviderOnboardingVisibilityScope.backendOnly,
      ProviderOnboardingVisibilityScope.auditOnly,
      ProviderOnboardingVisibilityScope.architectureInternal,
      ProviderOnboardingVisibilityScope.onboardingPlanning,
    },
    onboardingAllowed: false,
    runtimeAllowed: false,
    networkingAllowed: false,
    backendGovernanceRequired: true,
    failClosed: true,
  );
}
