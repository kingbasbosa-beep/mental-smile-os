import 'package:flutterprojects/features/archive/export/registry/archive_export_package_type_registry.dart';
import 'package:flutterprojects/features/reports/federation/registry/report_category_registry.dart';

import '../models/meeting_system_readiness_snapshot.dart';
import '../registry/meeting_type_registry.dart';

class MeetingSystemReadinessBuilder {
  const MeetingSystemReadinessBuilder._();

  static MeetingSystemReadinessSnapshot currentFoundationSnapshot() {
    return const MeetingSystemReadinessSnapshot(
      supportedMeetingTypes: MeetingTypeRegistry.values,
      supportedPackageTypes: ArchiveExportPackageTypeRegistry.values,
      supportedReports: ReportCategoryRegistry.values,
      complianceStatus: 'foundation_ready_no_runtime_meetings',
    );
  }
}
