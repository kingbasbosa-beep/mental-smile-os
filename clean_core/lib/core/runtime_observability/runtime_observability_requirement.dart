class RuntimeObservabilityRequirement {
  const RuntimeObservabilityRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.observationOwnerRequired,
    required this.sanitizedObservationRequired,
    required this.backendGovernanceRequired,
    required this.noTelemetryRuntimeRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool observationOwnerRequired;
  final bool sanitizedObservationRequired;
  final bool backendGovernanceRequired;
  final bool noTelemetryRuntimeRequired;

  static const safeDefault = RuntimeObservabilityRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    observationOwnerRequired: true,
    sanitizedObservationRequired: true,
    backendGovernanceRequired: true,
    noTelemetryRuntimeRequired: true,
  );
}
