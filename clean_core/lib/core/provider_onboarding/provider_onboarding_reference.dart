import 'provider_onboarding_scope.dart';

class ProviderOnboardingReference {
  const ProviderOnboardingReference({
    required this.referenceId,
    required this.scope,
    this.hashPlaceholder,
  });

  final String referenceId;
  final ProviderOnboardingScope scope;
  final String? hashPlaceholder;

  bool get isLinked => referenceId.trim().isNotEmpty;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'referenceId': referenceId,
      'scope': scope.key,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
