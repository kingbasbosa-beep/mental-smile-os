class SovereignArchivePackage {
  const SovereignArchivePackage({
    required this.packageId,
    required this.packageCode,
    required this.classification,
    required this.title,
    required this.archiveReady,
  });

  final String packageId;
  final String packageCode;
  final String classification;
  final String title;
  final bool archiveReady;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'packageId': packageId,
      'packageCode': packageCode,
      'classification': classification,
      'title': title,
      'archiveReady': archiveReady,
    };
  }
}
