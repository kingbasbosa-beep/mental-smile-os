import 'runtime_activation_block_reason.dart';
import 'runtime_activation_state.dart';

class RuntimeActivationFallback {
  const RuntimeActivationFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final RuntimeActivationState state;
  final RuntimeActivationBlockReason reason;
  final String messageKey;

  static const locked = RuntimeActivationFallback(
    state: RuntimeActivationState.locked,
    reason: RuntimeActivationBlockReason.activationLocked,
    messageKey: 'runtime_activation_locked',
  );

  static const blocked = RuntimeActivationFallback(
    state: RuntimeActivationState.fallbackOnly,
    reason: RuntimeActivationBlockReason.activationBlocked,
    messageKey: 'runtime_activation_blocked',
  );
}
