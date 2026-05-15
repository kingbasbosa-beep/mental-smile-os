class RuntimeBootstrapCandidate {
  const RuntimeBootstrapCandidate({
    required this.candidateId,
    required this.bootstrapOwnerId,
    required this.auditOwnerId,
    required this.bootstrapApprovalPlaceholder,
    required this.releaseApprovalPlaceholder,
    required this.providerStartupApprovalPlaceholder,
    required this.backendStartupApprovalPlaceholder,
    required this.rollbackReady,
    required this.observabilityReady,
    required this.isolationReady,
  });

  final String candidateId;
  final String bootstrapOwnerId;
  final String auditOwnerId;
  final String bootstrapApprovalPlaceholder;
  final String releaseApprovalPlaceholder;
  final String providerStartupApprovalPlaceholder;
  final String backendStartupApprovalPlaceholder;
  final bool rollbackReady;
  final bool observabilityReady;
  final bool isolationReady;

  bool get hasBootstrapOwner => bootstrapOwnerId.trim().isNotEmpty;

  bool get hasAuditOwner => auditOwnerId.trim().isNotEmpty;

  bool get hasBootstrapApproval =>
      bootstrapApprovalPlaceholder.trim().isNotEmpty;

  bool get hasReleaseApproval =>
      releaseApprovalPlaceholder.trim().isNotEmpty;

  bool get hasProviderStartupApproval =>
      providerStartupApprovalPlaceholder.trim().isNotEmpty;

  bool get hasBackendStartupApproval =>
      backendStartupApprovalPlaceholder.trim().isNotEmpty;
}
