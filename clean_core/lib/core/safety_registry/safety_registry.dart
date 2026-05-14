import 'safety_registry_block_reason.dart';
import 'safety_registry_entry.dart';
import 'safety_registry_fallback.dart';
import 'safety_registry_guard.dart';
import 'safety_registry_policy.dart';
import 'safety_registry_state.dart';

class SafetyRegistryResult {
  const SafetyRegistryResult({
    required this.allowed,
    required this.state,
    required this.fallback,
  });

  final bool allowed;
  final SafetyRegistryState state;
  final SafetyRegistryFallback? fallback;
}

class SafetyRegistry {
  const SafetyRegistry({
    this.policy = SafetyRegistryPolicy.safeDefault,
    this.guard = const SafetyRegistryGuard(),
  });

  final SafetyRegistryPolicy policy;
  final SafetyRegistryGuard guard;

  SafetyRegistryResult check(SafetyRegistryEntry entry) {
    final reason = guard.blockReason(policy: policy, entry: entry);
    if (reason != null) {
      return SafetyRegistryResult(
        allowed: false,
        state: SafetyRegistryState.locked,
        fallback: SafetyRegistryFallback(
          reason: reason,
          state: SafetyRegistryState.locked,
          messageKey: reason.key,
        ),
      );
    }
    return SafetyRegistryResult(
      allowed: true,
      state: entry.state,
      fallback: null,
    );
  }
}
