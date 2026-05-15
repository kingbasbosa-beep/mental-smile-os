class RuntimeWiringRuntimeMarker {
  const RuntimeWiringRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.backendGoverned,
    required this.wiringActive,
  });

  final String runtimeMode;
  final String providerId;
  final bool backendGoverned;
  final bool wiringActive;

  static const disabled = RuntimeWiringRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    backendGoverned: false,
    wiringActive: false,
  );
}
