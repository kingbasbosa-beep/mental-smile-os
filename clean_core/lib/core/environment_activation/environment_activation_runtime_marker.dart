class EnvironmentActivationRuntimeMarker {
  const EnvironmentActivationRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.backendGoverned,
    required this.environmentActive,
  });

  final String runtimeMode;
  final String providerId;
  final bool backendGoverned;
  final bool environmentActive;

  static const disabled = EnvironmentActivationRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    backendGoverned: false,
    environmentActive: false,
  );
}
