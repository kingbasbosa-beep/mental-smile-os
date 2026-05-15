import 'secure_runtime_block_reason.dart';
import 'secure_runtime_state.dart';

class SecureRuntimeFallback {
  const SecureRuntimeFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const SecureRuntimeFallback sealed = SecureRuntimeFallback(
    reason: SecureRuntimeBlockReason.runtimeSealed,
    state: SecureRuntimeState.sealed,
    messageKey: 'secure_runtime_sealed',
  );

  final SecureRuntimeBlockReason reason;
  final SecureRuntimeState state;
  final String messageKey;
}
