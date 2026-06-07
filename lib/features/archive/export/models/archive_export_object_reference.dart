class ArchiveExportObjectReference {
  const ArchiveExportObjectReference({
    required this.objectType,
    required this.objectId,
    required this.sourceDomain,
    required this.archiveCode,
    required this.reportPrefix,
    required this.version,
  });

  final String objectType;
  final String objectId;
  final String sourceDomain;
  final String archiveCode;
  final String reportPrefix;
  final String version;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'objectType': objectType,
      'objectId': objectId,
      'sourceDomain': sourceDomain,
      'archiveCode': archiveCode,
      'reportPrefix': reportPrefix,
      'version': version,
    };
  }
}
