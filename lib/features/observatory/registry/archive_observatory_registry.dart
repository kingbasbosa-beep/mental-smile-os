import '../models/archive_observatory_models.dart';

class ArchiveObservatoryRegistry {
  const ArchiveObservatoryRegistry._();

  static const ArchiveObservatoryProfile profile = ArchiveObservatoryProfile(
    profileId: 'archive_observatory_v1',
    archiveObjects: <String>{
      'archive_export_package',
      'meeting_pack',
      'readiness_snapshot',
      'tool_meter_pack',
    },
    reportLinks: <String>{
      'federation_report',
      'operational_readiness_report',
      'launch_roadmap_report',
    },
  );
}
