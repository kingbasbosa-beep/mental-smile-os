class RuntimeActivationRuntimeMarker {
  const RuntimeActivationRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.environment,
    required this.backendGoverned,
    required this.extractionReady,
  });

  final String runtimeMode;
  final String providerId;
  final String environment;
  final bool backendGoverned;
  final bool extractionReady;

  static const disabled = RuntimeActivationRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    environment: 'local_placeholder',
    backendGoverned: false,
    extractionReady: false,
  );
}
