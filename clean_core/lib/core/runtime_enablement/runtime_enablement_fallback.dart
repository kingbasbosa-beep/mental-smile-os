import 'runtime_enablement_block_reason.dart';
import 'runtime_enablement_state.dart';

class RuntimeEnablementFallback {
  const RuntimeEnablementFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final RuntimeEnablementState state;
  final RuntimeEnablementBlockReason reason;
  final String messageKey;

  static const locked = RuntimeEnablementFallback(
    state: RuntimeEnablementState.locked,
    reason: RuntimeEnablementBlockReason.enablementLocked,
    messageKey: 'runtime_enablement_locked',
  );

  static const blocked = RuntimeEnablementFallback(
    state: RuntimeEnablementState.fallbackOnly,
    reason: RuntimeEnablementBlockReason.enablementBlocked,
    messageKey: 'runtime_enablement_blocked',
  );
}
