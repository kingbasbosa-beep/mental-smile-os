import 'runtime_isolation_block_reason.dart';
import 'runtime_isolation_state.dart';

class RuntimeIsolationFallback {
  const RuntimeIsolationFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final RuntimeIsolationState state;
  final RuntimeIsolationBlockReason reason;
  final String messageKey;

  static const locked = RuntimeIsolationFallback(
    state: RuntimeIsolationState.locked,
    reason: RuntimeIsolationBlockReason.isolationLocked,
    messageKey: 'runtime_isolation_locked',
  );

  static const blocked = RuntimeIsolationFallback(
    state: RuntimeIsolationState.fallbackOnly,
    reason: RuntimeIsolationBlockReason.isolationBlocked,
    messageKey: 'runtime_isolation_blocked',
  );
}
