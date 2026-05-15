class RuntimeEnablementRuntimeMarker {
  const RuntimeEnablementRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.environment,
    required this.backendGoverned,
    required this.enablementActive,
  });

  final String runtimeMode;
  final String providerId;
  final String environment;
  final bool backendGoverned;
  final bool enablementActive;

  static const disabled = RuntimeEnablementRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    environment: 'local_placeholder',
    backendGoverned: false,
    enablementActive: false,
  );
}
