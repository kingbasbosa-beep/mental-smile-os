class EscalationPolicyReference {
  const EscalationPolicyReference({
    required this.policyVersion,
    required this.snapshotId,
    required this.hashPlaceholder,
  });

  final String policyVersion;
  final String snapshotId;
  final String hashPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'policyVersion': policyVersion,
      'snapshotId': snapshotId,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
