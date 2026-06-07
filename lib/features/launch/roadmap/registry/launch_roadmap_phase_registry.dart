class LaunchRoadmapPhaseRegistry {
  const LaunchRoadmapPhaseRegistry._();

  static const String stabilization = 'stabilization';
  static const String readiness = 'readiness';
  static const String separation = 'separation';
  static const String launch = 'launch';
  static const String expansion = 'expansion';

  static const Set<String> values = <String>{
    stabilization,
    readiness,
    separation,
    launch,
    expansion,
  };
}
