class RuntimeEnvironmentPolicy {
  const RuntimeEnvironmentPolicy({
    required this.requiredPolicyVersion,
    required this.requiredSafetyModules,
    required this.auditLinkRequired,
    required this.failClosed,
  });

  static const RuntimeEnvironmentPolicy safeDefault = RuntimeEnvironmentPolicy(
    requiredPolicyVersion: '2026-05-os3f',
    requiredSafetyModules: <String>{
      'provider_isolation',
      'audit_tracing',
      'output_validation',
    },
    auditLinkRequired: true,
    failClosed: true,
  );

  final String requiredPolicyVersion;
  final Set<String> requiredSafetyModules;
  final bool auditLinkRequired;
  final bool failClosed;
}
