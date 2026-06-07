import '../models/control_room_cleanup_models.dart';
import 'launch_cleanup_action.dart';

class ControlRoomCleanupRegistry {
  const ControlRoomCleanupRegistry._();

  static const String button = 'button';
  static const String tab = 'tab';
  static const String counter = 'counter';
  static const String badge = 'badge';
  static const String card = 'card';
  static const String quickAction = 'quick_action';
  static const String drawerEntry = 'drawer_entry';

  static const Set<String> referenceTypes = <String>{
    button,
    tab,
    counter,
    badge,
    card,
    quickAction,
    drawerEntry,
  };

  static const List<ControlRoomCleanupProfile> profiles =
      <ControlRoomCleanupProfile>[
    ControlRoomCleanupProfile(
      profileId: 'old_control_room_queue_counter',
      referenceType: counter,
      oldReference: 'ControlRoomQueueCounter',
      federationReplacement: 'MonitoringDemandCounterS',
      cleanupAction: LaunchCleanupAction.freeze,
    ),
    ControlRoomCleanupProfile(
      profileId: 'old_control_room_export_card',
      referenceType: card,
      oldReference: 'ControlRoomExportCard',
      federationReplacement: 'ArchiveReportCardS',
      cleanupAction: LaunchCleanupAction.replace,
    ),
    ControlRoomCleanupProfile(
      profileId: 'old_control_room_quick_action',
      referenceType: quickAction,
      oldReference: 'ControlRoomProgressQuickAction',
      federationReplacement: 'ClientGuidanceCardS',
      cleanupAction: LaunchCleanupAction.hide,
    ),
  ];
}
