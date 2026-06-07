import '../models/launch_blocker.dart';
import '../models/launch_mapping_report.dart';
import '../models/launch_readiness_snapshot.dart';
import '../registry/launch_readiness_classification.dart';
import '../registry/launch_surface_registry.dart';
import '../registry/surface_dependency_registry.dart';

class LaunchMappingFoundationBuilder {
  const LaunchMappingFoundationBuilder._();

  static LaunchMappingReport currentFoundationReport() {
    return const LaunchMappingReport(
      surfaces: <LaunchReadinessSnapshot>[
        LaunchReadinessSnapshot(
          surfaceId: LaunchSurfaceRegistry.app,
          readinessScore: 60,
          blockers: <String>['legacy_session_payment_routes'],
          warnings: <String>['ghost_route_isolation_required'],
          dependencies: <String>[
            'client_room_contact_runtime',
            'ghost_route_isolation',
          ],
        ),
        LaunchReadinessSnapshot(
          surfaceId: LaunchSurfaceRegistry.web,
          readinessScore: 65,
          blockers: <String>[],
          warnings: <String>['public_surface_alignment_required'],
          dependencies: <String>['signal_first_public_surfaces'],
        ),
        LaunchReadinessSnapshot(
          surfaceId: LaunchSurfaceRegistry.monitoring,
          readinessScore: 70,
          blockers: <String>[],
          warnings: <String>['storage_runtime_not_active'],
          dependencies: <String>['monitoring_storage_foundation'],
        ),
        LaunchReadinessSnapshot(
          surfaceId: LaunchSurfaceRegistry.owner,
          readinessScore: 55,
          blockers: <String>['owner_capsule_missing'],
          warnings: <String>['owner_room_should_not_become_admin'],
          dependencies: <String>['archive_export_and_meeting_foundation'],
        ),
        LaunchReadinessSnapshot(
          surfaceId: LaunchSurfaceRegistry.archive,
          readinessScore: 72,
          blockers: <String>[],
          warnings: <String>['export_runtime_not_active'],
          dependencies: <String>['archive_export_foundation'],
        ),
        LaunchReadinessSnapshot(
          surfaceId: LaunchSurfaceRegistry.commercial,
          readinessScore: 68,
          blockers: <String>[],
          warnings: <String>['commercial_room_ui_not_active'],
          dependencies: <String>['tool_meter_and_reputation_foundation'],
        ),
      ],
      dependencies: SurfaceDependencyRegistry.dependencies,
      blockers: <LaunchBlocker>[
        LaunchBlocker(
          blockerId: 'legacy_session_payment_routes',
          severity: LaunchReadinessClassification.legacyDependent,
          surface: LaunchSurfaceRegistry.app,
          description:
              'App launch still needs legacy session/payment route isolation.',
        ),
        LaunchBlocker(
          blockerId: 'owner_capsule_missing',
          severity: LaunchReadinessClassification.partial,
          surface: LaunchSurfaceRegistry.owner,
          description:
              'Owner launch needs capsule foundation before sovereign launch.',
        ),
      ],
      recommendations: <String>[
        'Complete owner capsule foundation before owner launch.',
        'Keep ghost routes classified before any navigation rebuild.',
        'Launch monitoring from stored snapshots, not raw legacy data.',
      ],
    );
  }
}
