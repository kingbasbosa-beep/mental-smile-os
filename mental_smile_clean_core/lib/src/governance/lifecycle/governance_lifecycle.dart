import 'governance_lifecycle_block_reason.dart';
import 'governance_lifecycle_fallback.dart';
import 'governance_lifecycle_guard.dart';
import 'governance_lifecycle_lock.dart';
import 'governance_lifecycle_policy.dart';
import 'governance_lifecycle_state.dart';
import 'governance_lifecycle_transition.dart';

class GovernanceLifecycleResult {
  const GovernanceLifecycleResult({
    required this.allowed,
    required this.state,
    required this.fallback,
  });

  final bool allowed;
  final GovernanceLifecycleState state;
  final GovernanceLifecycleFallback? fallback;
}

class GovernanceLifecycle {
  const GovernanceLifecycle({
    this.guard = const GovernanceLifecycleGuard(),
  });

  final GovernanceLifecycleGuard guard;

  GovernanceLifecycleResult check({
    required GovernanceLifecycleTransition transition,
    GovernanceLifecyclePolicy policy = GovernanceLifecyclePolicy.safeDefault,
    GovernanceLifecycleLock lock = GovernanceLifecycleLock.safeDefault,
  }) {
    final reason = guard.blockReason(
      transition: transition,
      policy: policy,
      lock: lock,
    );
    if (reason != null) {
      return GovernanceLifecycleResult(
        allowed: false,
        state: GovernanceLifecycleState.locked,
        fallback: GovernanceLifecycleFallback(
          reason: reason,
          state: GovernanceLifecycleState.locked,
          messageKey: reason.key,
        ),
      );
    }
    return GovernanceLifecycleResult(
      allowed: true,
      state: transition.toState,
      fallback: null,
    );
  }
}
