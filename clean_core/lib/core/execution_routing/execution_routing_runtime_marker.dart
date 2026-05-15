class ExecutionRoutingRuntimeMarker {
  const ExecutionRoutingRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.backendGoverned,
    required this.routingActive,
  });

  final String runtimeMode;
  final String providerId;
  final bool backendGoverned;
  final bool routingActive;

  static const disabled = ExecutionRoutingRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    backendGoverned: false,
    routingActive: false,
  );
}
