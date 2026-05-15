import 'governance_federation_block_reason.dart';
import 'governance_federation_state.dart';

class GovernanceFederationFallback {
  const GovernanceFederationFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const GovernanceFederationFallback locked =
      GovernanceFederationFallback(
    reason: GovernanceFederationBlockReason.federationLocked,
    state: GovernanceFederationState.locked,
    messageKey: 'governance_federation_locked',
  );

  final GovernanceFederationBlockReason reason;
  final GovernanceFederationState state;
  final String messageKey;
}
