import 'runtime_environment_profile.dart';
import 'runtime_environment_state.dart';

enum RuntimeEnvironmentBlockReason {
  environmentLocked,
  runtimeModeBlocked,
  providerBlocked,
  backendGovernanceRequired,
  policyVersionMismatch,
  missingSafetyModule,
  auditLinkRequired,
  failClosed,
}

extension RuntimeEnvironmentBlockReasonKey on RuntimeEnvironmentBlockReason {
  String get key {
    switch (this) {
      case RuntimeEnvironmentBlockReason.environmentLocked:
        return 'environment_locked';
      case RuntimeEnvironmentBlockReason.runtimeModeBlocked:
        return 'runtime_mode_blocked';
      case RuntimeEnvironmentBlockReason.providerBlocked:
        return 'provider_blocked';
      case RuntimeEnvironmentBlockReason.backendGovernanceRequired:
        return 'backend_governance_required';
      case RuntimeEnvironmentBlockReason.policyVersionMismatch:
        return 'policy_version_mismatch';
      case RuntimeEnvironmentBlockReason.missingSafetyModule:
        return 'missing_safety_module';
      case RuntimeEnvironmentBlockReason.auditLinkRequired:
        return 'audit_link_required';
      case RuntimeEnvironmentBlockReason.failClosed:
        return 'fail_closed';
    }
  }
}

class RuntimeEnvironmentGuard {
  const RuntimeEnvironmentGuard();

  RuntimeEnvironmentBlockReason? blockReason({
    required RuntimeEnvironmentProfile profile,
    required RuntimeEnvironmentState state,
  }) {
    if (profile.lock.locked) return RuntimeEnvironmentBlockReason.environmentLocked;
    if (profile.restriction.blocksRuntimeMode(state.runtimeMode)) {
      return RuntimeEnvironmentBlockReason.runtimeModeBlocked;
    }
    if (profile.restriction.blocksProvider(state.providerId)) {
      return RuntimeEnvironmentBlockReason.providerBlocked;
    }
    if (profile.restriction.backendGovernanceRequired &&
        !state.backendGoverned) {
      return RuntimeEnvironmentBlockReason.backendGovernanceRequired;
    }
    if (profile.policy.requiredPolicyVersion != state.policyVersion) {
      return RuntimeEnvironmentBlockReason.policyVersionMismatch;
    }
    if (!state.enabledSafetyModules.containsAll(
      profile.policy.requiredSafetyModules,
    )) {
      return RuntimeEnvironmentBlockReason.missingSafetyModule;
    }
    if (profile.policy.auditLinkRequired && !state.auditLinked) {
      return RuntimeEnvironmentBlockReason.auditLinkRequired;
    }
    if (profile.policy.failClosed) return RuntimeEnvironmentBlockReason.failClosed;
    return null;
  }
}
