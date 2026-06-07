import '../models/monitoring_storage_record.dart';

abstract class ResidentialSnapshotStorageContract {
  Future<MonitoringStorageRecord> storeResidentialSnapshotReference(
    MonitoringStorageRecord record,
  );
}

abstract class CommercialSnapshotStorageContract {
  Future<MonitoringStorageRecord> storeCommercialSnapshotReference(
    MonitoringStorageRecord record,
  );
}

abstract class OperationalSnapshotStorageContract {
  Future<MonitoringStorageRecord> storeOperationalSnapshotReference(
    MonitoringStorageRecord record,
  );
}
