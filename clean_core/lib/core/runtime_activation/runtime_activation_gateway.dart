import 'runtime_activation_block_reason.dart';
import 'runtime_activation_fallback.dart';
import 'runtime_activation_guard.dart';
import 'runtime_activation_lock.dart';
import 'runtime_activation_policy.dart';
import 'runtime_activation_request.dart';
import 'runtime_activation_state.dart';

class RuntimeActivationGateway {
  const RuntimeActivationGateway({
    this.policy = RuntimeActivationPolicy.safeDefault,
    this.lock = RuntimeActivationLock.safeDefault,
    this.guard = const RuntimeActivationGuard(),
  });

  final RuntimeActivationPolicy policy;
  final RuntimeActivationLock lock;
  final RuntimeActivationGuard guard;

  RuntimeActivationResult check(RuntimeActivationRequest request) {
    final reason = guard.blockReason(
      request: request,
      policy: policy,
      lock: lock,
    );

    if (reason != null) {
      return RuntimeActivationResult(
        allowed: false,
        state: RuntimeActivationState.locked,
        fallback: RuntimeActivationFallback(
          state: RuntimeActivationState.fallbackOnly,
          reason: reason,
          messageKey: reason.key,
        ),
      );
    }

    return const RuntimeActivationResult(
      allowed: true,
      state: RuntimeActivationState.activationCandidate,
      fallback: null,
    );
  }
}

class RuntimeActivationResult {
  const RuntimeActivationResult({
    required this.allowed,
    required this.state,
    required this.fallback,
  });

  final bool allowed;
  final RuntimeActivationState state;
  final RuntimeActivationFallback? fallback;
}
