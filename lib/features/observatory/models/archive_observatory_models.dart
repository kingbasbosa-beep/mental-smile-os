class ArchiveObservatoryProfile {
  const ArchiveObservatoryProfile({
    required this.profileId,
    required this.archiveObjects,
    required this.reportLinks,
  });

  final String profileId;
  final Set<String> archiveObjects;
  final Set<String> reportLinks;
}

class ArchiveObservatoryAlignment {
  const ArchiveObservatoryAlignment({
    required this.archiveReference,
    required this.monitoringReference,
    required this.reportReference,
    required this.observatoryReference,
  });

  final String archiveReference;
  final String monitoringReference;
  final String reportReference;
  final String observatoryReference;
}
