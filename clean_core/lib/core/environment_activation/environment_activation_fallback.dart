import 'environment_activation_block_reason.dart';
import 'environment_activation_state.dart';

class EnvironmentActivationFallback {
  const EnvironmentActivationFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final EnvironmentActivationState state;
  final EnvironmentActivationBlockReason reason;
  final String messageKey;

  static const locked = EnvironmentActivationFallback(
    state: EnvironmentActivationState.locked,
    reason: EnvironmentActivationBlockReason.environmentLocked,
    messageKey: 'environment_activation_locked',
  );

  static const blocked = EnvironmentActivationFallback(
    state: EnvironmentActivationState.fallbackOnly,
    reason: EnvironmentActivationBlockReason.environmentBlocked,
    messageKey: 'environment_activation_blocked',
  );
}
