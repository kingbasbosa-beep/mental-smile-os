import 'runtime_policy_fallback.dart';
import 'runtime_policy_mode.dart';
import 'runtime_policy_profile.dart';
import 'runtime_policy_state.dart';

class RuntimePolicyGuard {
  const RuntimePolicyGuard();

  RuntimePolicyFallback? blockReason({
    required RuntimePolicyProfile profile,
    required RuntimePolicyState state,
  }) {
    if (state.mode == RuntimePolicyMode.disabled) {
      return RuntimePolicyFallback(
        reason: RuntimePolicyFallbackReason.runtimeDisabled,
        profileId: profile.profileId,
      );
    }
    if (profile.restriction.blocksMode(state.mode)) {
      return RuntimePolicyFallback(
        reason: RuntimePolicyFallbackReason.blockedMode,
        profileId: profile.profileId,
      );
    }
    if (profile.restriction.blocksProvider(state.providerId)) {
      return RuntimePolicyFallback(
        reason: RuntimePolicyFallbackReason.blockedProvider,
        profileId: profile.profileId,
      );
    }
    if (!profile.hasRequiredModules()) {
      return RuntimePolicyFallback(
        reason: RuntimePolicyFallbackReason.missingSafetyModule,
        profileId: profile.profileId,
      );
    }
    if (profile.requirement.requiresBackendGovernance &&
        !state.backendGoverned) {
      return RuntimePolicyFallback(
        reason: RuntimePolicyFallbackReason.backendGovernanceRequired,
        profileId: profile.profileId,
      );
    }
    if (profile.requirement.requiredPolicyVersion != state.policyVersion) {
      return RuntimePolicyFallback(
        reason: RuntimePolicyFallbackReason.policyVersionMismatch,
        profileId: profile.profileId,
      );
    }
    return null;
  }
}
