enum RuntimePolicyFallbackReason {
  runtimeDisabled,
  blockedProvider,
  blockedMode,
  missingSafetyModule,
  backendGovernanceRequired,
  policyVersionMismatch,
  failClosed,
}

extension RuntimePolicyFallbackReasonKey on RuntimePolicyFallbackReason {
  String get key {
    switch (this) {
      case RuntimePolicyFallbackReason.runtimeDisabled:
        return 'runtime_disabled';
      case RuntimePolicyFallbackReason.blockedProvider:
        return 'blocked_provider';
      case RuntimePolicyFallbackReason.blockedMode:
        return 'blocked_mode';
      case RuntimePolicyFallbackReason.missingSafetyModule:
        return 'missing_safety_module';
      case RuntimePolicyFallbackReason.backendGovernanceRequired:
        return 'backend_governance_required';
      case RuntimePolicyFallbackReason.policyVersionMismatch:
        return 'policy_version_mismatch';
      case RuntimePolicyFallbackReason.failClosed:
        return 'fail_closed';
    }
  }
}

class RuntimePolicyFallback {
  const RuntimePolicyFallback({
    required this.reason,
    required this.profileId,
  });

  final RuntimePolicyFallbackReason reason;
  final String profileId;
}
