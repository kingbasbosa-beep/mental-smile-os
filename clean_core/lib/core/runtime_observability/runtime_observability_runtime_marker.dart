class RuntimeObservabilityRuntimeMarker {
  const RuntimeObservabilityRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.backendGoverned,
    required this.observabilityActive,
  });

  final String runtimeMode;
  final String providerId;
  final bool backendGoverned;
  final bool observabilityActive;

  static const disabled = RuntimeObservabilityRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    backendGoverned: false,
    observabilityActive: false,
  );
}
