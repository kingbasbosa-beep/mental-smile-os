import 'package:flutterprojects/features/monitoring/storage/models/archive_eligibility.dart';
import 'package:flutterprojects/features/monitoring/storage/models/retention_class.dart';
import 'package:flutterprojects/features/monitoring/storage/registry/storage_object_type_registry.dart';
import 'package:flutterprojects/features/reports/federation/models/report_classification.dart';

import 'archive_export_package_type_registry.dart';

class ArchiveExportRegistry {
  const ArchiveExportRegistry._();

  static const String meetingPack = 'meeting_pack';
  static const String strategicPackObject = 'strategic_pack';
  static const String archivePackObject = 'archive_pack';

  static const Set<String> packageTypes = ArchiveExportPackageTypeRegistry.values;

  static const Set<String> supportedObjectTypes = <String>{
    ...StorageObjectTypeRegistry.values,
    meetingPack,
    strategicPackObject,
    archivePackObject,
  };

  static const Set<String> classificationRules = ReportClassification.values;

  static const Map<String, String> retentionMappings = <String, String>{
    ArchiveExportPackageTypeRegistry.weeklyReportPack: RetentionClass.operational,
    ArchiveExportPackageTypeRegistry.monthlyReportPack: RetentionClass.annual,
    ArchiveExportPackageTypeRegistry.quarterlyReportPack: RetentionClass.annual,
    ArchiveExportPackageTypeRegistry.annualReportPack: RetentionClass.historical,
    ArchiveExportPackageTypeRegistry.strategicPack: RetentionClass.sovereign,
    ArchiveExportPackageTypeRegistry.constitutionalPack:
        RetentionClass.constitutional,
    ArchiveExportPackageTypeRegistry.departmentPack: RetentionClass.historical,
    ArchiveExportPackageTypeRegistry.archivePack: RetentionClass.sovereign,
    ArchiveExportPackageTypeRegistry.reputationPack: RetentionClass.historical,
    ArchiveExportPackageTypeRegistry.toolMeterPack: RetentionClass.historical,
  };

  static const Map<String, String> archiveMappings = <String, String>{
    ArchiveExportPackageTypeRegistry.weeklyReportPack:
        ArchiveEligibility.eligible,
    ArchiveExportPackageTypeRegistry.monthlyReportPack:
        ArchiveEligibility.eligible,
    ArchiveExportPackageTypeRegistry.quarterlyReportPack:
        ArchiveEligibility.eligible,
    ArchiveExportPackageTypeRegistry.annualReportPack:
        ArchiveEligibility.eligible,
    ArchiveExportPackageTypeRegistry.strategicPack: ArchiveEligibility.ownerOnly,
    ArchiveExportPackageTypeRegistry.constitutionalPack:
        ArchiveEligibility.constitutionalOnly,
    ArchiveExportPackageTypeRegistry.departmentPack:
        ArchiveEligibility.restricted,
    ArchiveExportPackageTypeRegistry.archivePack: ArchiveEligibility.ownerOnly,
    ArchiveExportPackageTypeRegistry.reputationPack:
        ArchiveEligibility.restricted,
    ArchiveExportPackageTypeRegistry.toolMeterPack:
        ArchiveEligibility.restricted,
  };
}
