import '../models/report_classification.dart';
import '../models/report_period.dart';
import 'report_category_registry.dart';

class FederationReportRegistry {
  const FederationReportRegistry._();

  static const Set<String> reportTypes = <String>{
    'residential_report',
    'commercial_report',
    'operational_report',
    'strategic_report',
    'constitutional_report',
    'archive_report',
    'monitoring_report',
  };

  static const Set<String> reportCategories = ReportCategoryRegistry.values;
  static const Set<String> reportPeriods = ReportPeriod.values;

  static const Map<String, String> reportPrefixes = <String, String>{
    ReportCategoryRegistry.residential: 'RES',
    ReportCategoryRegistry.commercial: 'COM',
    ReportCategoryRegistry.operational: 'OPS',
    ReportCategoryRegistry.strategic: 'STR',
    ReportCategoryRegistry.constitutional: 'CON',
    ReportCategoryRegistry.archive: 'ARC',
    ReportCategoryRegistry.monitoring: 'MON',
  };

  static const Map<String, String> classificationRules = <String, String>{
    ReportCategoryRegistry.residential: ReportClassification.restricted,
    ReportCategoryRegistry.commercial: ReportClassification.restricted,
    ReportCategoryRegistry.operational: ReportClassification.internal,
    ReportCategoryRegistry.strategic: ReportClassification.ownerOnly,
    ReportCategoryRegistry.constitutional: ReportClassification.constitutional,
    ReportCategoryRegistry.archive: ReportClassification.restricted,
    ReportCategoryRegistry.monitoring: ReportClassification.internal,
  };
}
