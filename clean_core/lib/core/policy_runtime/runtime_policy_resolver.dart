import 'runtime_policy_fallback.dart';
import 'runtime_policy_guard.dart';
import 'runtime_policy_pack.dart';
import 'runtime_policy_profile.dart';
import 'runtime_policy_state.dart';

class RuntimePolicyResolution {
  const RuntimePolicyResolution({
    required this.profile,
    required this.allowed,
    required this.fallback,
  });

  final RuntimePolicyProfile profile;
  final bool allowed;
  final RuntimePolicyFallback? fallback;
}

class RuntimePolicyResolver {
  const RuntimePolicyResolver({
    this.guard = const RuntimePolicyGuard(),
  });

  final RuntimePolicyGuard guard;

  RuntimePolicyResolution resolve({
    required RuntimePolicyPack pack,
    required RuntimePolicyState state,
    String profileId = '',
  }) {
    final profile = profileId.trim().isEmpty
        ? pack.defaultProfile
        : pack.profileById(profileId);
    final fallback = guard.blockReason(profile: profile, state: state);

    if (fallback != null) {
      return RuntimePolicyResolution(
        profile: pack.defaultProfile,
        allowed: false,
        fallback: fallback,
      );
    }

    return RuntimePolicyResolution(
      profile: profile,
      allowed: !profile.failClosed,
      fallback: profile.failClosed
          ? RuntimePolicyFallback(
              reason: RuntimePolicyFallbackReason.failClosed,
              profileId: profile.profileId,
            )
          : null,
    );
  }
}
