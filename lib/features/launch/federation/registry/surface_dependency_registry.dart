import '../models/surface_dependency.dart';
import 'launch_surface_registry.dart';

class SurfaceDependencyRegistry {
  const SurfaceDependencyRegistry._();

  static const String legacyDependency = 'legacy_dependency';
  static const String ghostDependency = 'ghost_dependency';
  static const String federationDependency = 'federation_dependency';

  static const Set<String> dependencyTypes = <String>{
    legacyDependency,
    ghostDependency,
    federationDependency,
  };

  static const List<SurfaceDependency> dependencies = <SurfaceDependency>[
    SurfaceDependency(
      surface: LaunchSurfaceRegistry.app,
      dependency: 'client_room_contact_runtime',
      dependencyType: federationDependency,
    ),
    SurfaceDependency(
      surface: LaunchSurfaceRegistry.app,
      dependency: 'ghost_route_isolation',
      dependencyType: ghostDependency,
    ),
    SurfaceDependency(
      surface: LaunchSurfaceRegistry.web,
      dependency: 'signal_first_public_surfaces',
      dependencyType: federationDependency,
    ),
    SurfaceDependency(
      surface: LaunchSurfaceRegistry.monitoring,
      dependency: 'monitoring_storage_foundation',
      dependencyType: federationDependency,
    ),
    SurfaceDependency(
      surface: LaunchSurfaceRegistry.owner,
      dependency: 'archive_export_and_meeting_foundation',
      dependencyType: federationDependency,
    ),
    SurfaceDependency(
      surface: LaunchSurfaceRegistry.archive,
      dependency: 'archive_export_foundation',
      dependencyType: federationDependency,
    ),
    SurfaceDependency(
      surface: LaunchSurfaceRegistry.commercial,
      dependency: 'tool_meter_and_reputation_foundation',
      dependencyType: federationDependency,
    ),
    SurfaceDependency(
      surface: LaunchSurfaceRegistry.app,
      dependency: 'legacy_session_payment_routes',
      dependencyType: legacyDependency,
    ),
  ];
}
