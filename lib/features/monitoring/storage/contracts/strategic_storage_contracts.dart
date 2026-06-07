import '../models/monitoring_storage_record.dart';

abstract class StrategicSummaryStorageContract {
  Future<MonitoringStorageRecord> storeStrategicSummaryReference(
    MonitoringStorageRecord record,
  );
}

abstract class ConstitutionalReportStorageContract {
  Future<MonitoringStorageRecord> storeConstitutionalReportReference(
    MonitoringStorageRecord record,
  );
}
