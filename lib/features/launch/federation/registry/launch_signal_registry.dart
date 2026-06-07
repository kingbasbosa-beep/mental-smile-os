class LaunchSignalRegistry {
  const LaunchSignalRegistry._();

  static const String launchSurfaceAssessed = 'launch_surface_assessed';
  static const String launchBlockerDetected = 'launch_blocker_detected';
  static const String launchDependencyRecorded = 'launch_dependency_recorded';
  static const String launchReadinessUpdated = 'launch_readiness_updated';

  static const Set<String> values = <String>{
    launchSurfaceAssessed,
    launchBlockerDetected,
    launchDependencyRecorded,
    launchReadinessUpdated,
  };
}
