class SecureRuntimeRuntimeMarker {
  const SecureRuntimeRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.environment,
    required this.backendGoverned,
  });

  static const SecureRuntimeRuntimeMarker disabled =
      SecureRuntimeRuntimeMarker(
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
