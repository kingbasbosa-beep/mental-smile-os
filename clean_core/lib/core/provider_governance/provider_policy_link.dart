class ProviderPolicyLink {
  const ProviderPolicyLink({
    required this.policyPackId,
    required this.policyVersion,
    required this.snapshotId,
    required this.hashPlaceholder,
  });

  final String policyPackId;
  final String policyVersion;
  final String snapshotId;
  final String hashPlaceholder;

  bool get isLinked {
    return policyPackId.trim().isNotEmpty &&
        policyVersion.trim().isNotEmpty &&
        snapshotId.trim().isNotEmpty;
  }

  Map<String, Object?> toMap() {
    return {
      'policyPackId': policyPackId,
      'policyVersion': policyVersion,
      'snapshotId': snapshotId,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
