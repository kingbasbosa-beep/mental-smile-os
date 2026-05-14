import 'safety_registry_block_reason.dart';
import 'safety_registry_state.dart';

class SafetyRegistryFallback {
  const SafetyRegistryFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const SafetyRegistryFallback locked = SafetyRegistryFallback(
    reason: SafetyRegistryBlockReason.registryLocked,
    state: SafetyRegistryState.locked,
    messageKey: 'safety_registry_locked',
  );

  final SafetyRegistryBlockReason reason;
  final SafetyRegistryState state;
  final String messageKey;
}
