class RuntimeBootstrapRuntimeMarker {
  const RuntimeBootstrapRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.backendGoverned,
    required this.bootstrapActive,
  });

  final String runtimeMode;
  final String providerId;
  final bool backendGoverned;
  final bool bootstrapActive;

  static const disabled = RuntimeBootstrapRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    backendGoverned: false,
    bootstrapActive: false,
  );
}
