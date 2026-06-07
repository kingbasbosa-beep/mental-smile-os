class StorageHealthSnapshot {
  const StorageHealthSnapshot({
    required this.checkedAt,
    required this.storageContractsAvailable,
    required this.registryAvailable,
    required this.boundaryAvailable,
    required this.notes,
  });

  final DateTime checkedAt;
  final bool storageContractsAvailable;
  final bool registryAvailable;
  final bool boundaryAvailable;
  final List<String> notes;
}

class StorageReadinessSnapshot {
  const StorageReadinessSnapshot({
    required this.checkedAt,
    required this.readyForReports,
    required this.readyForArchive,
    required this.readyForRendering,
    required this.blockers,
  });

  final DateTime checkedAt;
  final bool readyForReports;
  final bool readyForArchive;
  final bool readyForRendering;
  final List<String> blockers;
}
