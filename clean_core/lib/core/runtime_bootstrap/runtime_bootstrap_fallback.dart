import 'runtime_bootstrap_block_reason.dart';
import 'runtime_bootstrap_state.dart';

class RuntimeBootstrapFallback {
  const RuntimeBootstrapFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final RuntimeBootstrapState state;
  final RuntimeBootstrapBlockReason reason;
  final String messageKey;

  static const locked = RuntimeBootstrapFallback(
    state: RuntimeBootstrapState.locked,
    reason: RuntimeBootstrapBlockReason.bootstrapLocked,
    messageKey: 'runtime_bootstrap_locked',
  );

  static const blocked = RuntimeBootstrapFallback(
    state: RuntimeBootstrapState.fallbackOnly,
    reason: RuntimeBootstrapBlockReason.bootstrapBlocked,
    messageKey: 'runtime_bootstrap_blocked',
  );
}
