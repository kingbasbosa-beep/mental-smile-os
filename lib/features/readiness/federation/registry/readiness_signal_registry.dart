class ReadinessSignalRegistry {
  const ReadinessSignalRegistry._();

  static const String readinessAssessed = 'readiness_assessed';
  static const String readinessGapDetected = 'readiness_gap_detected';
  static const String readinessRecommendationCreated =
      'readiness_recommendation_created';
  static const String launchStatusUpdated = 'launch_status_updated';

  static const Set<String> values = <String>{
    readinessAssessed,
    readinessGapDetected,
    readinessRecommendationCreated,
    launchStatusUpdated,
  };
}
