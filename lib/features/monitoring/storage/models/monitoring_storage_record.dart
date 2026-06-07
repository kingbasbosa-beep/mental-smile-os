import 'storage_version.dart';

class MonitoringStorageRecord {
  const MonitoringStorageRecord({
    required this.recordId,
    required this.recordType,
    required this.sourceDomain,
    required this.createdAt,
    required this.period,
    required this.archiveCode,
    required this.reportPrefix,
    required this.version,
    required this.metadata,
    required this.payloadReference,
  });

  final String recordId;
  final String recordType;
  final String sourceDomain;
  final DateTime createdAt;
  final String period;
  final String archiveCode;
  final String reportPrefix;
  final StorageVersion version;
  final Map<String, String> metadata;
  final String payloadReference;

  bool get hasPayloadReferenceOnly {
    return payloadReference.trim().isNotEmpty;
  }
}
