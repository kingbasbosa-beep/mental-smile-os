class SafetyMemoryRuntimeMarker {
  const SafetyMemoryRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.backendGoverned,
    required this.memoryRuntimeEnabled,
  });

  static const SafetyMemoryRuntimeMarker disabled = SafetyMemoryRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    backendGoverned: true,
    memoryRuntimeEnabled: false,
  );

  final String runtimeMode;
  final String providerId;
  final bool backendGoverned;
  final bool memoryRuntimeEnabled;

  Map<String, Object?> toMap() {
    return {
      'runtimeMode': runtimeMode,
      'providerId': providerId,
      'backendGoverned': backendGoverned,
      'memoryRuntimeEnabled': memoryRuntimeEnabled,
    };
  }
}
