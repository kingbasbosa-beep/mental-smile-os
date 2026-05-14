class ResponsePolicyLink {
  const ResponsePolicyLink({
    required this.policyVersion,
    required this.snapshotId,
    required this.hashPlaceholder,
  });

  final String policyVersion;
  final String snapshotId;
  final String hashPlaceholder;

  bool get isLinked {
    return policyVersion.trim().isNotEmpty && snapshotId.trim().isNotEmpty;
  }

  Map<String, Object?> toMap() {
    return {
      'policyVersion': policyVersion,
      'snapshotId': snapshotId,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
