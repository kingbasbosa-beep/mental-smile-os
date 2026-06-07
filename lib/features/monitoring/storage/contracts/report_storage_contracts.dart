import '../models/monitoring_storage_record.dart';

abstract class ResidentialReportStorageContract {
  Future<MonitoringStorageRecord> storeResidentialReportReference(
    MonitoringStorageRecord record,
  );
}

abstract class CommercialReportStorageContract {
  Future<MonitoringStorageRecord> storeCommercialReportReference(
    MonitoringStorageRecord record,
  );
}

abstract class OperationalReportStorageContract {
  Future<MonitoringStorageRecord> storeOperationalReportReference(
    MonitoringStorageRecord record,
  );
}
