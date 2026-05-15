import 'provider_onboarding_scope.dart';

class ProviderCandidate {
  const ProviderCandidate({
    required this.providerId,
    required this.ownerId,
    required this.capabilityScopes,
    required this.providerApprovalPlaceholder,
    required this.isolationApproved,
    required this.observabilityApproved,
    required this.rollbackReady,
  });

  final String providerId;
  final String ownerId;
  final Set<ProviderOnboardingScope> capabilityScopes;
  final String providerApprovalPlaceholder;
  final bool isolationApproved;
  final bool observabilityApproved;
  final bool rollbackReady;

  bool get hasProviderOwner =>
      providerId.trim().isNotEmpty && ownerId.trim().isNotEmpty;

  bool get hasProviderApproval =>
      providerApprovalPlaceholder.trim().isNotEmpty;

  bool get hasCapabilityScope => capabilityScopes.isNotEmpty;
}
