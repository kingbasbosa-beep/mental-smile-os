import 'runtime_wiring_block_reason.dart';
import 'runtime_wiring_state.dart';

class RuntimeWiringFallback {
  const RuntimeWiringFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final RuntimeWiringState state;
  final RuntimeWiringBlockReason reason;
  final String messageKey;

  static const locked = RuntimeWiringFallback(
    state: RuntimeWiringState.locked,
    reason: RuntimeWiringBlockReason.wiringLocked,
    messageKey: 'runtime_wiring_locked',
  );

  static const blocked = RuntimeWiringFallback(
    state: RuntimeWiringState.fallbackOnly,
    reason: RuntimeWiringBlockReason.wiringBlocked,
    messageKey: 'runtime_wiring_blocked',
  );
}
