import 'runtime_release_block_reason.dart';
import 'runtime_release_state.dart';

class RuntimeReleaseFallback {
  const RuntimeReleaseFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final RuntimeReleaseState state;
  final RuntimeReleaseBlockReason reason;
  final String messageKey;

  static const locked = RuntimeReleaseFallback(
    state: RuntimeReleaseState.locked,
    reason: RuntimeReleaseBlockReason.releaseLocked,
    messageKey: 'runtime_release_locked',
  );

  static const blocked = RuntimeReleaseFallback(
    state: RuntimeReleaseState.fallbackOnly,
    reason: RuntimeReleaseBlockReason.releaseBlocked,
    messageKey: 'runtime_release_blocked',
  );
}
