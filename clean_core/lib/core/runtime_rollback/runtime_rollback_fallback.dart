import 'runtime_rollback_block_reason.dart';
import 'runtime_rollback_state.dart';

class RuntimeRollbackFallback {
  const RuntimeRollbackFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final RuntimeRollbackState state;
  final RuntimeRollbackBlockReason reason;
  final String messageKey;

  static const locked = RuntimeRollbackFallback(
    state: RuntimeRollbackState.locked,
    reason: RuntimeRollbackBlockReason.rollbackLocked,
    messageKey: 'runtime_rollback_locked',
  );

  static const blocked = RuntimeRollbackFallback(
    state: RuntimeRollbackState.fallbackOnly,
    reason: RuntimeRollbackBlockReason.rollbackBlocked,
    messageKey: 'runtime_rollback_blocked',
  );
}
