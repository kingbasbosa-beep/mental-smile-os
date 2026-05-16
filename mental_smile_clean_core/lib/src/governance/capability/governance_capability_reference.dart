import 'governance_capability_scope.dart';

class GovernanceCapabilityReference {
  const GovernanceCapabilityReference({
    required this.referenceId,
    required this.scope,
    required this.hashPlaceholder,
  });

  final String referenceId;
  final GovernanceCapabilityScope scope;
  final String hashPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'referenceId': referenceId,
      'scope': scope.key,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
