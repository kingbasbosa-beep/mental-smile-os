import 'system_topology_block_reason.dart';
import 'system_topology_state.dart';

class SystemTopologyFallback {
  const SystemTopologyFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const SystemTopologyFallback locked = SystemTopologyFallback(
    reason: SystemTopologyBlockReason.topologyLocked,
    state: SystemTopologyState.locked,
    messageKey: 'system_topology_locked',
  );

  final SystemTopologyBlockReason reason;
  final SystemTopologyState state;
  final String messageKey;
}
