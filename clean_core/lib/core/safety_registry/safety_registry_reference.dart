import 'safety_registry_scope.dart';

class SafetyRegistryReference {
  const SafetyRegistryReference({
    required this.referenceId,
    required this.scope,
    required this.hashPlaceholder,
  });

  final String referenceId;
  final SafetyRegistryScope scope;
  final String hashPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'referenceId': referenceId,
      'scope': scope.key,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
