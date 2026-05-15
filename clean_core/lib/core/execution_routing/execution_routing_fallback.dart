import 'execution_routing_block_reason.dart';
import 'execution_routing_state.dart';

class ExecutionRoutingFallback {
  const ExecutionRoutingFallback({
    required this.state,
    required this.reason,
    required this.messageKey,
  });

  final ExecutionRoutingState state;
  final ExecutionRoutingBlockReason reason;
  final String messageKey;

  static const locked = ExecutionRoutingFallback(
    state: ExecutionRoutingState.locked,
    reason: ExecutionRoutingBlockReason.routingLocked,
    messageKey: 'execution_routing_locked',
  );

  static const blocked = ExecutionRoutingFallback(
    state: ExecutionRoutingState.fallbackOnly,
    reason: ExecutionRoutingBlockReason.routingBlocked,
    messageKey: 'execution_routing_blocked',
  );
}
