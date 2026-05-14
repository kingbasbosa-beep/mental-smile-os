import 'runtime_environment_defaults.dart';
import 'runtime_environment_guard.dart';
import 'runtime_environment_profile.dart';
import 'runtime_environment_state.dart';

class RuntimeEnvironmentResolution {
  const RuntimeEnvironmentResolution({
    required this.profile,
    required this.allowed,
    required this.blockReason,
  });

  final RuntimeEnvironmentProfile profile;
  final bool allowed;
  final RuntimeEnvironmentBlockReason? blockReason;
}

class RuntimeEnvironmentResolver {
  const RuntimeEnvironmentResolver({
    this.guard = const RuntimeEnvironmentGuard(),
  });

  final RuntimeEnvironmentGuard guard;

  RuntimeEnvironmentResolution resolve({
    RuntimeEnvironmentProfile profile = RuntimeEnvironmentDefaults.fallbackOnly,
    RuntimeEnvironmentState state = RuntimeEnvironmentState.safeDefault,
  }) {
    final reason = guard.blockReason(profile: profile, state: state);
    return RuntimeEnvironmentResolution(
      profile: profile,
      allowed: reason == null,
      blockReason: reason,
    );
  }
}
