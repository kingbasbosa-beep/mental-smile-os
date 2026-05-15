import 'runtime_observability_block_reason.dart';
import 'runtime_observability_state.dart';

class RuntimeObservabilityFallback {
  const RuntimeObservabilityFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final RuntimeObservabilityState state;
  final RuntimeObservabilityBlockReason reason;
  final String messageKey;

  static const locked = RuntimeObservabilityFallback(
    state: RuntimeObservabilityState.locked,
    reason: RuntimeObservabilityBlockReason.observabilityLocked,
    messageKey: 'runtime_observability_locked',
  );

  static const blocked = RuntimeObservabilityFallback(
    state: RuntimeObservabilityState.fallbackOnly,
    reason: RuntimeObservabilityBlockReason.observabilityBlocked,
    messageKey: 'runtime_observability_blocked',
  );
}
