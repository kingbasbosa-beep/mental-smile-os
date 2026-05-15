import 'runtime_release_scope.dart';

class RuntimeReleaseReference {
  const RuntimeReleaseReference({
    required this.referenceId,
    required this.scope,
    this.hashPlaceholder,
  });

  final String referenceId;
  final RuntimeReleaseScope scope;
  final String? hashPlaceholder;

  bool get isLinked => referenceId.trim().isNotEmpty;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'referenceId': referenceId,
      'scope': scope.key,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
