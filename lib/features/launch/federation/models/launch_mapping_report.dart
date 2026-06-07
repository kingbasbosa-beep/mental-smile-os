import 'launch_blocker.dart';
import 'launch_readiness_snapshot.dart';
import 'surface_dependency.dart';

class LaunchMappingReport {
  const LaunchMappingReport({
    required this.surfaces,
    required this.dependencies,
    required this.blockers,
    required this.recommendations,
  });

  final List<LaunchReadinessSnapshot> surfaces;
  final List<SurfaceDependency> dependencies;
  final List<LaunchBlocker> blockers;
  final List<String> recommendations;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'surfaces': surfaces.map((surface) => surface.toMap()).toList(),
      'dependencies':
          dependencies.map((dependency) => dependency.toMap()).toList(),
      'blockers': blockers.map((blocker) => blocker.toMap()).toList(),
      'recommendations': recommendations,
    };
  }
}
