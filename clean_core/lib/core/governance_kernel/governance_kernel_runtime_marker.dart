class GovernanceKernelRuntimeMarker {
  const GovernanceKernelRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.environment,
    required this.backendGoverned,
  });

  static const GovernanceKernelRuntimeMarker disabled =
      GovernanceKernelRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    environment: 'fallback_only',
    backendGoverned: true,
  );

  final String runtimeMode;
  final String providerId;
  final String environment;
  final bool backendGoverned;

  Map<String, Object?> toMap() {
    return {
      'runtimeMode': runtimeMode,
      'providerId': providerId,
      'environment': environment,
      'backendGoverned': backendGoverned,
    };
  }
}
