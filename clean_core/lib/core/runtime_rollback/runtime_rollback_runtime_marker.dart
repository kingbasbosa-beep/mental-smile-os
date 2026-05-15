class RuntimeRollbackRuntimeMarker {
  const RuntimeRollbackRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.backendGoverned,
    required this.rollbackActive,
  });

  final String runtimeMode;
  final String providerId;
  final bool backendGoverned;
  final bool rollbackActive;

  static const disabled = RuntimeRollbackRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    backendGoverned: false,
    rollbackActive: false,
  );
}
