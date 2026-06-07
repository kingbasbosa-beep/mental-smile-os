class ArchiveExportReadinessSnapshot {
  const ArchiveExportReadinessSnapshot({
    required this.supportedPackages,
    required this.supportedObjects,
    required this.unsupportedObjects,
    required this.complianceStatus,
  });

  final Set<String> supportedPackages;
  final Set<String> supportedObjects;
  final Set<String> unsupportedObjects;
  final String complianceStatus;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'supportedPackages': supportedPackages.toList(),
      'supportedObjects': supportedObjects.toList(),
      'unsupportedObjects': unsupportedObjects.toList(),
      'complianceStatus': complianceStatus,
    };
  }
}
