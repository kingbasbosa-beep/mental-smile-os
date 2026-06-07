class LaunchRoadmapPriority {
  const LaunchRoadmapPriority._();

  static const String critical = 'critical';
  static const String high = 'high';
  static const String normal = 'normal';
  static const String future = 'future';

  static const Set<String> values = <String>{
    critical,
    high,
    normal,
    future,
  };
}
