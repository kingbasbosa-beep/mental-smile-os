class RuntimeReleaseRuntimeMarker {
  const RuntimeReleaseRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.backendGoverned,
    required this.releaseActive,
  });

  final String runtimeMode;
  final String providerId;
  final bool backendGoverned;
  final bool releaseActive;

  static const disabled = RuntimeReleaseRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    backendGoverned: false,
    releaseActive: false,
  );
}
