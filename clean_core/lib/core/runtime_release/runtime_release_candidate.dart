class RuntimeReleaseCandidate {
  const RuntimeReleaseCandidate({
    required this.candidateId,
    required this.releaseOwnerId,
    required this.auditOwnerId,
    required this.releaseApprovalPlaceholder,
    required this.providerApprovalPlaceholder,
    required this.backendApprovalPlaceholder,
    required this.rollbackReady,
    required this.observabilityReady,
    required this.isolationReady,
  });

  final String candidateId;
  final String releaseOwnerId;
  final String auditOwnerId;
  final String releaseApprovalPlaceholder;
  final String providerApprovalPlaceholder;
  final String backendApprovalPlaceholder;
  final bool rollbackReady;
  final bool observabilityReady;
  final bool isolationReady;

  bool get hasReleaseOwner => releaseOwnerId.trim().isNotEmpty;

  bool get hasAuditOwner => auditOwnerId.trim().isNotEmpty;

  bool get hasReleaseApproval =>
      releaseApprovalPlaceholder.trim().isNotEmpty;

  bool get hasProviderApproval =>
      providerApprovalPlaceholder.trim().isNotEmpty;

  bool get hasBackendApproval => backendApprovalPlaceholder.trim().isNotEmpty;
}
