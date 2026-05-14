class AiRuntimePolicyContract {
  const AiRuntimePolicyContract({
    required this.requiresBackendGovernance,
    required this.requiresSafetyGate,
    required this.requiresOutputValidation,
    required this.allowsDirectUiProviderAccess,
    required this.persistRawPrompt,
  });

  static const AiRuntimePolicyContract safeDefault = AiRuntimePolicyContract(
    requiresBackendGovernance: true,
    requiresSafetyGate: true,
    requiresOutputValidation: true,
    allowsDirectUiProviderAccess: false,
    persistRawPrompt: false,
  );

  final bool requiresBackendGovernance;
  final bool requiresSafetyGate;
  final bool requiresOutputValidation;
  final bool allowsDirectUiProviderAccess;
  final bool persistRawPrompt;
}
