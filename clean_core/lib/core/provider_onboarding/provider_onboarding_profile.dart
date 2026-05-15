import 'provider_candidate.dart';
import 'provider_onboarding_audit_link.dart';
import 'provider_onboarding_reference.dart';
import 'provider_onboarding_requirement.dart';
import 'provider_onboarding_review_marker.dart';
import 'provider_onboarding_runtime_marker.dart';
import 'provider_onboarding_stage.dart';
import 'provider_onboarding_visibility_scope.dart';

class ProviderOnboardingProfile {
  const ProviderOnboardingProfile({
    required this.profileId,
    required this.stage,
    required this.visibilityScope,
    required this.policyVersion,
    required this.references,
    required this.candidate,
    required this.runtimeMarker,
    required this.auditLink,
    required this.reviewMarker,
    required this.requirement,
    this.signedAuthorityPlaceholder,
  });

  final String profileId;
  final ProviderOnboardingStage stage;
  final ProviderOnboardingVisibilityScope visibilityScope;
  final String policyVersion;
  final List<ProviderOnboardingReference> references;
  final ProviderCandidate candidate;
  final ProviderOnboardingRuntimeMarker runtimeMarker;
  final ProviderOnboardingAuditLink auditLink;
  final ProviderOnboardingReviewMarker reviewMarker;
  final ProviderOnboardingRequirement requirement;
  final String? signedAuthorityPlaceholder;

  bool get hasSignedAuthority =>
      signedAuthorityPlaceholder != null &&
      signedAuthorityPlaceholder!.trim().isNotEmpty;
}
