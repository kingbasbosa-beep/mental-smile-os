class ArchitectureManifestRuntimeMarker {
  const ArchitectureManifestRuntimeMarker({
    required this.runtimeMode,
    required this.providerId,
    required this.environment,
    required this.backendGoverned,
    required this.extractionReady,
  });

  static const ArchitectureManifestRuntimeMarker disabled =
      ArchitectureManifestRuntimeMarker(
    runtimeMode: 'disabled',
    providerId: '',
    environment: 'fallback_only',
    backendGoverned: true,
    extractionReady: false,
  );

  final String runtimeMode;
  final String providerId;
  final String environment;
  final bool backendGoverned;
  final bool extractionReady;
}
