import 'governance_lifecycle_block_reason.dart';
import 'governance_lifecycle_state.dart';

class GovernanceLifecycleFallback {
  const GovernanceLifecycleFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const GovernanceLifecycleFallback locked =
      GovernanceLifecycleFallback(
    reason: GovernanceLifecycleBlockReason.locked,
    state: GovernanceLifecycleState.locked,
    messageKey: 'governance_lifecycle_locked',
  );

  final GovernanceLifecycleBlockReason reason;
  final GovernanceLifecycleState state;
  final String messageKey;
}
