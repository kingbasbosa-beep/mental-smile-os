import 'runtime_activation_scope.dart';

class RuntimeActivationReference {
  const RuntimeActivationReference({
    required this.referenceId,
    required this.scope,
    this.hashPlaceholder,
  });

  final String referenceId;
  final RuntimeActivationScope scope;
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
