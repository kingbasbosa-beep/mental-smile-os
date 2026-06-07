class SurfaceSignalRegistry {
  const SurfaceSignalRegistry._();

  static const String surfaceRegistered = 'surface_registered';
  static const String surfaceReferenceDetected = 'surface_reference_detected';
  static const String legacyNavigationDetected = 'legacy_navigation_detected';
  static const String ghostRouteClassified = 'ghost_route_classified';
  static const String surfaceCleanupDefined = 'surface_cleanup_defined';

  static const Set<String> values = <String>{
    surfaceRegistered,
    surfaceReferenceDetected,
    legacyNavigationDetected,
    ghostRouteClassified,
    surfaceCleanupDefined,
  };
}
