import 'governance_compliance_scope.dart';

class GovernanceComplianceReference {
  const GovernanceComplianceReference({
    required this.referenceId,
    required this.scope,
    required this.hashPlaceholder,
  });

  final String referenceId;
  final GovernanceComplianceScope scope;
  final String hashPlaceholder;

  Map<String, Object?> toMap() {
    return {
      'referenceId': referenceId,
      'scope': scope.key,
      'hashPlaceholder': hashPlaceholder,
    };
  }
}
