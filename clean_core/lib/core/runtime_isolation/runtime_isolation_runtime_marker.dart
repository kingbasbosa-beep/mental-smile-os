class RuntimeIsolationRuntimeMarker {
  const RuntimeIsolationRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.backendGoverned,
    required this.isolationActive,
  });

  final String runtimeMode;
  final String providerId;
  final bool backendGoverned;
  final bool isolationActive;

  static const disabled = RuntimeIsolationRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    backendGoverned: false,
    isolationActive: false,
  );
}
