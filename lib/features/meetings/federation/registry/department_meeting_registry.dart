import 'package:flutterprojects/features/archive/export/registry/archive_export_package_type_registry.dart';
import 'package:flutterprojects/features/identity/federation/registry/department_identity_registry.dart';
import 'package:flutterprojects/features/reports/federation/registry/report_category_registry.dart';

import '../models/department_meeting_mapping.dart';
import 'meeting_type_registry.dart';

class DepartmentMeetingRegistry {
  const DepartmentMeetingRegistry._();

  static const List<DepartmentMeetingMapping> mappings =
      <DepartmentMeetingMapping>[
    DepartmentMeetingMapping(
      department: DepartmentIdentityRegistry.residential,
      meetingTypes: <String>{
        MeetingTypeRegistry.weeklyReview,
        MeetingTypeRegistry.residentialReview,
      },
      reportTypes: <String>{ReportCategoryRegistry.residential},
      archivePackageTypes: <String>{
        ArchiveExportPackageTypeRegistry.weeklyReportPack,
        ArchiveExportPackageTypeRegistry.departmentPack,
      },
    ),
    DepartmentMeetingMapping(
      department: DepartmentIdentityRegistry.commercial,
      meetingTypes: <String>{
        MeetingTypeRegistry.weeklyReview,
        MeetingTypeRegistry.commercialReview,
      },
      reportTypes: <String>{ReportCategoryRegistry.commercial},
      archivePackageTypes: <String>{
        ArchiveExportPackageTypeRegistry.weeklyReportPack,
        ArchiveExportPackageTypeRegistry.departmentPack,
      },
    ),
    DepartmentMeetingMapping(
      department: DepartmentIdentityRegistry.monitoring,
      meetingTypes: <String>{
        MeetingTypeRegistry.weeklyReview,
        MeetingTypeRegistry.monitoringReview,
      },
      reportTypes: <String>{ReportCategoryRegistry.monitoring},
      archivePackageTypes: <String>{
        ArchiveExportPackageTypeRegistry.weeklyReportPack,
        ArchiveExportPackageTypeRegistry.monthlyReportPack,
      },
    ),
    DepartmentMeetingMapping(
      department: DepartmentIdentityRegistry.ownerStrategy,
      meetingTypes: <String>{
        MeetingTypeRegistry.monthlyReview,
        MeetingTypeRegistry.strategicReview,
        MeetingTypeRegistry.ownerReview,
      },
      reportTypes: <String>{ReportCategoryRegistry.strategic},
      archivePackageTypes: <String>{
        ArchiveExportPackageTypeRegistry.strategicPack,
        ArchiveExportPackageTypeRegistry.monthlyReportPack,
      },
    ),
    DepartmentMeetingMapping(
      department: DepartmentIdentityRegistry.owner,
      meetingTypes: <String>{
        MeetingTypeRegistry.quarterlyReview,
        MeetingTypeRegistry.constitutionalReview,
        MeetingTypeRegistry.ownerReview,
      },
      reportTypes: <String>{ReportCategoryRegistry.constitutional},
      archivePackageTypes: <String>{
        ArchiveExportPackageTypeRegistry.constitutionalPack,
        ArchiveExportPackageTypeRegistry.archivePack,
      },
    ),
    DepartmentMeetingMapping(
      department: DepartmentIdentityRegistry.archive,
      meetingTypes: <String>{
        MeetingTypeRegistry.monthlyReview,
        MeetingTypeRegistry.annualReview,
      },
      reportTypes: <String>{ReportCategoryRegistry.archive},
      archivePackageTypes: <String>{
        ArchiveExportPackageTypeRegistry.archivePack,
        ArchiveExportPackageTypeRegistry.annualReportPack,
      },
    ),
  ];

  static DepartmentMeetingMapping? byDepartment(String department) {
    final normalized = department.trim();
    for (final mapping in mappings) {
      if (mapping.department == normalized) return mapping;
    }
    return null;
  }
}
