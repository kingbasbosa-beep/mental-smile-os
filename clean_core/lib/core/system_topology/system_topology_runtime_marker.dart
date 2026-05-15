class SystemTopologyRuntimeMarker {
  const SystemTopologyRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.environment,
    required this.backendGoverned,
  });

  static const SystemTopologyRuntimeMarker disabled =
      SystemTopologyRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    environment: 'fallback_only',
    backendGoverned: true,
  );

  final String runtimeMode;
  final String providerId;
  final String environment;
  final bool backendGoverned;
}
