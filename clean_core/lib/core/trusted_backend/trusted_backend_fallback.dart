import 'trusted_backend_block_reason.dart';
import 'trusted_backend_state.dart';

class TrustedBackendFallback {
  const TrustedBackendFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const TrustedBackendFallback blocked = TrustedBackendFallback(
    reason: TrustedBackendBlockReason.backendBlocked,
    state: TrustedBackendState.unavailable,
    messageKey: 'trusted_backend_blocked',
  );

  final TrustedBackendBlockReason reason;
  final TrustedBackendState state;
  final String messageKey;
}
