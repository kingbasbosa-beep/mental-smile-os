import '../models/legacy_new_conflict_models.dart';
import 'launch_cleanup_action.dart';

class LegacyNewConflictRegistry {
  const LegacyNewConflictRegistry._();

  static const List<LegacyNewConflictProfile> conflicts =
      <LegacyNewConflictProfile>[
    LegacyNewConflictProfile(
      conflictId: 'client_old_progress_vs_signal_space',
      legacyFunction: 'ClientProgressCard',
      federationFunction: 'ClientSignalsSummaryCardS',
      cleanupAction: LaunchCleanupAction.replace,
    ),
    LegacyNewConflictProfile(
      conflictId: 'control_room_old_queue_vs_monitoring_surface',
      legacyFunction: 'ControlRoomQueueCounter',
      federationFunction: 'MonitoringDemandCounterS',
      cleanupAction: LaunchCleanupAction.freeze,
    ),
    LegacyNewConflictProfile(
      conflictId: 'archive_old_export_vs_archive_package',
      legacyFunction: 'LegacyExportButton',
      federationFunction: 'ArchivePackageExportActionS',
      cleanupAction: LaunchCleanupAction.hide,
    ),
  ];
}
