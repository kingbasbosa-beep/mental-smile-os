class ObservatorySignalRegistry {
  const ObservatorySignalRegistry._();

  static const String observatorySnapshotCreated =
      'observatory_snapshot_created';
  static const String observatorySurfaceRegistered =
      'observatory_surface_registered';
  static const String observatoryDependencyDefined =
      'observatory_dependency_defined';
  static const String observatoryReadinessUpdated =
      'observatory_readiness_updated';

  static const Set<String> values = <String>{
    observatorySnapshotCreated,
    observatorySurfaceRegistered,
    observatoryDependencyDefined,
    observatoryReadinessUpdated,
  };
}
