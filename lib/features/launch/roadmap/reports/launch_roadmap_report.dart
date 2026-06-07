import '../models/launch_milestone.dart';
import '../models/launch_roadmap_item.dart';

class LaunchRoadmapReport {
  const LaunchRoadmapReport({
    required this.phases,
    required this.milestones,
    required this.blockers,
    required this.recommendedExecutionOrder,
  });

  final List<String> phases;
  final List<LaunchMilestone> milestones;
  final List<LaunchRoadmapItem> blockers;
  final List<String> recommendedExecutionOrder;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'phases': phases,
      'milestones': milestones.map((milestone) => milestone.toMap()).toList(),
      'blockers': blockers.map((blocker) => blocker.toMap()).toList(),
      'recommendedExecutionOrder': recommendedExecutionOrder,
    };
  }
}
