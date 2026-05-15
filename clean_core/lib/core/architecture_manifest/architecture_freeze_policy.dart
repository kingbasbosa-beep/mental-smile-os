class ArchitectureFreezePolicy {
  const ArchitectureFreezePolicy({
    required this.runtimeActivationBlocked,
    required this.providerActivationBlocked,
    required this.backendOrchestrationBlocked,
    required this.integrationReviewRequired,
    required this.extractionBlocked,
  });

  static const ArchitectureFreezePolicy safeDefault = ArchitectureFreezePolicy(
    runtimeActivationBlocked: true,
    providerActivationBlocked: true,
    backendOrchestrationBlocked: true,
    integrationReviewRequired: true,
    extractionBlocked: true,
  );

  final bool runtimeActivationBlocked;
  final bool providerActivationBlocked;
  final bool backendOrchestrationBlocked;
  final bool integrationReviewRequired;
  final bool extractionBlocked;
}
