import 'secure_runtime_scope.dart';

class SecureRuntimeReference {
  const SecureRuntimeReference({
    required this.referenceId,
    required this.scope,
    required this.hashPlaceholder,
  });

  final String referenceId;
  final SecureRuntimeScope scope;
  final String hashPlaceholder;

  bool get isLinked {
    return referenceId.trim().isNotEmpty && hashPlaceholder.trim().isNotEmpty;
  }

  Map<String, Object?> toMap() {
    return {
      'referenceId': referenceId,
      'scope': scope.key,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
