class ResponseRuntimeMarker {
  const ResponseRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.backendGoverned,
  });

  static const ResponseRuntimeMarker disabled = ResponseRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    backendGoverned: true,
  );

  final String runtimeMode;
  final String providerId;
  final bool backendGoverned;

  Map<String, Object?> toMap() {
    return {
      'runtimeMode': runtimeMode,
      'providerId': providerId,
      'backendGoverned': backendGoverned,
    };
  }
}
