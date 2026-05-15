class ProviderOnboardingRuntimeMarker {
  const ProviderOnboardingRuntimeMarker({
    required this.runtimeMode,
    required this.networkingEnabled,
    required this.backendGoverned,
    required this.onboardingActive,
  });

  final String runtimeMode;
  final bool networkingEnabled;
  final bool backendGoverned;
  final bool onboardingActive;

  static const disabled = ProviderOnboardingRuntimeMarker(
    runtimeMode: 'disabled',
    networkingEnabled: false,
    backendGoverned: false,
    onboardingActive: false,
  );
}
