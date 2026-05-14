import 'runtime_environment_lock.dart';
import 'runtime_environment_marker.dart';
import 'runtime_environment_policy.dart';
import 'runtime_environment_profile.dart';
import 'runtime_environment_restriction.dart';
import 'runtime_environment_scope.dart';
import 'runtime_environment_type.dart';

class RuntimeEnvironmentDefaults {
  const RuntimeEnvironmentDefaults._();

  static const RuntimeEnvironmentProfile fallbackOnly =
      RuntimeEnvironmentProfile(
    profileId: 'fallback_only_safe_default',
    environmentType: RuntimeEnvironmentType.fallbackOnly,
    marker: RuntimeEnvironmentMarker(
      environmentType: RuntimeEnvironmentType.fallbackOnly,
      scope: RuntimeEnvironmentScope.aiRuntime,
      runtimeMode: 'disabled_placeholder',
      policyVersion: '2026-05-os3f',
    ),
    restriction: RuntimeEnvironmentRestriction.safeDefault,
    policy: RuntimeEnvironmentPolicy.safeDefault,
    lock: RuntimeEnvironmentLock.safeDefault,
  );
}
