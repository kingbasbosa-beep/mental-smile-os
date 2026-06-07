import 'roadmap_dependency.dart';

class LaunchRoadmapItem {
  const LaunchRoadmapItem({
    required this.itemId,
    required this.title,
    required this.description,
    required this.phase,
    required this.priority,
    required this.dependencies,
    required this.targetSurface,
  });

  final String itemId;
  final String title;
  final String description;
  final String phase;
  final String priority;
  final List<RoadmapDependency> dependencies;
  final String targetSurface;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'itemId': itemId,
      'title': title,
      'description': description,
      'phase': phase,
      'priority': priority,
      'dependencies':
          dependencies.map((dependency) => dependency.toMap()).toList(),
      'targetSurface': targetSurface,
    };
  }
}
