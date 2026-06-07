import '../models/launch_milestone.dart';
import '../models/launch_readiness_alignment.dart';
import '../models/launch_roadmap_item.dart';
import '../models/launch_roadmap_snapshot.dart';
import '../models/roadmap_dependency.dart';
import '../registry/launch_roadmap_phase_registry.dart';
import '../registry/launch_roadmap_priority.dart';
import '../reports/launch_roadmap_report.dart';

class LaunchRoadmapFoundationBuilder {
  const LaunchRoadmapFoundationBuilder._();

  static const List<LaunchReadinessAlignment> readinessAlignments =
      <LaunchReadinessAlignment>[
    LaunchReadinessAlignment(
      readinessGapId: 'legacy_gap',
      requirementId: 'app_contact_runtime_ready',
      roadmapItemId: 'isolate_legacy_routes',
    ),
    LaunchReadinessAlignment(
      readinessGapId: 'federation_gap',
      requirementId: 'owner_capsule_required',
      roadmapItemId: 'build_owner_capsule_foundation',
    ),
  ];

  static LaunchRoadmapSnapshot currentFoundationSnapshot() {
    return const LaunchRoadmapSnapshot(
      currentPhase: LaunchRoadmapPhaseRegistry.readiness,
      milestones: <LaunchMilestone>[
        LaunchMilestone(
          milestoneId: 'readiness_language_ready',
          title: 'Operational readiness language is available',
          surface: 'federation',
          successCriteria: <String>[
            'Readiness scores exist',
            'Launch status exists',
            'Required actions can be mapped',
          ],
        ),
        LaunchMilestone(
          milestoneId: 'owner_capsule_ready',
          title: 'Owner capsule foundation is available',
          surface: 'owner',
          successCriteria: <String>[
            'Sovereign assets are mapped',
            'Recovery assets are separated',
            'Owner does not become admin',
          ],
        ),
      ],
      blockedItems: <LaunchRoadmapItem>[
        LaunchRoadmapItem(
          itemId: 'build_owner_capsule_foundation',
          title: 'Build Owner Capsule Foundation',
          description:
              'Create sovereign capsule language before owner launch planning.',
          phase: LaunchRoadmapPhaseRegistry.readiness,
          priority: LaunchRoadmapPriority.critical,
          dependencies: <RoadmapDependency>[
            RoadmapDependency(
              dependencyId: 'meeting_archive_foundation',
              dependencyType: 'federation_dependency',
              description: 'Owner capsule depends on archive and meetings.',
            ),
          ],
          targetSurface: 'owner',
        ),
        LaunchRoadmapItem(
          itemId: 'isolate_legacy_routes',
          title: 'Keep Ghost Routes Isolated',
          description:
              'Prevent legacy routes from becoming modern launch surfaces.',
          phase: LaunchRoadmapPhaseRegistry.separation,
          priority: LaunchRoadmapPriority.high,
          dependencies: <RoadmapDependency>[
            RoadmapDependency(
              dependencyId: 'ghost_route_isolation_foundation',
              dependencyType: 'ghost_dependency',
              description: 'Route classification exists and must be preserved.',
            ),
          ],
          targetSurface: 'app',
        ),
      ],
      recommendedExecutionOrder: <String>[
        'build_owner_capsule_foundation',
        'isolate_legacy_routes',
        'prepare_monitoring_storage_activation',
        'prepare_operational_launch_checklist',
        'begin_separation_execution_map',
      ],
    );
  }

  static LaunchRoadmapReport currentFoundationReport() {
    final snapshot = currentFoundationSnapshot();
    return LaunchRoadmapReport(
      phases: LaunchRoadmapPhaseRegistry.values.toList(),
      milestones: snapshot.milestones,
      blockers: snapshot.blockedItems,
      recommendedExecutionOrder: snapshot.recommendedExecutionOrder,
    );
  }
}
