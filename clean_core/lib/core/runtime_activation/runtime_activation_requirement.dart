class RuntimeActivationRequirement {
  const RuntimeActivationRequirement({
    required this.signedAuthorityRequired,
    required this.policyLinkRequired,
    required this.auditLinkRequired,
    required this.reviewMarkerRequired,
    required this.runtimeMarkerRequired,
    required this.governanceReferenceRequired,
    required this.readinessVerificationRequired,
    required this.secureEnvelopeVerificationRequired,
    required this.providerGovernanceVerificationRequired,
  });

  final bool signedAuthorityRequired;
  final bool policyLinkRequired;
  final bool auditLinkRequired;
  final bool reviewMarkerRequired;
  final bool runtimeMarkerRequired;
  final bool governanceReferenceRequired;
  final bool readinessVerificationRequired;
  final bool secureEnvelopeVerificationRequired;
  final bool providerGovernanceVerificationRequired;

  static const safeDefault = RuntimeActivationRequirement(
    signedAuthorityRequired: true,
    policyLinkRequired: true,
    auditLinkRequired: true,
    reviewMarkerRequired: true,
    runtimeMarkerRequired: true,
    governanceReferenceRequired: true,
    readinessVerificationRequired: true,
    secureEnvelopeVerificationRequired: true,
    providerGovernanceVerificationRequired: true,
  );
}
