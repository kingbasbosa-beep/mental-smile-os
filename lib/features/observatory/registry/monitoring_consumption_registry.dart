import '../models/monitoring_consumption_models.dart';

class MonitoringConsumptionRegistry {
  const MonitoringConsumptionRegistry._();

  static const String residentialAggregates = 'residential_aggregates';
  static const String commercialAggregates = 'commercial_aggregates';
  static const String operationalAggregates = 'operational_aggregates';
  static const String storageSnapshots = 'storage_snapshots';
  static const String readinessReports = 'readiness_reports';

  static const MonitoringConsumptionProfile foundationProfile =
      MonitoringConsumptionProfile(
    profileId: 'observatory_consumption_v1',
    canBeObserved: <String>{
      residentialAggregates,
      commercialAggregates,
      operationalAggregates,
      storageSnapshots,
      readinessReports,
    },
    canBeAggregated: <String>{
      residentialAggregates,
      commercialAggregates,
      operationalAggregates,
    },
    canBeReported: <String>{
      storageSnapshots,
      readinessReports,
    },
  );
}
