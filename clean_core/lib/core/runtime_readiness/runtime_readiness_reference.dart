import 'runtime_readiness_scope.dart';

class RuntimeReadinessReference {
  const RuntimeReadinessReference({
    required this.referenceId,
    required this.scope,
    required this.hashPlaceholder,
  });

  final String referenceId;
  final RuntimeReadinessScope scope;
  final String hashPlaceholder;

  bool get isLinked {
    return referenceId.trim().isNotEmpty && hashPlaceholder.trim().isNotEmpty;
  }
}
