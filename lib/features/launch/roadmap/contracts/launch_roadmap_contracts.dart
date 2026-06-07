import '../models/launch_milestone.dart';
import '../models/launch_roadmap_snapshot.dart';
import '../reports/launch_roadmap_report.dart';

abstract class LaunchRoadmapBuilder {
  LaunchRoadmapSnapshot buildRoadmap();
}

abstract class LaunchMilestoneBuilder {
  LaunchMilestone buildMilestone();
}

abstract class LaunchExecutionPlanner {
  LaunchRoadmapReport buildExecutionPlan();
}
