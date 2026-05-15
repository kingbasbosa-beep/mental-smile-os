import 'architecture_manifest_scope.dart';

class ArchitectureManifestReference {
  const ArchitectureManifestReference({
    required this.referenceId,
    required this.scope,
    required this.pathHint,
    required this.hashPlaceholder,
  });

  final String referenceId;
  final ArchitectureManifestScope scope;
  final String pathHint;
  final String hashPlaceholder;

  bool get isLinked {
    return referenceId.trim().isNotEmpty &&
        pathHint.trim().isNotEmpty &&
        hashPlaceholder.trim().isNotEmpty;
  }
}
