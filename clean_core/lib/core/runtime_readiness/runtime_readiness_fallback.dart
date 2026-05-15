import 'runtime_readiness_block_reason.dart';
import 'runtime_readiness_state.dart';

class RuntimeReadinessFallback {
  const RuntimeReadinessFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const RuntimeReadinessFallback locked = RuntimeReadinessFallback(
    reason: RuntimeReadinessBlockReason.readinessLocked,
    state: RuntimeReadinessState.locked,
    messageKey: 'runtime_readiness_locked',
  );

  final RuntimeReadinessBlockReason reason;
  final RuntimeReadinessState state;
  final String messageKey;
}
