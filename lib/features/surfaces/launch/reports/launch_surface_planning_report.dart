import '../models/archive_launch_surface_models.dart';
import '../models/client_launch_surface_models.dart';
import '../models/control_room_cleanup_models.dart';
import '../models/duplicate_function_models.dart';
import '../models/function_conflict_models.dart';
import '../models/monitoring_launch_surface_models.dart';
import '../models/s_suffix_naming_models.dart';

class LaunchSurfacePlanningReport {
  const LaunchSurfacePlanningReport({
    required this.clientSurface,
    required this.monitoringSurface,
    required this.archiveSurface,
    required this.duplicateFunctions,
    required this.functionConflicts,
    required this.namingProfiles,
    required this.controlRoomCleanup,
    required this.complianceStatus,
  });

  final ClientLaunchSurfaceProfile clientSurface;
  final MonitoringLaunchSurfaceProfile monitoringSurface;
  final ArchiveLaunchSurfaceProfile archiveSurface;
  final List<DuplicateFunctionProfile> duplicateFunctions;
  final List<FunctionConflictProfile> functionConflicts;
  final List<SSuffixNamingProfile> namingProfiles;
  final List<ControlRoomCleanupProfile> controlRoomCleanup;
  final String complianceStatus;
}
