class RuntimePolicySnapshotReference {
  const RuntimePolicySnapshotReference({
    required this.snapshotId,
    required this.policyVersion,
    required this.hashPlaceholder,
  });

  final String snapshotId;
  final String policyVersion;
  final String hashPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'snapshotId': snapshotId,
      'policyVersion': policyVersion,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
