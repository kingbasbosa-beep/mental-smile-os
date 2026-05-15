class RuntimeRollbackCandidate {
  const RuntimeRollbackCandidate({
    required this.candidateId,
    required this.rollbackOwnerId,
    required this.governanceOwnerId,
    required this.environmentOwnerId,
    required this.rollbackApprovalPlaceholder,
    required this.providerApprovalPlaceholder,
    required this.backendApprovalPlaceholder,
  });

  final String candidateId;
  final String rollbackOwnerId;
  final String governanceOwnerId;
  final String environmentOwnerId;
  final String rollbackApprovalPlaceholder;
  final String providerApprovalPlaceholder;
  final String backendApprovalPlaceholder;

  bool get hasRollbackOwner => rollbackOwnerId.trim().isNotEmpty;

  bool get hasGovernanceOwner => governanceOwnerId.trim().isNotEmpty;

  bool get hasEnvironmentOwner => environmentOwnerId.trim().isNotEmpty;

  bool get hasRollbackApproval =>
      rollbackApprovalPlaceholder.trim().isNotEmpty;

  bool get hasProviderApproval =>
      providerApprovalPlaceholder.trim().isNotEmpty;

  bool get hasBackendApproval => backendApprovalPlaceholder.trim().isNotEmpty;
}
