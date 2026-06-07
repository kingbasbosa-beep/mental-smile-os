class LaunchSurfaceSignalRegistry {
  const LaunchSurfaceSignalRegistry._();

  static const String launchSurfaceDefined = 'launch_surface_defined';
  static const String duplicateFunctionDetected =
      'duplicate_function_detected';
  static const String functionConflictDetected = 'function_conflict_detected';
  static const String cleanupActionDefined = 'cleanup_action_defined';
  static const String surfaceBlueprintRegistered =
      'surface_blueprint_registered';

  static const Set<String> values = <String>{
    launchSurfaceDefined,
    duplicateFunctionDetected,
    functionConflictDetected,
    cleanupActionDefined,
    surfaceBlueprintRegistered,
  };
}
