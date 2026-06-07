import '../models/monitoring_storage_record.dart';

abstract class SnapshotStorageBuilder {
  MonitoringStorageRecord buildSnapshotRecord({
    required String recordType,
    required String sourceDomain,
    required String period,
    required String archiveCode,
    required String reportPrefix,
    required String payloadReference,
    Map<String, String> metadata,
  });
}

abstract class ReportStorageBuilder {
  MonitoringStorageRecord buildReportRecord({
    required String recordType,
    required String sourceDomain,
    required String period,
    required String archiveCode,
    required String reportPrefix,
    required String payloadReference,
    Map<String, String> metadata,
  });
}
