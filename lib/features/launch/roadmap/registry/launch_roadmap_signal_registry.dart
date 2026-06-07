class LaunchRoadmapSignalRegistry {
  const LaunchRoadmapSignalRegistry._();

  static const String roadmapItemCreated = 'roadmap_item_created';
  static const String roadmapPhaseUpdated = 'roadmap_phase_updated';
  static const String milestoneReached = 'milestone_reached';
  static const String launchPathUpdated = 'launch_path_updated';

  static const Set<String> values = <String>{
    roadmapItemCreated,
    roadmapPhaseUpdated,
    milestoneReached,
    launchPathUpdated,
  };
}
