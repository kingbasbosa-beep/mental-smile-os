class RuntimeEnablementCandidate {
  const RuntimeEnablementCandidate({
    required this.candidateId,
    required this.governanceOwnerId,
    required this.runtimeOwnerId,
    required this.backendApprovalPlaceholder,
    required this.providerApprovalPlaceholder,
    required this.rollbackOwnerId,
  });

  final String candidateId;
  final String governanceOwnerId;
  final String runtimeOwnerId;
  final String backendApprovalPlaceholder;
  final String providerApprovalPlaceholder;
  final String rollbackOwnerId;

  bool get hasGovernanceOwnership => governanceOwnerId.trim().isNotEmpty;

  bool get hasBackendApproval => backendApprovalPlaceholder.trim().isNotEmpty;

  bool get hasProviderApproval => providerApprovalPlaceholder.trim().isNotEmpty;

  bool get hasRollbackOwner => rollbackOwnerId.trim().isNotEmpty;
}
