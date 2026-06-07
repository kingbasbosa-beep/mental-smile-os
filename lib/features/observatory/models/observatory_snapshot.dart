class ObservatorySnapshot {
  const ObservatorySnapshot({
    required this.snapshotId,
    required this.createdAt,
    required this.surfaces,
    required this.healthStatus,
    required this.readinessStatus,
  });

  final String snapshotId;
  final DateTime createdAt;
  final List<String> surfaces;
  final String healthStatus;
  final String readinessStatus;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'snapshotId': snapshotId,
      'createdAt': createdAt.toIso8601String(),
      'surfaces': surfaces,
      'healthStatus': healthStatus,
      'readinessStatus': readinessStatus,
    };
  }
}
