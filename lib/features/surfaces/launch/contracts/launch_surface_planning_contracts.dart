import '../models/archive_launch_surface_models.dart';
import '../models/client_launch_surface_models.dart';
import '../models/control_room_cleanup_models.dart';
import '../models/function_conflict_models.dart';
import '../models/monitoring_launch_surface_models.dart';

abstract class LaunchSurfaceBlueprintBuilder {
  ClientLaunchSurfaceProfile buildClientBlueprint();

  MonitoringLaunchSurfaceProfile buildMonitoringBlueprint();

  ArchiveLaunchSurfaceProfile buildArchiveBlueprint();
}

abstract class DuplicateFunctionSweep {
  FunctionConflictReport buildConflictReport();
}

abstract class ControlRoomCleanupPlanner {
  List<ControlRoomCleanupProfile> plannedCleanupProfiles();
}
