import 'launch_milestone.dart';
import 'launch_roadmap_item.dart';

class LaunchRoadmapSnapshot {
  const LaunchRoadmapSnapshot({
    required this.currentPhase,
    required this.milestones,
    required this.blockedItems,
    required this.recommendedExecutionOrder,
  });

  final String currentPhase;
  final List<LaunchMilestone> milestones;
  final List<LaunchRoadmapItem> blockedItems;
  final List<String> recommendedExecutionOrder;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'currentPhase': currentPhase,
      'milestones': milestones.map((milestone) => milestone.toMap()).toList(),
      'blockedItems': blockedItems.map((item) => item.toMap()).toList(),
      'recommendedExecutionOrder': recommendedExecutionOrder,
    };
  }
}
