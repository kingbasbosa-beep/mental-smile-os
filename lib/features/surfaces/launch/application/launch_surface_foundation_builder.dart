import '../domain/launch_surface_boundary.dart';
import '../registry/control_room_cleanup_registry.dart';
import '../registry/duplicate_function_registry.dart';
import '../registry/function_conflict_registry.dart';
import '../registry/launch_surface_blueprint_registry.dart';
import '../registry/s_suffix_naming_registry.dart';
import '../reports/launch_surface_planning_report.dart';

class LaunchSurfaceFoundationBuilder {
  const LaunchSurfaceFoundationBuilder._();

  static LaunchSurfacePlanningReport currentFoundationReport() {
    final allNames = <String>[
      LaunchSurfaceBlueprintRegistry.client.surfaceId,
      LaunchSurfaceBlueprintRegistry.monitoring.surfaceId,
      LaunchSurfaceBlueprintRegistry.archive.surfaceId,
      ...SSuffixNamingRegistry.examples.map((profile) => profile.federationName),
    ];

    final compliant = allNames.every(LaunchSurfaceBoundary.allowsName);

    return LaunchSurfacePlanningReport(
      clientSurface: LaunchSurfaceBlueprintRegistry.client,
      monitoringSurface: LaunchSurfaceBlueprintRegistry.monitoring,
      archiveSurface: LaunchSurfaceBlueprintRegistry.archive,
      duplicateFunctions: DuplicateFunctionRegistry.knownDuplicates,
      functionConflicts: FunctionConflictRegistry.knownConflicts,
      namingProfiles: SSuffixNamingRegistry.examples,
      controlRoomCleanup: ControlRoomCleanupRegistry.profiles,
      complianceStatus: compliant ? 'compliant' : 'needs_review',
    );
  }
}
