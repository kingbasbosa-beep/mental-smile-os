import 'governance_capability_block_reason.dart';
import 'governance_capability_state.dart';

class GovernanceCapabilityFallback {
  const GovernanceCapabilityFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const GovernanceCapabilityFallback blocked =
      GovernanceCapabilityFallback(
    reason: GovernanceCapabilityBlockReason.capabilityBlocked,
    state: GovernanceCapabilityState.unavailable,
    messageKey: 'governance_capability_blocked',
  );

  final GovernanceCapabilityBlockReason reason;
  final GovernanceCapabilityState state;
  final String messageKey;
}
