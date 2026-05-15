import 'architecture_manifest_block_reason.dart';
import 'architecture_manifest_state.dart';

class ArchitectureManifestFallback {
  const ArchitectureManifestFallback({
    required this.reason,
    required this.state,
    required this.messageKey,
  });

  static const ArchitectureManifestFallback locked =
      ArchitectureManifestFallback(
    reason: ArchitectureManifestBlockReason.manifestLocked,
    state: ArchitectureManifestState.locked,
    messageKey: 'architecture_manifest_locked',
  );

  final ArchitectureManifestBlockReason reason;
  final ArchitectureManifestState state;
  final String messageKey;
}
