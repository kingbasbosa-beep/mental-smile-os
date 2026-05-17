/// Passive escalation policy reference metadata.
///
/// Policy references are metadata only. `policyVersion` does not enforce or
/// approve policy, `snapshotId` does not prove immutability, and
/// `hashPlaceholder` is not security or integrity proof.
class EscalationPolicyReference {
  const EscalationPolicyReference({
    required this.policyVersion,
    required this.snapshotId,
    required this.hashPlaceholder,
  });

  final String policyVersion;
  final String snapshotId;
  final String hashPlaceholder;
}
