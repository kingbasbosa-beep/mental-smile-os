import 'architecture_manifest_reference.dart';
import 'architecture_manifest_state.dart';

class ArchitectureManifestEntry {
  const ArchitectureManifestEntry({
    required this.entryId,
    required this.state,
    required this.reference,
    required this.sealed,
  });

  final String entryId;
  final ArchitectureManifestState state;
  final ArchitectureManifestReference reference;
  final bool sealed;

  bool get isValid {
    return entryId.trim().isNotEmpty && reference.isLinked && sealed;
  }
}
